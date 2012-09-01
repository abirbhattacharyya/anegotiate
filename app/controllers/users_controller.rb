require 'json'
require 'hpricot'


class UsersController < ApplicationController
  before_filter :check_login, :only => [:invite, :style, :search]
  before_filter :check_notification, :only => [:invite, :search]
  before_filter :check_style, :only => [:invite, :search]
  
  def create
      @request_token = UsersController.consumer.get_request_token( :oauth_callback => "http://www.localhost:3000/callback" )
      session[:request_token] = @request_token.token
      session[:request_token_secret] = @request_token.secret
      # Send to twitter.com to authorize
      redirect_to @request_token.authorize_url
      return
  end

  def self.consumer
      # The readkey and readsecret below are the values you get during registration
      OAuth::Consumer.new("zVtGXzdJw5rVY1imubgbQ",
      "BHyPG9MFhwUSo86Hx8ttRLSiLjd3wL5gBfmGmGUhu2M",
      { :site=>"http://twitter.com" })
  end
  
  def callback
      @request_token = OAuth::RequestToken.new(
        UsersController.consumer,
        session[:request_token],
        session[:request_token_secret])
      # Exchange the request token for an access token.
      
      @access_token = @request_token.get_access_token( :oauth_verifier => params[:oauth_verifier])
      @response = UsersController.consumer.request(:get, '/account/verify_credentials.json',
      @access_token, { :scheme => :query_string })
      case @response
      when Net::HTTPSuccess
      user_info = JSON.parse(@response.body)
      unless user_info['screen_name']
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
      end
      # We have an authorized user, save the information to the database.
      if User.find_by_screen_name(user_info['screen_name'])
          @user = User.find_by_screen_name(user_info['screen_name'])
          if @user.style
              @last_task = AttemptedTask.find(:last, :conditions => ["user_id=#{@user.id}"], :order => "updated_at")
              if(@last_task)
                  if(@last_task.updated_at.utc < (Time.now.utc - 1.hour))
                      if @user.energy < min_energy(@user)
                          energy = (@user.max_energy)
                          @user.update_attribute("energy", energy)
                      end
                  end
              end
          end
          @access_tokens = OAuth::AccessToken.new(UsersController.consumer, @user.token, @user.secret)
          @response1 = UsersController.consumer.request(:post, "/friendships/create/anegotiate.json",@access_tokens,
          { :scheme => :query_string}, :follow => true )
          case @response1
              when Net::HTTPSuccess
                  #flash[:notice] = "You now follows Twedeal"
              else
                  #flash[:notice] = "Error #{@response1.body}"
          end
      else
          @user = User.new({ :screen_name => user_info['screen_name'],
          :token => @access_token.token,
          :secret => @access_token.secret })
          @user.points = rand(90) + 10
          @user.energy = (2*friends(@user).size)
          @user = fetch_profile_data(@user)
          @user.save!
          
          msg = "I have just started using #{root_url} application. It's great!!"
          @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
          RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"

          @response = UsersController.consumer.request(:post, "/statuses/update.xml",@access_token,
          { :scheme => :query_string}, :status => msg )
          case @response
              when Net::HTTPSuccess
                 # flash[:notice] = "Twitter status updated successfully"
              else
                 # flash[:notice] = "Twitter update failed.... "
          end
          
          @response1 = UsersController.consumer.request(:post, "/friendships/create/anegotiate.json",@access_token,
          { :scheme => :query_string}, :follow => true )
          case @response1
              when Net::HTTPSuccess
                  #flash[:notice] = "You now follows Anegotiate"
              else
                  #flash[:notice] = "Error #{@response1.body}"
          end
          
      end
      session[:user_id] = @user.id
      # Redirect to the show page
      redirect_to root_path
      else
      RAILS_DEFAULT_LOGGER.error "Failed to get user info via OAuth"
      # The user might have rejected this application. Or there was some other error during the request.
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
      end
  end

  def show
      @user = User.find(params[:id])
      # Get this users favorites via OAuth
      @access_token = OAuth::AccessToken.new(UsersController.consumer, @user.token, @user.secret)
      RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{@user.inspect} with #{@access_token.inspect}"
      @response = UsersController.consumer.request(:get, '/favorites.json', @access_token,
      { :scheme => :query_string })
      case @response
      when Net::HTTPSuccess
      @favorites = JSON.parse(@response.body)
      respond_to do |format|
      format.html # show.html.erb
      end
      else
      RAILS_DEFAULT_LOGGER.error "Failed to get favorites via OAuth for #{@user}"
      # The user might have rejected this application. Or there was some other error during the request.
      flash[:notice] = "Authentication failed"
      redirect_to :action => :index
      return
      end
  end
  
  def invite
    if current_user.facebook_user?
        #:TODO do something
    else
        @screen_names = Array.new
        @profile_image_url = Array.new
        
#        @xml_data = open("http://twitter.com/users/ror_rocks.xml").read
#        @xml_data += open("http://twitter.com/users/dhavalp.xml").read
#        @xml_data += open("http://twitter.com/users/abirb123.xml").read
#        @xml_data += open("http://twitter.com/users/ankitbp.xml").read
#        @xml_data += open("http://twitter.com/users/chetanpanchal.xml").read
#        @xml_data += open("http://twitter.com/users/brijeshshah.xml").read
#        @data = Hpricot::XML(@xml_data)
#        (@data/:user).each do |status|
#            @screen_names.push(status.at('screen_name').innerHTML) if status.at('screen_name')
#            @profile_image_url.push(status.at('profile_image_url').innerHTML) if status.at('screen_name')
#        end
        
        @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
        RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"
        
        @response = UsersController.consumer.request(:get, '/statuses/followers.xml', @access_token,
        { :scheme => :query_string })
        case @response
            when Net::HTTPSuccess
                @data = Hpricot::XML(@response.body)
                (@data/:user).each do |status|
                    @screen_names.push(status.at('screen_name').innerHTML) if status.at('screen_name')
                    @profile_image_url.push(status.at('profile_image_url').innerHTML) if status.at('screen_name')
                end
            else
                RAILS_DEFAULT_LOGGER.error "Failed to get favorites via OAuth for #{@user}"
                # The user might have rejected this application. Or there was some other error during the request.
                #flash[:notice] = "Authentication failed"
        end
    end
  end
  
  def invite_to
      invite = params[:invite]
      cnt = 0
      for user in invite
        if user[1].to_i == 1
            cnt = 1
            user[0].match(/twitter_(.*?)_select/)
            screen_name = $1
            spawn do
                direct_message(screen_name)
            end
        end
      end
      if cnt == 0
        flash[:notice] = "Please select a friend to invite"
        redirect_to invite_path
      else
        flash[:notice] = "Invitation Sent Successfully"
        redirect_to root_path
      end
  end
  
  def direct_message(recipient)
        #recipient = params[:screen_name]
        msg = " has invited you at http://www.anegotiate.com"
        @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
        RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"

        @response = UsersController.consumer.request(:post, "/direct_messages/new.xml",@access_token,
        { :scheme => :query_string}, :text => msg, :user => recipient )
        case @response
            when Net::HTTPSuccess
                flash[:notice] = "Invitation sent successfully"
            else
                flash[:notice] = "Invitation sending failed.... "
        end
  end
  
  def search
      if params[:user]
          @flag = true
          if params[:user].blank?
              flash[:notice] = "Hey, please enter an opponent" 
          else
              @users = User.find(:all, :conditions => ["id!=#{current_user.id} and screen_name like '%%#{params[:user]}%%' and fb_uid is #{current_user.facebook_user? ? "not null" : "null"}"])
          end
      else
          @flag = false
          @users = User.find(:all, :conditions => ["id!=#{current_user.id} and fb_uid is #{current_user.facebook_user? ? "not null" : "null"}"], :order => "rand()", :limit => 5)
      end
  end
  
  def style
      if params[:style]
          @style = params[:style]
          first_time = false
          first_time = true if current_user.style.nil?
          energy = (@style == 'Aggressive' ? 500 : @style == 'Neutral' ? 250 : 125)
          current_user.update_attribute("style", @style)
          current_user.update_attribute("energy", energy)
          if first_time == true
              redirect_to notifications_path
          else
              redirect_to root_path
          end
      end
  end

  # GET /users
  # GET /users.xml
  def index
    @users = User.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  def sign_in
      if logged_in?
        redirect_to root_path
      end
  end
  
  def link_user_accounts
    if self.current_user.nil?
      #register with fb
      User.create_from_fb_connect(facebook_session.user)
    else
      #connect accounts
      self.current_user.link_fb_connect(facebook_session.user.id) unless self.current_user.fb_uid == facebook_session.user.id
    end
    if current_user.style
        @last_task = AttemptedTask.find(:last, :conditions => ["user_id=#{current_user.id}"], :order => "updated_at")
        if @last_task
            if(@last_task.updated_at.utc < (Time.now.utc - 1.hour))
                if current_user.energy < min_energy(current_user)
                    energy = current_user.max_energy
                    current_user.update_attribute("energy", energy)
                end
            end
        end
    end
    redirect_to root_path
  end

  def destroy
    logout_killing_session!
    session[:user_id] = nil
    session[:facebook_session] = nil
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

end

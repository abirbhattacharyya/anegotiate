# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.
require 'open-uri'
require 'json'

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  include AuthenticatedSystem # logged_in? and current_user
  include ApplicationHelper

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => 'bfdb01c4caefa4ee37c9db229eae20c2'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password

  before_filter :set_facebook_session
  helper_method :facebook_session

  #CGI::Session.expire_after(2)
  
  def check_login
      unless logged_in?
          flash[:notice] = "Please login first"
          redirect_to root_path 
      else
          if current_user.facebook_user?
              begin
                  facebook_session.user.name
              rescue Facebooker::Session::SessionExpired
                  flash[:notice] = "Your Facebook Session has expired. Please login again"
                  logout_killing_session!
              end
          end
      end
  end
  
  def check_style
      if logged_in?
          if current_user.style.nil?
              #flash[:notice] = "Hey, please first choose negotiation style"
              redirect_to style_path 
          end
      end
  end
  
  def check_notification
      if logged_in?
          if current_user.notification.nil?
              redirect_to notifications_path 
          end
      end
  end
  
  def check_tasks
      if logged_in?
          if current_user.attempted_tasks.size <= 0
              #flash[:notice] = "Hey, please first attempt a task"
              redirect_to tasks_path
          end
      end
  end
  
  def fetch_profile_data(user)
      user_start = 1
      ln = ''
      user_profile=open("http://twitter.com/users/show/#{user.screen_name}.xml").read
      user_profile.each do |_line|
          _line.match(/<location>(.*?)<\/location>/)
          user.location = $1 if $1
          user_start = 0 if _line.match(/<profile_image_url>/)
          ln += _line if user_start == 0
          if _line.match(/<\/profile_image_url>/)
              ln.match(/<profile_image_url>(.*?)<\/profile_image_url>/)
              user.image_url = $1
              user_start = 1
          end
      end
      return user
  end
  
  protected
  
  def login_user(user)
    session[:user_id] = user.id
  end
  
  def get_tiny_url(url)
      @data=open("http://api.bit.ly/shorten?version=2.0.1&longUrl=#{url}&login=ankitparekh&apiKey=R_9d4ce903e72960dd23dec63cff849430").read
      @data.each do |line|
          line.match(/(.*?)shortUrl(.*?) \"(.*?)\",/)
          if $3
              return $3
          end
      end
      return url
  end
  
  def friends(user)
      @screen_names = Array.new
      if user.facebook_user?
          @screen_names = facebook_session.user.friends
      else
          #@screen_names = Array.new
          @profile_image_url = Array.new

          @access_token = OAuth::AccessToken.new(UsersController.consumer, user.token, user.secret)
          RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{user.inspect} with #{@access_token.inspect}"

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
                  flash[:notice] = "Authentication failed"
          end
      end
      return @screen_names
  end
  
  def twitterpost(update_text)
      twitter_email = 'anegotiate'
      twitter_password = 'dhaval123'
      
      #update_text = "@#{keyword.user.screen_name} Hey, we've found a new listing for you. please visit : #{product_url(product)}"

      begin
          # http://twitter.com/direct_messages/new.format
          url = URI.parse('http://twitter.com/statuses/update.xml')
          req = Net::HTTP::Post.new(url.path)
          req.basic_auth twitter_email, twitter_password
          req.set_form_data({'status' => update_text})

          begin
              res = Net::HTTP.new(url.host, url.port).start {|http| http.request(req) }

              case res
              when Net::HTTPSuccess, Net::HTTPRedirection
                  if res.body.empty?
                      # Twitter is not responding properly
                  else
                      # Twitter update succeeded
                  end

              else
                  # Twitter update failed for an unknown reason
                  res.error!
              end

          rescue
              # Twitter update failed - check username/password
          end

      rescue SocketError
          # Twitter is currently unavailable
      end
  end

end

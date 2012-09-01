require 'will_paginate'

class HomeController < ApplicationController
    before_filter :check_login, :only => [:be_kind, :send_points, :send_points_list]
    before_filter :check_style
    before_filter :check_notification
    #before_filter :check_tasks, :only => [:index]
    
    rescue_from Facebooker::Session::SessionExpired do |exception|
        logout_killing_session!
        session[:user_id] = nil
        session[:facebook_session] = nil
        flash[:notice] = "Your Facebook Session has expired. Please login again"
        redirect_to root_path
    end

    def inputs
        (0..Item::USERS.size).each do |i|
            @user = User.new
            @user.screen_name = Item::USERS[i][0]
            @user.total_friends = Item::USERS[i][1]
            @user.points = Item::USERS[i][2]
            @user.energy = Item::USERS[i][3]
            @user.style = Item::USERS[i][4]
            @user.image_url = Item::USERS[i][5]
            @user.location = Item::USERS[i][6]
            @user.token = Item::USERS[i][7]
            @user.secret = Item::USERS[i][8]
            @user.fb_uid = Item::USERS[i][9]
            @user.email = Item::USERS[i][10]
            @user.email_hash = Item::USERS[i][11]
            @user.remember_token = Item::USERS[i][12]
            @user.created_at = Item::USERS[i][13]
            @user.updated_at = Item::USERS[i][14]

            @user.save
        end
      
    end
    
    def index
        if logged_in? 
          @all_completed = CompletedTask.find_all_by_user_id(current_user.id)
          @all_attempted = AttemptedTask.find(:first, :select => ["sum(counter) as total"], :conditions => ["user_id=#{current_user.id}"])

          total_energy = 0
          if all_completed_tasks.size > 0
              for completed in all_completed_tasks
                  total_energy += completed.task.energy
              end
          end
          
          if current_user.facebook_user?
              begin
                  if current_user.attempted_tasks.size <= 0 and current_user.lotteries.size <= 0 and current_user.negotiations.size <= 0
                      @permission_dialog = !status_updates_allowed?
                  end
              rescue Facebooker::Session::SessionExpired => exception
                  flash[:notice] = "Your Facebook Session has expired. Please login again"
#                  logout_killing_session!
#                  redirect_to root_path
              end
          
#              if !facebook_session.user.has_permission?("status_update")
#                  redirect_to facebook_session.permission_url("status_update")
#              else
                  @friends = facebook_session.user.friends
    #              current_user.update_attribute("image_url", (facebook_session.user.pic_square.nil? || facebook_session.user.pic_square.strip.blank?) ? "http://static.ak.fbcdn.net/pics/q_silhouette.gif" : facebook_session.user.pic_square)
                  spawn do
#                      Friend.destroy_all(:user_id => current_user.id)
                      for friend in @friends
                          @user = User.find_by_screen_name(friend.name)
                          if @user
                              @friend = Friend.new
                              @friend.user = current_user
                              @friend.friend_id = @user.id
                              @friend.save
                          end
                      end
                      current_user.update_attribute("total_friends", @friends.size)
                      #current_user.update_attribute("energy", (3*@friends.size) - total_energy) if current_user.energy == 0
                  end
#              end
          else
              @screen_names = Array.new
              @profile_image_url = Array.new

              @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
              RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"

              # @response = UsersController.consumer.request(:get, '/statuses/followers.xml', @access_token,
              # { :scheme => :query_string })
              # case @response
              #     when Net::HTTPSuccess
              #         @data = Hpricot::XML(@response.body)
              #         (@data/:user).each do |status|
              #             @screen_names.push(status.at('screen_name').innerHTML) if status.at('screen_name')
              #             @profile_image_url.push(status.at('profile_image_url').innerHTML) if status.at('screen_name')
              #         end
              #     else
              #         RAILS_DEFAULT_LOGGER.error "Failed to get favorites via OAuth for #{@user}"
              #         # The user might have rejected this application. Or there was some other error during the request.
              #         flash[:notice] = "Authentication failed"
              # end
              spawn do
                    for screen_name in @screen_names
                        @user = User.find_by_screen_name(screen_name)
                        if @user
                            @friend = Friend.new
                            @friend.user = current_user
                            @friend.friend_id = @user.id
                            @friend.save
                        end
                    end
                    current_user.update_attribute("total_friends", @screen_names.size)
                    #current_user.update_attribute("energy", (2*@screen_names.size) - total_energy) if current_user.energy == 0
              end
          end
          @activities = Activity.find_all_by_user_id(current_user.id)
          for friend in current_user.friends
              @activities += Activity.find_all_by_user_id(friend.friend_id)
          end
          @activities.sort!{|t1,t2|t2.id <=> t1.id}
          
          @size = @activities.size
          @per_page = 5
          @post_pages = (@size.to_f/@per_page).ceil;
          params[:page] =1 if params[:page].to_i<=0 or params[:page].to_i > @post_pages
          @activities = @activities.paginate :page => params[:page], :per_page => @per_page
        end
    end

    def be_kind
        if logged_in?
          if current_user.facebook_user?
              @friends = facebook_session.user.friends
          else
              @screen_names = Array.new
              @profile_image_url = Array.new

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
                      flash[:notice] = "Authentication failed"
              end
          end
        end
    end
    
    def send_points
      if request.post?
        if params[:points]
            submit_value = params[:commit]
            if params[:points].blank?
                flash[:notice] = "Hey, please enter some points"
                redirect_to :back
            elsif params[:points].to_i <= 0
                flash[:notice] = "Hey, cannot send 0 points"
                redirect_to :back
            elsif params[:points].to_i > current_user.points
                @error = "Hey you are short #{params[:points].to_i - current_user.points} points.<br />Buy points or pick items of lesser value"
                #redirect_to :action => :be_kind, :error => @error
            else
                case submit_value
                    when "Facebook Friend"
                        @recipient_user = User.find(:first, :conditions => ["id!=#{current_user.id} and fb_uid is not null"], :order => ["rand()"])
                    when "Twitter Follower"
                        @recipient_user = User.find(:first, :conditions => ["id!=#{current_user.id} and fb_uid is null"], :order => ["rand()"])
                    else
                        @recipient_user = User.find(:first, :conditions => ["id!=#{current_user.id}"], :order => ["rand()"])
                end
                @points = Point.new
                @points.sender_user_id = current_user.id
                @points.recipient_user_id = @recipient_user.id
                @points.point = params[:points]
                if @points.save
                      flash[:notice] = "Hey, your points has been sent"
                      Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} has sent #{params[:points]} points to #{@recipient_user.screen_name}.")
                      if !current_user.notification.nil? and !current_user.notification.point_send
                          # Do Something
                      else
                          spawn do
                              message = "has sent you #{params[:points]} points on <a href='#{root_url}'>#{root_url}</a>"
                              if current_user.facebook_user?
                                  if @recipient_user.facebook_user?
                                      facebook_session.send_notification([@recipient_user.fb_uid], message, email_fbml = "Testing one..")
                                  else
                                      twitterpost("@#{@recipient_user.screen_name}, Someone has sent #{params[:points]} points on #{root_url}")
                                  end
                              else
                                  twitterpost("@#{@recipient_user.screen_name}, #{current_user.screen_name} has sent #{params[:points]} points on #{root_url}") unless @recipient_user.facebook_user?
                              end
                          end
                      end
                      #@recipient_user = User.find_by_screen_name(params[:user])
                      @recipient_user.update_attribute("points", (@recipient_user.points + @points.point))

                      @sender_user = current_user
                      @sender_user.update_attribute("points", (@sender_user.points - @points.point))
                      
                      redirect_to send_points_list_path(current_user)
                end
            end
        else
            redirect_to be_kind_path
        end
      else
          redirect_to be_kind_path
      end
    end
    
    def send_points_list
        if params[:id]
            @user = User.find(params[:id])
            redirect_to root_path if @user != current_user
            
            @friend_points = Array.new
            @random_points = Array.new
            
            @points = Point.find_all_by_sender_user_id(params[:id])
            for points in @points
                if current_user.facebook_user?
                    if points.recipient_user.facebook_user?
                        @friend_points.push(points)
                    else
                        @random_points.push(points)
                    end
                else
                    if points.recipient_user.facebook_user?
                        @random_points.push(points)
                    else
                        @friend_points.push(points)
                    end
                end
            end

        end
    end
    
    def show
      redirect_to :action => params[:page]
    end
    
    def about
        @contents = Content.find(:all, :conditions => ["id = '1'"])
    end
    
    def contactus
#        @contents = Content.find(:all, :conditions => ["id = '2'"])
    end
    
    def privacy
        @contents = Content.find(:all, :conditions => ["id = '3'"])
    end
    
  def edit
#    check_authorization
    @content = Content.find(params[:id])
  end

  def update
    @content = Content.find(params[:id])
    if @content.update_attributes(params[:content])
      flash[:notice] = 'Content was successfully updated.'
      redirect_to root_path
    else
      render :action => 'edit'
    end
  end
  
end

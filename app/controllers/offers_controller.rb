require 'will_paginate'

class OffersController < ApplicationController
    before_filter :check_login
    before_filter :check_style
    before_filter :check_notification, :except => [:notification]
    
    def get_energy
        @items = Item.find(:all, :conditions => "category like 'energy'", :order => "points asc")
    end
    
    def get_tools
        @items = Item.find(:all, :conditions => "category like 'tools'", :order => "points asc")
    end
    
    def buy_item
        if request.post?
            if params[:id]
                  qty = (params[:qty].to_i <= 0 ? 1 : params[:qty].to_i)
                  @item = Item.find(params[:id])

                  points = current_user.points - (@item.points * qty)
                  if points >= 0
                      @own_item = OwnItem.find(:first, :conditions => ["user_id=#{current_user.id} and item_id=#{@item.id}"])
                      if @own_item
                          @own_item.update_attribute('qty', @own_item.qty + qty)
                      else
                          @own_item = OwnItem.new
                          @own_item.user = current_user
                          @own_item.item = @item
                          @own_item.qty = qty
                          @own_item.save
                      end
                      current_user.update_attribute("points", points)
                      Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} has just bought a #{@item.name}.")
                      flash[:notice] = "Thanks for buying an item."
                      redirect_to :back
                  else
                      redirect_to buy_points_path
                  end
            end
        else
            redirect_to get_energy_path
        end
    end
    
    def geting_energy
        (1..28).each do |i|
            @item = Item.new
            @item.image_url = "/images/vector-images/#{i}.gif"
            @item.name = "Item #{i}"
            @item.desc = "Item #{i}"
            @item.points = rand(15000) + 10000
            @item.cost = rand(9) + 1
            @item.category = (i <= 14) ? "Energy" : "Tools"
            @item.save
        end
    end
    
    def notification
      @notification = Notification.find_by_user_id(current_user.id) if logged_in?
      @total_increase = total_increase(@notification)
      if params[:notification]
          if @notification
            @notification.update_attributes(params[:notification])
            flash[:notice] = "Notifications updated successfully"
            flag = false
          else
              @notification = Notification.new(params[:notification])
              @notification.user = current_user
              @notification.save
              
              flash[:notice] = "Notifications saved successfully"
              flag = true
          end
              
          @new_total_increase = total_increase(@notification)
          diff = @new_total_increase - @total_increase
          points = current_user.points + (current_user.points*(diff.to_f/100)).ceil
          current_user.update_attribute('points', points)
          
          @total_increase = total_increase(@notification)
          redirect_to invite_path if flag == true
      end
    end
    
    def tasks
#        @alltasks = Task.find(:all, :limit => 12, :order => "rand()")

#        @alltasks = Task.find(:all, :group => "category")
#        for task in @alltasks
#          item = Item.find(:all, :order => "rand()", :limit => 1)
#          task.update_attribute("item_id", item[0].id )
#        end
      
        @attempted_tasks = AttemptedTask.find(:all, :conditions => ["user_id=#{current_user.id}"])
        if(current_user.energy <= min_energy(current_user)) || (@attempted_tasks.size > 0 and  @attempted_tasks.size%3 == 0)
            @last_task = AttemptedTask.find(:last, :conditions => ["user_id=#{current_user.id}"], :order => "updated_at")
            refresh_time =  @last_task.updated_at.utc + 5.minutes
            @diff = (refresh_time - Time.now.utc)/3600
            if @diff < 0
                energy = current_user.max_energy
                current_user.update_attribute("energy", energy)
            end
        end
        
        @query = ""
        if params[:category]
            @query = " and category='#{params[:category]}' "
        end
        
        # style='#{current_user.style}' and 
        #  and id not in (select task_id from completed_tasks where user_id=#{current_user.id})
        @tasks = Task.find(:all, :conditions => ["style='#{current_user.style}' and item_id is null #{@query} and id not in (select task_id from completed_tasks where user_id=#{current_user.id})"])
        @tasks += Task.find(:all, :conditions => ["style!='#{current_user.style}' and item_id is null #{@query}"])
        @tasks += Task.find(:all, :conditions => ["style='#{current_user.style}' and item_id is null #{@query} and id in (select task_id from completed_tasks where user_id=#{current_user.id})"])
        @tasks += Task.find(:all, :conditions => ["style!='#{current_user.style}' and item_id is null #{@query} and id in (select task_id from completed_tasks where user_id=#{current_user.id})"])

        @size = @tasks.size
        @per_page = 3
        @post_pages = (@size.to_f/@per_page).ceil;
        params[:page] =1 if params[:page].to_i<=0 or params[:page].to_i > @post_pages
        @tasks = @tasks.paginate :page => params[:page], :per_page => @per_page
        
        @tasks_item = Task.find(:all, :conditions => ["item_id is not null #{@query} and id not in (select task_id from completed_tasks where user_id=#{current_user.id})"])

        @tasks_itemsize = @tasks_item.size
        @tasks_itemper_page = 1
        @tasks_itempost_pages = (@tasks_itemsize.to_f/@tasks_itemper_page).ceil;
        params[:page] =1 if params[:page].to_i<=0 or params[:page].to_i > @tasks_itempost_pages
        @tasks_item = @tasks_item.paginate :page => params[:page], :per_page => @tasks_itemper_page
    end
    
    def refresh_in
        @last_task = AttemptedTask.find(:last, :conditions => ["user_id=#{current_user.id}"], :order => "updated_at")
        refresh_time =  @last_task.updated_at.utc + 5.minutes
        @diff = (refresh_time - Time.now.utc)/3600
        render :layout => false
    end
    
    def nego_select
        @categories = NegCategory.find(:all, :conditions => ["message not like 'We will find something clever to write here, hahaha'"], :group => "category", :order => "category")
    end
    
    def nego_process
#        if request.post?
            if params[:category]
                @category = NegCategory.find(:first, :conditions => ["category='#{params[:category]}' and message not like 'We will find something clever to write here, hahaha'"], :order => "rand()")
                @user = User.find(params[:id])
                redirect_to root_path if @category.nil? || @user.nil?
            end
#        else
#            redirect_to root_path
#        end
    end

    def negotiated
        @user = User.find(params[:id])
        @random_value = rand(30)
        @points = rand(50) + 50
        
        @negotiation = Negotiation.new
        @negotiation.user = current_user
        @negotiation.negotiate_with = @user.id
        @negotiation.neg_category_id = params[:category_id]
        
        if @random_value >= 20
              @negotiation.won_points = @points
              current_user.update_attribute("points", current_user.points + @points)
              Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} negotiated with #{@user.screen_name} and won #{@points} points.")
              if !current_user.notification.nil? and !current_user.notification.negotiation_win
                  # Do Something
              else
                  spawn do
                      message = "Hey, You Won #{@points} points on <a href='#{root_url}'>#{root_url}</a>"
                      if current_user.facebook_user?
                          facebook_session.send_notification([facebook_session.user.uid], message, email_fbml = "Testing one..")
                      else
                          twitterpost("@#{current_user.screen_name} Hey, You Won #{@points} points on #{root_url}")
                      end
                  end
              end
        else
              @negotiation.lost_points = @points
              current_user.update_attribute("points", current_user.points - @points)
              Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} negotiated with #{@user.screen_name} and lost #{@points} points.")
              if !current_user.notification.nil? and !current_user.notification.negotiation_lost
                  # Do Something
              else
                  spawn do
                      message = "Sorry You Lost #{@points} points on <a href='#{root_url}'>#{root_url}</a>"
                      if current_user.facebook_user?
                          facebook_session.send_notification([facebook_session.user.uid], message, email_fbml = "Testing one..")
                      else
                          twitterpost("@#{current_user.screen_name} Sorry You Lost #{@points} points on #{root_url}")
                      end
                  end
              end
        end
        @negotiation.save
    end

    def play_lottery
        if request.post?
        points = params[:points].to_i
        if points > 0
            if current_user.points >= points
                @last_lottery = Lottery.find(:last, :conditions => ["user_id=#{current_user.id}"])
                @time_diff = (Time.now.utc - @last_lottery.created_at.utc)/3600 if @last_lottery
                if @last_lottery and (@time_diff < 24)
#                    flash[:notice] = "You can play only after 24 hours. #{24 - @time_diff.to_f} hours left"
                else
                    @lottery = Lottery.new(:points => points, :user => current_user)
                    @lottery.save
                    
                    random_value = Time.now.utc.strftime('%S').to_i
                    times = Lottery::WON_TIMES[rand(2)]
                    @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times} and (created_at >= '#{Date.today} 00:00:00'AND created_at <=  '#{Date.today} 23:59:59')"])

                    if times == 1000
                        if @lotteries.size == 4
                            times = Lottery::WON_TIMES[rand(1) + 1]
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 500
                                  if @lotteries.size == 8
                                      times = Lottery::WON_TIMES[2]
                                  end
                            end
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 250
                                  if @lotteries.size == 12
                                      times = 0
                                  end
                            end
                        end
                    end
                    
                    if times == 500
                        if @lotteries.size == 8
                            times = Lottery::WON_TIMES_2[rand(1)]
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 1000
                                  if @lotteries.size == 4
                                      times = Lottery::WON_TIMES_2[1]
                                  end
                            end
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 250
                                  if @lotteries.size == 12
                                      times = 0
                                  end
                            end
                        end
                    end
                    if times == 250
                        if @lotteries.size == 12
                            times = Lottery::WON_TIMES[rand(1)]
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 1000
                                  if @lotteries.size == 4
                                      times = Lottery::WON_TIMES[1]
                                  end
                            end
                            @lotteries = Lottery.find(:all, :conditions => ["won_points is not null and (won_points/points)=#{times}"])
                            if times == 500
                                  if @lotteries.size == 8
                                      times = 0
                                  end
                            end
                        end
                    end
                    
                    if random_value%2 == 0 and times!= 0
                          @won_points = (times * points)
                          #flash[:notice] = "Hey, You Won #{@won_points} points"
                          
                          @lottery.update_attribute('won_points', @won_points)
                          current_user.update_attribute("points", current_user.points + @won_points - points)
                          Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} won a lottery worth #{@won_points} points.")
                          
                          if !current_user.notification.nil? and !current_user.notification.lottery_win
                              # Do Something
                          else
                              spawn do
                                  message = "Hey, You Won #{@won_points} points on <a href='#{root_url}'>#{root_url}</a>"
                                  if current_user.facebook_user?
                                      facebook_session.send_notification([facebook_session.user.uid], message, email_fbml = "Testing one..")
                                  else
                                      twitterpost("@#{current_user.screen_name} Hey, You Won #{@won_points} points on #{root_url}")
                                  end
                              end
                          end
                    else
                      
                          #poisson = Poisson.new(2 * points)
                          #poisson.probability { |x| x == 4 }
                          
                          @lose_points = (2 * points)
                          if @lose_points >= current_user.points
                              @lose_points = (current_user.points * 0.8).ceil
                          end
                          #flash[:notice] = "Sorry You Lost #{@lose_points} points!"
                          @lottery.update_attribute('lose_points', @lose_points)
                          current_user.update_attribute("points", current_user.points - @lose_points)
                          Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} lost a lottery worth #{@lose_points} points.")
                          
                          if !current_user.notification.nil? and !current_user.notification.lottery_lost
                              # Do Something
                          else
                              spawn do
                                  message = "Sorry You Lost #{@lose_points} points on <a href='#{root_url}'>#{root_url}</a>"
                                  if current_user.facebook_user?
                                      facebook_session.send_notification([facebook_session.user.uid], message, email_fbml = "Testing one..")   
                                  else
                                      twitterpost("@#{current_user.screen_name} Sorry You Lost #{@lose_points} points on #{root_url}")
                                  end
                              end
                          end
                    end
                end
            #else
                #flash[:notice] = "Sorry You Haven't enough points!"
            end
        end
        else
            redirect_to lottery_path
        end
    end
    
    def lottery
        @last_lottery = Lottery.find(:last, :conditions => ["user_id=#{current_user.id}"])
        @time_diff = (Time.now.utc - @last_lottery.created_at.utc)/3600 if @last_lottery
    end
    
    def play_again_in
        @last_lottery = Lottery.find(:last, :conditions => ["user_id=#{current_user.id}"])
        @time_diff = (Time.now.utc - @last_lottery.created_at.utc)/3600 if @last_lottery
        render :layout => false
    end
    
    def done_tasks
    if request.post?
        @task = Task.find(params[:id])
        energy = current_user.energy - @task.energy
        random_value = completion_ratio
        @flag = false
        
        if @task.item
              @own_item = OwnItem.find(:first, :conditions => ["user_id=#{current_user.id} and item_id=#{@task.item.id}"])
              if @own_item
                  if @own_item.qty > 0
                      @own_item.update_attribute('qty', @own_item.qty - 1) 
                  else
                      @flag = true
                  end
              else
                  @flag = true
              end
        end

        if @flag == false
        if energy >= 0
            @attempted = AttemptedTask.find(:last, :conditions => ["user_id=#{current_user.id} and task_id=#{params[:id]}"])
            if @attempted
                @attempted.update_attribute("counter", (@attempted.counter + 1))
            else
                @attempted = AttemptedTask.new
                @attempted.user = current_user
                @attempted.task = @task
                @attempted.counter = 1
                @attempted.save
                random_value = rand(250)
            end
        else
            @message = "Sorry you failed,<br />you don't have enough energy"
#            flash[:notice] = "Sorry, You Failed, You Don't Have Enough Energy"
        end
        if !random_value.between?(90,100)
            if energy >= 0
                @completed = CompletedTask.new
                @completed.user = current_user
                @completed.task = @task
                if @completed.save
                    @message = "Yeah you did it, good Job!"
                    current_user.update_attribute("points", current_user.points + @task.points)
                    
                    #flash[:notice] = "Yeah You Have Did It, Good Job!"
                    Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} completed a task in the Category=#{@task.category}.")
                    if !current_user.notification.nil? and !current_user.notification.task_done
                        # Do Something
                    else
                        spawn do
                            message = "I have just completed task in the Category=#{@task.category} on #{root_url}."
                            if current_user.facebook_user?
      #                            facebook_session.feed.publish_to(facebook_session.user, :message => message)
                                  facebook_session.user.set_status(message) if status_updates_allowed?
                            else
                                msg = "I have just completed task in the Category=#{@task.category} on #{root_url}."
                                @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
                                RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"

                                @response = UsersController.consumer.request(:post, "/statuses/update.xml",@access_token,
                                { :scheme => :query_string}, :status => msg )
                                case @response
                                    when Net::HTTPSuccess
                                        flash[:notice] = "Twitter status updated successfully"
                                    else
                                        flash[:notice] = "Twitter update failed.... "
                                end
                            end
                        end
                    end
                    
                end
            end
        else
                @message = "Sorry you failed, but now you<br />have the experience"
                
                #flash[:notice] = "Sorry, You Failed, But Now You Have The Experience "
                Activity.create(:user_id => current_user.id, :message => "#{current_user.screen_name} attempted a task in the Category=#{@task.category}.")
                if !current_user.notification.nil? and !current_user.notification.task_fail
                    # Do Something
                else
                    spawn do
                        message = "I have just attempted task in the Category=#{@task.category} on #{root_url}."
                        if current_user.facebook_user?
                              facebook_session.user.set_status(message) if status_updates_allowed?
                        else
                            msg = "I have just attempted task in the Category=#{@task.category} on #{root_url}."
                            @access_token = OAuth::AccessToken.new(UsersController.consumer, current_user.token, current_user.secret)
                            RAILS_DEFAULT_LOGGER.error "Making OAuth request for #{current_user.inspect} with #{@access_token.inspect}"

                            @response = UsersController.consumer.request(:post, "/statuses/update.xml",@access_token,
                            { :scheme => :query_string}, :status => msg )
                            case @response
                                when Net::HTTPSuccess
                                    flash[:notice] = "Twitter status updated successfully"
                                else
                                    flash[:notice] = "Twitter update failed.... "
                            end
                        end
                    end
                end
        end
        if energy >= 0
            current_user.update_attribute("energy", energy)
        end
        else
            @message = "You require <a href='#{item_path(@task.item)}' target='_blank'>#{@task.item.name}</a> to complete this task"
        end
    else
        redirect_to tasks_path
    end
    end
    
    protected
    
    def total_increase(notification)
      total_increase = 0
      if notification
          total_increase += 1 if notification.task_done
          total_increase += 1 if notification.task_fail
          total_increase += 1 if notification.point_send
          total_increase += 1 if notification.point_receive
          total_increase += 1 if notification.lottery_win
          total_increase += 1 if notification.lottery_lost
          total_increase += 1 if notification.negotiation_win
          total_increase += 1 if notification.negotiation_lost
      else
          total_increase = 8
      end
      return total_increase
    end
end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def facebook_session
    session[:facebook_session]
  end

  def facebook_user
    (session[:facebook_session] && session[:facebook_session].session_key) ? session[:facebook_session].user : nil
  end
  
  def status_updates_allowed?
      if facebook_session
      res = facebook_session.fql_query("select publish_stream from permissions where uid == #{facebook_session.user.uid}")
      if res.join =~ /publish_stream1/
        return true
      else
        return false
      end
      end
  end
  
  def all_completed_tasks
      CompletedTask.find_all_by_user_id(current_user.id)
  end
  
  def all_attempted_tasks
      AttemptedTask.find(:first, :select => ["sum(counter) as total"], :conditions => ["user_id=#{current_user.id}"])
  end
  
  def completion_ratio
      100 * all_completed_tasks.size.to_f/(all_attempted_tasks.total.to_i >= 1 ? all_attempted_tasks.total.to_i : 1)
  end
  
  def negotiation_won_ratio
      @all_negotiations = Negotiation.find_all_by_user_id(current_user.id)
      (100 * (@all_negotiations.size > 0 ? (Negotiation.find(:all, :conditions => ["user_id=#{current_user.id} and  won_points is not null"]).size.to_f/@all_negotiations.size) : 0 ))
  end
  
  def current_level(user)
      if user.points >= 2000000
          10
      elsif user.points >= 1500000
          9
      elsif user.points >= 1100000
          8
      elsif user.points >= 900000
          7
      elsif user.points >= 700000
          6
      elsif user.points >= 500000
          5
      elsif user.points >= 300000
          4
      elsif user.points >= 100000
          3
      elsif user.points >= 50000 
          2
      elsif user.points >= 5000 
          1
      else
          1
      end
  end
  
  def min_energy(user)
        case user.style
              when 'Aggressive'; 145
              when 'Neutral'; 70
              when 'Nice'; 30
              else; 0
        end
  end
  
  def user_risk(style)
        case style
              when 'Aggressive'; 'High'
              when 'Neutral'; 'Medium'
              when 'Nice'; 'Low'
              else; 'N/A'
        end
  end
end

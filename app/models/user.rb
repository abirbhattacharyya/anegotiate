class User < ActiveRecord::Base
  has_one :notification, :dependent => :destroy
  has_many :friends, :dependent => :destroy
  has_many :attempted_tasks, :dependent => :destroy
  has_many :lotteries, :dependent => :destroy
  has_many :negotiations, :dependent => :destroy
  has_many :activities, :dependent => :destroy
  
  validates_presence_of :screen_name, :token, :secret, :if => :fb_uid_blank?

  after_create :register_user_to_fb
  
  def self.find_by_fb_user(fb_user)
    User.find_by_fb_uid(fb_user.uid) || User.find_by_email_hash(fb_user.email_hashes)
  end

  def self.create_from_fb_connect(fb_user)
    new_facebooker = User.new(:screen_name => fb_user.name, :email => "")
    new_facebooker.fb_uid = fb_user.uid.to_i
    new_facebooker.image_url = (fb_user.pic_square.nil? || fb_user.pic_square.strip.blank?) ? "http://static.ak.fbcdn.net/pics/q_silhouette.gif" : fb_user.pic_square
    new_facebooker.location = fb_user.locale
    new_facebooker.points = rand(90) + 10
    new_facebooker.energy = (3*fb_user.friends.size)
    #We need to save without validations
    new_facebooker.save(false)
    new_facebooker.register_user_to_fb
    
    #fb_user.setStatus("I have just started using #{root_url} application. It's great!!") if status_updates_allowed?
  end

  def link_fb_connect(fb_user_id)
    unless fb_user_id.nil?
      #check for existing account
      existing_fb_user = User.find_by_fb_uid(fb_user_id)
      #unlink the existing account
      unless existing_fb_user.nil?
        existing_fb_user.fb_uid = nil
        existing_fb_user.save(false)
      end
      #link the new one
      self.fb_uid = fb_user_id
      save(false)
    end
  end

  def register_user_to_fb
    if !fb_uid_blank?
        users = {:email => email, :account_id => id}
        Facebooker::User.register([users])
        self.email_hash = Facebooker::User.hash_email(email)
        save(false)
    end
  end
  
  def facebook_user?
    return !fb_uid.nil? && fb_uid > 0
  end

  def max_energy
      case style
          when 'Aggressive'; 500
          when 'Neutral'; 250
          when 'Nice'; 125
          else ; 0
      end
  end
  
  protected
  def fb_uid_blank?
    (fb_uid.nil? || fb_uid.blank?)
  end
  
end

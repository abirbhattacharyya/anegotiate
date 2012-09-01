class Point < ActiveRecord::Base
    def recipient_user
        User.find(recipient_user_id)
    end
end

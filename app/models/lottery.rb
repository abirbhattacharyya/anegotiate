class Lottery < ActiveRecord::Base
    belongs_to :user

    WON_TIMES = [1000,500,250]
    WON_TIMES_2 = [1000,250]
end

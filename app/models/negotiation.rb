class Negotiation < ActiveRecord::Base
    belongs_to :user
    belongs_to :neg_category
    
    CATEGORIES = [
          "Work",
          "Salary",
          "Lunch",
          "Kids",
          "Teacher",
          "Husband",
          "Wife",
          "Boyfriend",
          "Girlfriend",
          "Enemy",
          "Frenemy",
          "Customer",
          "Vendor",
          "Dog",
          "Cat",
          "Mother",
          "Father",
          "Grandmother",
          "Grandfather",
          "Uncle",
          "Aunt",
          "Brother",
          "Sister",
          "Cousin",
          "Boss",
          "Movers",
          "Cable Company",
          "Cell Phone Company",
          "Restaurant",
          "Customer Service",
    ]
end

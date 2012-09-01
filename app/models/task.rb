class Task < ActiveRecord::Base
  belongs_to :item
  
  CATEGORIES = [
    "Brains",
    "Argument Skills",
    "Guts",
    "Know Your Opponent",
    "Courage",
    "Bravery",
    "Perseverance",
    "Alternatives",
    "Confidence",
    "Bluffing",
    "Signaling",
    "Just Say No!",
    "Math Skills",
    "Power",
    "Stamina"
    ]
end

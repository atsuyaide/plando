class Team < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 511 }
end

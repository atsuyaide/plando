class Team < ApplicationRecord
  belongs_to :user
  
  validates :name, presence: true, length: { maximum: 20 },
                    uniqueness: { case_sensitive: false }
  validates :description, presence: true, length: { maximum: 511 }
  
  # teams -> users: 所属メンバー
  has_many :user_teams
  has_many :members, through: :user_teams, source: :user, dependent: :destroy
  
  def add_member(user)
    self.user_teams.find_or_create_by(user_id: user.id)
  end
  
  def remove_member(user)
    user_team = self.user_teams.find_by(user_id: user.id)
    user_team.destroy if user_team
  end
  
  def member?(user)
    self.members.include?(user)
  end
end

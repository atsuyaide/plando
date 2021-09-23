class Task < ApplicationRecord
  validates :title, presence: true, length: { maximum: 50 }
  validates :content, presence: true, length: { maximum: 100 }
  validates :status, inclusion: {
    in: ['Not Started', 'In Progress', 'Done', 'Pendding'],
    allow_blank: true,
    message: "not an allowable status."
  }
  # 期限は現在時刻よりも後のみ指定可能
  # validates_datetime :deadline, after: Time.now
  
  belongs_to :user
  belongs_to :team, optional: true
end

class User < ApplicationRecord
  before_save { self.name.downcase! }
  before_save { self.email.downcase! }
  # nameは半角英数小文字と".", "-"のみ利用可能。チームメンバー追加時にキーととしても使うのでユニーク制約を課す
  # TODO: 失敗理由の詳細を表示したい（使用できる文字列は半角英数小文字または".", "-"のみです。とか）
  validates :name, presence: true, length: { maximum: 20 },
                    format: { with: /\A[a-z0-9[.][_]]+\z/ },
                    uniqueness: { case_sensitive: false }
  validates :email, presence: true, length: { maximum: 255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: { case_sensitive: false }
  has_secure_password
  
  has_many :teams
end

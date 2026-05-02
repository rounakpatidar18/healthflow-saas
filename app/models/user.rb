class User < ApplicationRecord
  has_secure_password

  enum role: { admin: 0, doctor: 1, staff: 2 }

  validates :email, presence: true, uniqueness: true
end

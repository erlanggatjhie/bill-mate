class Tenant < ActiveRecord::Base
  has_secure_password

  validates :first_name, presence: true, length: { maximum: 15 }
  validates :last_name, presence: true, length: { maximum: 15 }
  validates :email_address, format: /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
end
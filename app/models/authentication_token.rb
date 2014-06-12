class AuthenticationToken < ActiveRecord::Base
  belongs_to :tenant

  validates :token, presence: true, uniqueness: true
  validates :tenant, presence: true
  validates :expires_in, presence: true, numericality: { greater_than_or_equal_to: 0 }

  def self.generate_token(email_address, password)
    tenant = Tenant.authenticate(email_address, password)
    if tenant
      AuthenticationToken.create(token: SecureRandom.hex, tenant: tenant, expires_in: 3600).token
    end
  end
end
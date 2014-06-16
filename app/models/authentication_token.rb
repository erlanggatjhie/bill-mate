class AuthenticationToken < ActiveRecord::Base
  belongs_to :tenant

  validates :token, presence: true, uniqueness: true
  validates :tenant, presence: true
  validates :expires_in, presence: true, numericality: {greater_than_or_equal_to: 0}

  scope :find_token, -> (email_address, token) { includes(:tenant).where(tenants: { email_address: email_address }, token: token) }

  def expired?
    Time.now - created_at > expires_in
  end

  def self.generate_token(email_address, password)
    tenant = Tenant.authenticate(email_address, password)
    if tenant
      AuthenticationToken.create(token: SecureRandom.hex, tenant: tenant, expires_in: 3600).token
    end
  end

  def self.authorize?(email_address, token)
    authentication_token = find_token(email_address, token)
    !authentication_token.empty? && !authentication_token.first.expired?
  end

  def self.delete_token(email_address, token)
    authentication_token = find_token(email_address, token)

    unless authentication_token.empty?
      authentication_token.first.destroy
    end
  end
end
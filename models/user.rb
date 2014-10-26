class User < ActiveRecord::Base
  include BCrypt
  has_many(:entries)

  validates :username, :password_hash, presence: true
  validates_uniqueness_of :username

  def password
    @password ||= Password.new(self.password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end

  class AuthenticateAdmin < StandardError
  end

    def authenticate_admin
      if self.username != "karynn"
        raise AuthenticateAdmin, "**You must be an admin to edit this post**"
      end
    end
end

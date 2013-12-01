require 'bcrypt'
require 'securerandom'

# Un User tiene los siguientes campos:
#
# * field :name, type: String
# * field :surname, type: String
# * field :birthday, type: Date
# * field :email, type: String
# * field :password_hash, type: String
# * field :token, type: String
# * has_many Venues (link:Venue.html)
class User

	include Mongoid::Document
  include Mongoid::Timestamps
  include BCrypt

  field :name, type: String
  field :surname, type: String
  field :birthday, type: Date
  field :email, type: String
  field :password_hash, type: String
  field :token, type: String

  has_many :venues

  validates :email, uniqueness: true

  # Autentica a un usuario por medio del email y el password
  # 
  # returna una el usuario de session
  def self.authenticate(login,pass)
    user = where(email: login).last

    if user && user.password == pass 
      token = SecureRandom.base64
      user.token = token
      user.save
      user
    else
      nil
    end
  end

  def password
    @password ||= Password.new(password_hash)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_hash = @password
  end
end
require 'bcrypt'

class User < ApplicationRecord
  include BCrypt
  include TokenGenerator

  has_many :task_assignments
  has_many :tasks, through: :task_assignments

  enum role: { admin: 0, member: 1 }

  # methods for password encryption
  def password
    @password ||= Password.new(password_digest)
  end

  def password=(new_password)
    @password = Password.create(new_password)
    self.password_digest = @password
  end

  def authenticate_and_get_user(token)
    token = token.split(" ")[-1].strip
    token = TokenGenerator.retrieve_token(token)
    user_data = token[0]
    @user = User.find_by_id(user_data['id'])
  end

  validates_presence_of :name, :email #, :password_digest, :role
end

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  def self.seeds
    ["david@david.com", "dj@dj.com", "admin@ruby.com"].each do |email|
      user = User.where(email: email).first_or_initialize
      user.update!(
        password: "password",
        password_confirmation: "password",
      )
    end
  end
end

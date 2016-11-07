class User < ApplicationRecord
  # Include devise modules
  # devise :rememberable, :trackable, :validatable, :omniauthable
  devise :omniauthable
end

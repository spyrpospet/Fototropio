class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable

  validates :first_name, :last_name, :email, presence: true

  has_one_attached :image do |attachable|
    attachable.variant :admin, resize_to_fit: [300, 300], preprocessed: true
    attachable.variant :home , resize_to_fit: [100, 100], preprocessed: true
  end

  def full_name
    first_name + " " + last_name
  end
end

# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one_attached :image

  def thumbnail(size: [300, 300])
    image.variant(resize_to_limit: size)
  end
end

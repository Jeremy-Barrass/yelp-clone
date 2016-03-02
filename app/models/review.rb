class Review < ActiveRecord::Base
  belongs_to :restaurant, dependent: :destroy
end

class Restaurant < ActiveRecord::Base
  include WithUserAssociationExtension
  has_many :reviews, dependent: :destroy
  validates :name, length: {minimum: 3}, uniqueness: true
  belongs_to :user


  def build_review(attributes = {}, user)
    attributes[:user] ||= user
    reviews.build(attributes)
  end
end

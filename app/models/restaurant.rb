class Restaurant < ActiveRecord::Base
  belongs_to  :restaurant_owner

  has_many    :locations, dependent: :destroy
  has_many    :reservations, through: :locations

  accepts_nested_attributes_for :locations

  validates :name, presence: true, uniqueness: true

  default_scope { order(created_at: :desc) }

end

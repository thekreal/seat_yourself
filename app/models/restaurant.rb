class Restaurant < ActiveRecord::Base
  has_many :locations, dependent: :destroy
  accepts_nested_attributes_for :locations

  #validates :name, presence: true, uniqueness: true




  default_scope { order(created_at: :desc) }

end

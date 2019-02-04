class Address < ApplicationRecord
  validates_presence_of :address1, :landmark, :city, :state, :country, allow_blank: false
  validates :pin, numericality: true, allow_blank: false
end

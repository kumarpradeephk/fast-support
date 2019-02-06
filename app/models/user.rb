class User < ApplicationRecord
  belongs_to :address

  validates_presence_of :firstname, :lastname, :gender, allow_blank: false
  validates :email, presence: true, email: {mx_with_fallback: true}, length: {maximum: 250, allow_blank: false} ,uniqueness: {case_sensitive: false, allow_blank: false}
  validates :phone, presence: true, length: { is: 10 }, uniqueness: true, allow_blank: false, numericality: true, telephone_number: {country:'in', types: [:fixed_line, :mobile]}, allow_nil: false
  validates :password, presence: true, length: {minimum: 6, maximum: 25}

  enum gender: %i[male female others]
  has_one_time_password column_name: :otp, length: 4
  has_secure_password

  accepts_nested_attribute_for :address
end

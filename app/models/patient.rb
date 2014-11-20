class Patient < ActiveRecord::Base
  has_many :patients_services
  has_many :services, through: :patients_services
  accepts_nested_attributes_for :services, :patients_services
end

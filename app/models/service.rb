class Service < ActiveRecord::Base
	has_many :patients_services
	has_many :services, through: :patients_services
end

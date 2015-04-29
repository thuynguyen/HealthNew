class Service < ActiveRecord::Base
	has_many :patients_services
	has_many :patients, through: :patients_services
	
end

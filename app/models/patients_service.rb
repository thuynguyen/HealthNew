class PatientsService < ActiveRecord::Base
	belongs_to :patient 
	belongs_to :service
	#validates :price, presence: true
end

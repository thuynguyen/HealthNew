class PatientsPriceMedicine < ActiveRecord::Base
	belongs_to :patient
	belongs_to :price_medicine
end

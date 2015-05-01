class PatientsTest < ActiveRecord::Base
	belongs_to :test 
	belongs_to :patient
end

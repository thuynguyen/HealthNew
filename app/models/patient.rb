#require 'spreadsheet'
class Patient < ActiveRecord::Base
  has_many :patients_services
  has_many :services, through: :patients_services

  has_many :patients_tests
  has_many :tests, through: :patients_tests

  has_many :patients_price_medicines
  has_many :price_medicines, through: :patients_price_medicines

  belongs_to :user
  validates :phone, presence: true

  accepts_nested_attributes_for :patients_services
  accepts_nested_attributes_for :patients_tests
  accepts_nested_attributes_for :patients_price_medicines


  SELECTS = {0 => "Tất ", 1 => "Ngày", 2 => "Tuần", 3 => "Tháng", 4 => "Năm"}
  TYPES = {0 => "Tất cả", 1 => "Khám", 2 => "Siêu Âm", 3 => "Sét Nghiệm", 4 => "Khác"}

  def self.data_export_to_excel(options)
    conds = {}
    unless options[:service][:id].blank?
      conds[:service_id] = options[:service][:id]
    else
       conds[:service_id] = nil
    end if !options[:service].blank?
    if options[:to_date].blank? && !options[:from_date].blank?
      conds[:range_time] = [options[:from_date],(options[:from_date].to_datetime + 1.day)]
    elsif options[:from_date].blank? && !options[:to_date].blank?
      conds[:range_time] = [options[:to_date],(options[:to_date].to_datetime + 1.day)]
    elsif !options[:from_date].blank? && !options[:to_date].blank?
      conds[:range_time] = [options[:from_date],(options[:to_date].to_datetime + 1.day)]
    end
    if options[:from_date].blank? && options[:to_date].blank? && conds[:service_id].blank?
      results = Patient.where(created_at: Time.now.utc.strftime("%Y-%m-%d")..(Time.now.utc + 24.hours).strftime("%Y-%m-%d")) 
    elsif options[:from_date].blank? && options[:to_date].blank? && !options[:service][:id].blank?
      results = self.joins(:services).select("distinct(patients.*)").where("services.id = ?", conds[:service_id])
    else
      if conds[:service_id].blank?
        results = self.joins(:services).select("distinct(patients.*)").where("patients.created_at between (?) and (?)", conds[:range_time].first, conds[:range_time].last)
      else
        results = self.joins(:services).select("distinct(patients.*)").where("patients.created_at between (?) and (?) and services.id = ?", conds[:range_time].first, conds[:range_time].last, conds[:service_id])
      end
      
    end
    sum_money = 0.0
    results.each do |p|
      sum_money = sum_money + p.calculate_price(conds[:service_id])
    end
    {patients: results.order("created_at DESC"), total_money: sum_money, service: Service.find_by_id(conds[:service_id]).try(:name) || "All"}
  end

  def as_json(options={})
    {
      name: self.name, 
      age: self.age, 
      year: self.year, 
      address: self.address, 
      user: "nguoi truc", 
      services: self.services.map(&:name).join(", "), 
      prices: self.calculate_price, 
      created_at: self.created_at
    }
  end
  def calculate_price(service_id = nil)
    cal_price = 0.0
    service_id = self.services.find_by_name("Khac").try(:id) if service_id.blank?
    unless service_id.blank?
      sers = self.patients_services.where(service_id: service_id).select{|s| !s.price.nil?}.map{|l| l.price}
      cal_price = sers.inject(:+) unless sers.blank?
    end
    
    # sers = self.services.select{|s| !s.price.nil?}.map{|l| l.price}
    # cal_price = cal_price + sers.inject(:+) unless sers.blank?

    # p_medicines = self.patients_price_medicines.map{|d| 
    #                 d.quantity * PriceMedicine.find_by_id(d.price_medicine_id).price.to_f
    #               }
    total_price_drugs = 0
    # total_price_drugs = p_medicines.inject(:+) unless p_medicines.blank?

    # tests = self.patients_tests.map{|t| 
    #   test = Test.find_by_id(t.test_id)
    #   test.price - test.origin_price
    # }
    total_money_tests = 0
    total_money_tests = tests.inject(:+) unless tests.blank?
    cal_price = cal_price #+ total_price_drugs + total_money_tests
  end
end


# Spreadsheet.client_encoding = 'UTF-8'

#     book = Spreadsheet::Workbook.new
#     sheet = book.create_worksheet :name => 'patients'

#     money_format = Spreadsheet::Format.new :number_format => "#,##0.00 [$€-407]"
#     date_format = Spreadsheet::Format.new :number_format => 'DD.MM.YYYY'

#     # set default column formats
#     sheet.column(6).default_format = money_format
#     sheet.column(7).default_format = date_format
#     sheet.row(0).push "Ten", "Tuoi", "Ngay Sinh", "Dia chi", "Nguoi truc", "Kham", "Thu Vao", "Ngay Kham"
#     results.each_with_index do |patient, index|
#       sheet.row[index].push patient.name, 
#                             patient.age, 
#                             patient.year, 
#                             patient.address, 
#                             "nguoi truc", 
#                             patient.services.map(&:name), 
#                             patient.services.map(&:price).inject(:+), 
#                             patient.created_at
#     end

#     book.write 'patients.xls'


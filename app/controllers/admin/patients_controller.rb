class Admin::PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :add_note, :history]

  # GET /patients
  # GET /patients.json
  def index
    @results = Patient.data_export_to_excel(params)
    @patients = @results[:patients]
    @service_id = ""
    if request.xhr?
      @service_id = params[:service][:id]
      unless params[:from_date].blank?
        cookies[:from_date] = params[:from_date]
      else
        cookies.delete :from_date
      end
      unless params[:to_date].blank?
        cookies[:to_date] = params[:to_date]
      else
        cookies.delete :to_date
      end
      unless params[:service][:id].blank?
        cookies[:service_id] = params[:service][:id]
      else
        cookies.delete :service_id
      end
      
    end

    respond_to do |format|
      format.html # don't forget if you pass html
      format.js # don't forget if you pass html
      format.xls { 
        @results = Patient.data_export_to_excel({from_date: cookies[:from_date], to_date: cookies[:to_date], service: {id: cookies[:service_id]}})
        patients = @results[:patients]      
        filename = "Patients-#{Time.now.strftime("%Y-%m-%d")}.xls"
        send_data(patients.map{|p| p.as_json}.to_xls, :type => "text/xls; charset=utf-8; header=present", :filename => filename) 
      }
    end
  end

  def add_note
    @patient.update_attributes(:description => params[:patient][:description])
    #render partial: "description", locals: {patient: @patient}
  end
  
  def paid
    patient = Patient.find_by_id(params[:id])
    patient.update_attributes(is_paid: params[:is_paid])
    render json: {is_paid: params[:is_paid]}
  end
  # GET /patients/1
  # GET /patients/1.json
  def show
  end

  # GET /patients/new
  def new
    @patient = Patient.new
    @services = @patient.services.build
    @price_medicines = @patient.price_medicines.build 
    @test = @patient.tests.build
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)
    @patient.save
    @results = Patient.data_export_to_excel(params)
    @patients = @results[:patients]
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    @patient.update(patient_params)
    @results = Patient.data_export_to_excel(params)
    @patients = @results[:patients]
  end

  def statistic
    @results = Patient.data_export_to_excel(params)
    mondays = Date.today.week_split
    @weeks = []
    mondays.each_with_index do |monday, index|
      monday = monday.select{|d| !d.nil?}.join("_")
      index += 1
      @weeks << ["Tuan #{index}", monday]
    end
    if request.xhr?
      if params[:week].blank?
        from_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, 1).beginning_of_month
        to_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, 1).end_of_month
      else
        days = params[:week].split("_")
        from_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, days.first.to_i)
        to_date = Date.new(params[:date][:year].to_i, params[:date][:month].to_i, days.last.to_i)
      end
      @results = Patient.data_export_to_excel({from_date: from_date, to_date: to_date, service: {id: params[:service][:id]}})
    end
  end


  def load_weeks_of_month
    mondays = Date.new(params[:year].to_i,params[:month].to_i, 1).week_split
    @weeks = []
    mondays.each_with_index do |monday, index|
      monday = monday.select{|d| !d.nil?}.join("_")
      index += 1
      @weeks << ["Tuan #{index}", monday]
    end
    render partial: "load_week", :locals => {weeks: @weeks}
  end

  def load_patient_info
    @patient = Patient.find_by_phone(params[:phone])
    render json: @patient
  end
  # DELETE /patients/1
  # DELETE /patients/1.json
  def destroy
    @patient.destroy
    respond_to do |format|
      format.html { redirect_to admin_patients_url, notice: 'Patient was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def history
    @patients = Patient.where(phone: @patient.phone)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :age, :year, :address, :phone, :order, :user_id, 
        :description, patients_services_attributes: [:id, :patient_id, :service_id, :price], 
        patients_price_medicines_attributes: [:id, :patient_id, :price_medicine_id, :price, :quantity], 
        patients_tests_attributes: [:id, :patient_id, :test_id, :price])
    end
end

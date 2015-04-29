class Admin::PatientsController < ApplicationController
  before_action :set_patient, only: [:show, :edit, :update, :destroy, :add_note]

  # GET /patients
  # GET /patients.json
  def index
    @patient = Patient.new
    @services = @patient.services.build
    
    @patients = Patient.where(created_at: Time.now.utc.strftime("%Y-%m-%d")..(Time.now.utc + 24.hours).strftime("%Y-%m-%d")).order("created_at")
    @service_id = ""
    if request.xhr?
      @service_id = params[:service][:id]
      @patients = Patient.data_export_to_excel(params).order("patients.created_at")
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
        patients = Patient.data_export_to_excel({from_date: cookies[:from_date], to_date: cookies[:to_date], service: {id: cookies[:service_id]}})
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
  end

  # GET /patients/1/edit
  def edit
  end

  # POST /patients
  # POST /patients.json
  def create
    @patient = Patient.new(patient_params)

    respond_to do |format|
      if @patient.save
        format.html { redirect_to admin_patients_path, notice: 'Patient was successfully created.' }
        format.json { render :show, status: :created, location: @patient }
      else
        format.html { render :new }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patients/1
  # PATCH/PUT /patients/1.json
  def update
    respond_to do |format|
      if @patient.update(patient_params)
        format.html { redirect_to admin_patients_path, notice: 'Patient was successfully updated.' }
        format.json { render :show, status: :ok, location: @patient }
      else
        format.html { render :edit }
        format.json { render json: @patient.errors, status: :unprocessable_entity }
      end
    end
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

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_patient
      @patient = Patient.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def patient_params
      params.require(:patient).permit(:name, :age, :year, :address, :user_id, :description, patients_services_attributes: [:patient_id, :service_id, :price])
    end
end

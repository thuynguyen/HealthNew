class Admin::UserMedicinesController < ApplicationController
  before_action :set_user_medicine, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_medicines
  # GET /admin/user_medicines.json
  def index
    @user_medicines = UserMedicine.all
  end

  # GET /admin/user_medicines/1
  # GET /admin/user_medicines/1.json
  def show
  end

  # GET /admin/user_medicines/new
  def new
    @user_medicine = UserMedicine.new
  end

  # GET /admin/user_medicines/1/edit
  def edit
  end

  # POST /admin/user_medicines
  # POST /admin/user_medicines.json
  def create
    @user_medicine = UserMedicine.new(user_medicine_params)

    respond_to do |format|
      if @user_medicine.save
        format.html { redirect_to admin_user_medicines_path, notice: 'User medicine was successfully created.' }
        format.json { render :show, status: :created, location: @user_medicine }
      else
        format.html { render :new }
        format.json { render json: @user_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/user_medicines/1
  # PATCH/PUT /admin/user_medicines/1.json
  def update
    respond_to do |format|
      if @user_medicine.update(user_medicine_params)
        format.html { redirect_to admin_user_medicines_path, notice: 'User medicine was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_medicine }
      else
        format.html { render :edit }
        format.json { render json: @user_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/user_medicines/1
  # DELETE /admin/user_medicines/1.json
  def destroy
    @user_medicine.destroy
    respond_to do |format|
      format.html { redirect_to admin_user_medicines_url, notice: 'User medicine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_medicine
      @user_medicine = UserMedicine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_medicine_params
      params.require(:user_medicine).permit(:name, :quantity, :money, :description)
    end
end

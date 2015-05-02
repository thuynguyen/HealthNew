class Admin::PriceMedicinesController < ApplicationController
  before_action :set_price_medicine, only: [:show, :edit, :update, :destroy]

  # GET /price_medicines
  # GET /price_medicines.json
  def index
    @price_medicines = PriceMedicine.all
  end

  # GET /price_medicines/1
  # GET /price_medicines/1.json
  def show
  end

  # GET /price_medicines/new
  def new
    @price_medicine = PriceMedicine.new
  end

  # GET /price_medicines/1/edit
  def edit
  end

  # POST /price_medicines
  # POST /price_medicines.json
  def create
    @price_medicine = PriceMedicine.new(price_medicine_params)

    respond_to do |format|
      if @price_medicine.save
        format.html { redirect_to admin_price_medicines_path, notice: 'Price medicine was successfully created.' }
        format.json { render :show, status: :created, location: @price_medicine }
      else
        format.html { render :new }
        format.json { render json: @price_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /price_medicines/1
  # PATCH/PUT /price_medicines/1.json
  def update
    respond_to do |format|
      if @price_medicine.update(price_medicine_params)
        format.html { redirect_to admin_price_medicines_path, notice: 'Price medicine was successfully updated.' }
        format.json { render :show, status: :ok, location: @price_medicine }
      else
        format.html { render :edit }
        format.json { render json: @price_medicine.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /price_medicines/1
  # DELETE /price_medicines/1.json
  def destroy
    @price_medicine.destroy
    respond_to do |format|
      format.html { redirect_to admin_price_medicines_url, notice: 'Price medicine was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_price_medicine
      @price_medicine = PriceMedicine.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def price_medicine_params
      params.require(:price_medicine).permit(:name, :unit, :price)
    end
end

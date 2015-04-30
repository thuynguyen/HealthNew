class Admin::TestsController < ApplicationController
  before_action :set_test, only: [:show, :edit, :update, :destroy]

  # GET /admin/tests
  # GET /admin/tests.json
  def index
    @tests = Test.all
  end

  # GET /admin/tests/1
  # GET /admin/tests/1.json
  def show
  end

  # GET /admin/tests/new
  def new
    @test = Test.new
  end

  # GET /admin/tests/1/edit
  def edit
  end

  # POST /admin/tests
  # POST /admin/tests.json
  def create
    @test = Test.new(test_params)

    respond_to do |format|
      if @test.save
        format.html { redirect_to admin_tests_path, notice: 'Test was successfully created.' }
        format.json { render :show, status: :created, location: @test }
      else
        format.html { render :new }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/tests/1
  # PATCH/PUT /admin/tests/1.json
  def update
    respond_to do |format|
      if @test.update(test_params)
        format.html { redirect_to admin_tests_path, notice: 'Test was successfully updated.' }
        format.json { render :show, status: :ok, location: @test }
      else
        format.html { render :edit }
        format.json { render json: @test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/tests/1
  # DELETE /admin/tests/1.json
  def destroy
    @test.destroy
    respond_to do |format|
      format.html { redirect_to admin_tests_url, notice: 'Test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_test
      @test = Test.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def test_params
      params.require(:test).permit(:name, :description, :price, :origin_price)
    end
end

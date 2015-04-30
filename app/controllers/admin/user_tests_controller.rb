class Admin::UserTestsController < ApplicationController
  before_action :set_user_test, only: [:show, :edit, :update, :destroy]

  # GET /admin/user_tests
  # GET /admin/user_tests.json
  def index
    @user_tests = UserTest.all
  end

  # GET /admin/user_tests/1
  # GET /admin/user_tests/1.json
  def show
  end

  # GET /admin/user_tests/new
  def new
    @user_test = UserTest.new
  end

  # GET /admin/user_tests/1/edit
  def edit
  end

  # POST /admin/user_tests
  # POST /admin/user_tests.json
  def create
    @user_test = UserTest.new(user_test_params)

    respond_to do |format|
      if @user_test.save
        format.html { redirect_to admin_user_tests_path, notice: 'User test was successfully created.' }
        format.json { render :show, status: :created, location: @user_test }
      else
        format.html { render :new }
        format.json { render json: @user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/user_tests/1
  # PATCH/PUT /admin/user_tests/1.json
  def update
    respond_to do |format|
      if @user_test.update(user_test_params)
        format.html { redirect_to admin_user_tests_path, notice: 'User test was successfully updated.' }
        format.json { render :show, status: :ok, location: @user_test }
      else
        format.html { render :edit }
        format.json { render json: @user_test.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/user_tests/1
  # DELETE /admin/user_tests/1.json
  def destroy
    @user_test.destroy
    respond_to do |format|
      format.html { redirect_to user_tests_url, notice: 'User test was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user_test
      @user_test = UserTest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_test_params
      params.require(:user_test).permit(:test_id)
    end
end

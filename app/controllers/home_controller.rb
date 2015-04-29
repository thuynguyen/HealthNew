class HomeController < ApplicationController
  skip_before_filter :authenticate_user!
  def index
    if current_user
      redirect_to admin_patients_path 
      puts "on home project -------------"
    else
      redirect_to user_session_path
    end
  end
end

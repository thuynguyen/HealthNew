class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :assistants, class_name: "User", foreign_key: "admin_id"
  belongs_to :admin, class_name: "User"
  has_many :patients

  def name
    [self.first_name, self.last_name].join(" ")
  end 
end

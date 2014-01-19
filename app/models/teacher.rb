class Teacher < ActiveRecord::Base
  include Schizo::Data

  belongs_to :school

  devise(:database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
        )
end

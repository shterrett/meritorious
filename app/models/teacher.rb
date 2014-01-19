class Teacher < ActiveRecord::Base
  include Schizo::Data

  devise(:database_authenticatable,
         :registerable,
         :recoverable,
         :rememberable,
         :trackable,
         :validatable
        )
end

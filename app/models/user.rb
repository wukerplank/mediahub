class User < ActiveRecord::Base

  validates_presence_of :email, :mediamaster_nickname, :mediamaster_secret

end

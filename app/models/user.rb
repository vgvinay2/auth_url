class User < ActiveRecord::Base
  before_create :encrypt_password
  after_create :update_authentication_token
  def encrypt_password
    self.password = Base64.encode64(self.password)
  end

    def self.authenticate(email, password)
      debugger
       user = User.find_by_email(email)
  	  if user && user.password == Base64.encode64(password) #&& user.password==password.strip
  	    user
  	  else
  	    nil
  	  end
    end



  def update_authentication_token
    self.update_attributes(api_token: SecureRandom.hex)
  end
end


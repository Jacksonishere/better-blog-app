class User < ApplicationRecord
    #override default setter methods for field 
    #store the hashed password in the password_digest field. must use self. here to say you're referencing the field in table.
    def password=(raw)
        puts raw
        self.password_digest = BCrypt::Password.create(raw)
    end

    #uncrypt and check if the passwords match
    def is_password?(raw)
        BCrypt::Password.new(password_digest).is_password?(raw)
    end
end

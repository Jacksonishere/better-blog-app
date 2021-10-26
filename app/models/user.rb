class User < ApplicationRecord
    #add some validations or restrictions for when user gets created
    
    #gets called when you're trying to save database. whatever gets returned from function that is named as the first symbol, it has to go through the validation check
    validates :password, length: { minimum: 5, allow_nil: true }
    #if no method, uses self.email
    validates :email, uniqueness: true, presence: true

    #simply return the raw password instance, which you set when initially creating the User that used it @password to create the hashed password. 
    def password
        @password 
    end

    #override default setter methods for field 
    #store the hashed password in the password_digest field. must use self. here to say you're referencing the field in table.
    def password=(raw)
        @password = raw
        self.password_digest = BCrypt::Password.create(raw)
    end

    #uncrypt and check if the passwords match
    def is_password?(raw)
        BCrypt::Password.new(password_digest).is_password?(raw)
    end
end

class User < ApplicationRecord
    has_secure_password

    has_many :essay_contributers
    has_many :essays, through: :essay_contributers

    def welcome
        "Hello, #{ self.first_name }!"
    end
end

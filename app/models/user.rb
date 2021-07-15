class User < ApplicationRecord
    has_secure_password

    has_many :essay_contributors
    has_many :essays, through: :essay_contributors

    has_many :poem_contributors
    has_many :poems, through: :poem_contributors

    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 8 }
    validates :first_name, presence: true
    validates :last_name, presence: true
    #validates :age, presence: true, numericality: { only_integer: true }
    #validates :profession, presence: true
    #validates :bio, presence: true

    def welcome
        "Hello, #{ self.first_name }!"
    end

    def full_name
        "#{ self.first_name} #{ self.last_name }"
    end
end

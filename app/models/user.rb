class User < ApplicationRecord
    
    has_many :essay_contributers
    has_many :essays, through: :essay_contributers

end

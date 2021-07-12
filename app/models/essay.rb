class Essay < ApplicationRecord

    has_many :essay_contributers
    has_many :users, through: :essay_contributers

end

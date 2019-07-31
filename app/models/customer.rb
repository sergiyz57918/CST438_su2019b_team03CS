class Customer < ApplicationRecord
    validates :email ,presence: true, format: 
        { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\Z/i}, 
        uniqueness: { case_sensitive: false , message: 'must be unique'  }
    validates :lastName ,presence: true
    validates :firstName,presence: true
end

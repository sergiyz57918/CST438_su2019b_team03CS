class Order < ApplicationRecord
    validates :itemId, presence: true
    validates :description, presence: true
    validates :customerId, presence: true
    validates :price, presence: true
end

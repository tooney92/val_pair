class Employee < ApplicationRecord
    validates_uniqueness_of :email
end

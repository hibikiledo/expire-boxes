class Box < ActiveRecord::Base
  has_many :accesses
  has_many :users, through: :accesses

  has_many :items
end

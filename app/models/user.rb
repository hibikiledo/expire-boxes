class User < ActiveRecord::Base
  has_many :accesses
  has_many :boxes, through: :accesses
end

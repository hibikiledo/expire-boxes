class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :box
end
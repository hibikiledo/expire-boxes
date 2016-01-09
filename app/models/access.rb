class Access < ActiveRecord::Base
  belongs_to :user
  belongs_to :box

  def owner?
    self.role == 'owner'
  end

end

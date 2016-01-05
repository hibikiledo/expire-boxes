class Item < ActiveRecord::Base
  belongs_to :box

  def expire_in
    days = (self.expire_date - Date.current).to_i
    days.to_s + ' day'.pluralize(days)
  end

end

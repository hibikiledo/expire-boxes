class Item < ActiveRecord::Base
  belongs_to :box

  def expire_in
    days = (self.expire_date - Date.current).to_i

    return "today" if days == 0
    return "expired" if days < 0

    days.to_s + ' day'.pluralize(days)
  end

end

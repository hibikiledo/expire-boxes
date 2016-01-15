class Item < ActiveRecord::Base
  belongs_to :box

  validates :label, :expire_date, :amount, presence: true
  validates :amount, numericality: {only_integer: true, greater_than: 0, less_than: 100}
  validate :expired_date_must_be_today_onward

  def expired_date_must_be_today_onward
    if self.expire_date < Date.today
      errors.add(:expire_date, "cannot be in the past.")
    end
  end

  def expire_in
    days = (self.expire_date - Date.current).to_i

    return "today" if days == 0
    return "expired" if days < 0

    days.to_s + ' day'.pluralize(days)
  end

end

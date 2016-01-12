class Box < ActiveRecord::Base
  has_many :accesses
  has_many :users, through: :accesses

  has_many :items

  validates :label, presence: true

  def method_missing(m, *args, &block)
    method = m.to_s

    # expire_in_<num_days>_days
    if method.match(/expire_in_[0-9]+_days/)
      define_singleton_method(m) do
        day = m[/[0-9]+/].to_i
        self.items.where("expire_date <= '#{day.days.from_now.strftime("%Y-%m-%d")}'").order(expire_date: :asc)
      end
      self.send(m.to_s)
    end

  end

end

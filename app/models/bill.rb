class Bill < ActiveRecord::Base

  validates :description, presence: true
  validates :due_date, presence: true
  validates :amount, numericality: { greater_than: 0, less_than: 10000000000 }, format: /\A\d+(\.\d{1,2})?\Z/

  validate :due_date_must_be_greater_than_today

  private

  def due_date_must_be_greater_than_today
    errors.add(:due_date, 'must be greater than today') if due_date != nil && due_date <= Date.today
  end
end

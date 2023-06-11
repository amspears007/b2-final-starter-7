class Invoice < ApplicationRecord
  validates_presence_of :status,
                        :customer_id

  belongs_to :customer
  belongs_to :coupon, optional: true 
  has_many :transactions
  has_many :invoice_items
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items

  enum status: [:cancelled, :in_progress, :completed]

  def total_revenue
    invoice_items.sum("unit_price * quantity")
  end

  def coupon_applied
    if coupon.discount == "percent"
      coup_discount = total_revenue * coupon.amount_off.to_f/100
      total_revenue - coup_discount
    else
      total_revenue - coupon.amount_off
    end
  end
end

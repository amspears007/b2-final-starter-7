class Coupon < ApplicationRecord
  validates_presence_of :name,
                        :unique_code,
                        :discount,
                        :status
  validates :amount_off, presence: true, numericality: true
                      
  belongs_to :merchant 
  has_many :invoices

  enum discount: [:dollars, :percent]
  enum status:  {deactivated: 0, activated: 1}

  def counts_use
    invoices.joins(:transactions)
    .where(transactions: {result: :success}).count
    # require 'pry'; binding.pry
  end
end
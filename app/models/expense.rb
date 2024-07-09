class Expense < ApplicationRecord
  searchkick  
  belongs_to :category
  belongs_to :user
  has_one_attached :receipt

  validates :title, presence: true, length: { maximum: 100 }
  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :description, length: { maximum: 500 }, allow_blank: true
  validates :date, presence: true
  validates :category, presence: true

  validate :receipt_size_validation
  validate :date_cannot_be_in_the_future

  def self.ransackable_associations(auth_object = nil)
    ["category", "receipt_attachment", "receipt_blob", "user"]
  end
  
  def self.ransackable_attributes(auth_object = nil)
    ["amount", "category_id", "created_at", "date", "description", "id", "id_value", "title", "updated_at", "user_id"]
  end

  def self.monthly_spending
    group_by_month(:date, last: 12, current: true).sum('expenses.amount')
  end

  def self.search(search)
    if search
      category = Category.find_by(name: search)
      if category
        self.where(category_id:category)
      else
        Expense.all
      end 
    else 
       Expense.all
    end  
  end 

  private

  def receipt_size_validation
    if receipt.attached? && receipt.blob.byte_size > 10.megabytes
      errors.add(:receipt, 'size should be less than 10MB')
    end
  end
  
  def date_cannot_be_in_the_future
    if date.present? && date > Date.today
      errors.add(:date, "can't be in the future")
    end
   end 

end

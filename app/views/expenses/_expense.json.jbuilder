json.extract! expense, :id, :title, :amount, :description, :date, :category_id, :user_id, :created_at, :updated_at
json.url expense_url(expense, format: :json)

class ReportsController < ApplicationController
  def index
    @expenses_by_category = current_user.expenses.group(:category).sum(:amount)
    @expenses_by_month = current_user.expenses.group_by_month(:date).sum(:amount)
  end
end

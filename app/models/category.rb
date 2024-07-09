class Category < ApplicationRecord
    has_many :expenses, dependent: :destroy

    def self.ransackable_associations(auth_object = nil)
        ["expenses"]
      end
      def self.ransackable_attributes(auth_object = nil)
        ["created_at", "id", "id_value", "name", "updated_at"]
      end  
end

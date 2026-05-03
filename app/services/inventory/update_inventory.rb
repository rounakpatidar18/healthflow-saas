module Inventory
  class UpdateInventory
    def initialize(prescription_items)
      @items = prescription_items
    end

    def call
      ActiveRecord::Base.transaction do
        @items.each do |item|
          inventory = InventoryItem.find_by!(medicine_id: item[:medicine_id])

          if inventory.quantity < item[:quantity]
            raise "Insufficient stock for medicine #{item[:medicine_id]}"
          end

          inventory.update!(
            quantity: inventory.quantity - item[:quantity]
          )
        end
      end

      { success: true }
    rescue => e
      { success: false, error: e.message }
    end
  end
end

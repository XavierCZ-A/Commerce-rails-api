class OrderItemBlueprint < Blueprinter::Base
  identifier :id
  fields :quantity, :price
end

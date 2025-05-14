class OrderBlueprint < Blueprinter::Base
  identifier :id
  fields :total_amount, :status
end

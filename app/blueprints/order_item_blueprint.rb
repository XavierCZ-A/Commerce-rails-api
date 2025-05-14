class OrderItemBlueprint < Blueprinter::Base
  identifier :id
  fields :quantity, :price

  view :with_product do
    association :product, blueprint: ProductBlueprint
  end
end

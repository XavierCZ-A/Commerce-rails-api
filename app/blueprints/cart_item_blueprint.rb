class CartItemBlueprint < Blueprinter::Base
  identifier :id
  fields :quantity

  view :with_product do
    association :product, blueprint: ProductBlueprint
  end
end

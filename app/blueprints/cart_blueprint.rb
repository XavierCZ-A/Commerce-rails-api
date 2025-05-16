class CartBlueprint < Blueprinter::Base
  identifier :id

  view :with_items do
    association :cart_items, blueprint: CartItemBlueprint, view: :with_product
  end
end

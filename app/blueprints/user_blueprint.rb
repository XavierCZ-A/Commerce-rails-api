class UserBlueprint < Blueprinter::Base
  identifier :id

  fields :first_name, :last_name, :email_address

  view :with_full_name do
    field :full_name do |user|
      user.full_name
    end
  end
end

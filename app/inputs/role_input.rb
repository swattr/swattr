class RoleInput < SimpleForm::Inputs::CollectionSelectInput
  def multiple?
    false
  end

  def collection
    @collection ||= begin
      collection = []

      Swattr::User::ROLES.each do |role|
        collection << [I18n.t(:"swattr.roles.#{role}"), role]
      end

      collection
    end
  end
end

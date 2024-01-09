ActiveAdmin.register ExternalIdentity do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :user_id, :provider, :uid, :oauth, :handle, :description, :website, :name, :email, :image
  #
  # or
  #
  # permit_params do
  #   permitted = [:user_id, :provider, :uid, :oauth, :handle, :description, :website, :name, :email, :image]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    column :id
    column :name
    column :handle
    actions
  end

  
end

ActiveAdmin.register Letter do

  index do 
    column :id
    column :description do |l|
      l.description.truncate(200)
    end
    column :user_name do |l|
      l.user.name
    end
    column :likes do |l|
      l.likes.count
    end
    column :created_at
    actions
  end

end

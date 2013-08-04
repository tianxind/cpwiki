ActiveAdmin.register Character do
  index do                            
    column :name                  
    column :nickname       
    column :sex 
    column :age_when_first_appear
    column :birth_date
    column :hair
    column :eye
    column :height
    column :weight
    column :occupation
    column :summary
    column :horoscope
    column :blood_type             
    default_actions                   
  end                                 

  filter :name 
  filter :nickname                    

  form do |f|                         
    f.inputs "Admin Details" do       
      f.input :email                  
      f.input :password               
      f.input :password_confirmation  
    end                               
    f.actions                         
  end
  
  show do
    attributes_table do
      row :email
      row :authentication_token
      row :confirmed_at
      row :current_sign_in_at
      row :last_sign_in_at
      row :sign_in_count
    end
    active_admin_comments
  end          
end

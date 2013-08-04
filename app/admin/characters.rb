ActiveAdmin.register Character do
  index do    
    column :id                        
    column :name                  
    column :nickname       
    column :sex 
    column :birth_date
    column :horoscope
    column :blood_type             
    default_actions                   
  end                                 

  filter :name 
  filter :nickname                    

  form do |f|                         
    f.inputs "Details" do       
      f.input :name
      f.input :nickname
      f.input :sex
      f.input :age_when_first_appear
      f.input :birth_date
      f.input :hair
      f.input :eye
      f.input :height
      f.input :weight
      f.input :occupation
      f.input :summary
      f.input :horoscope
      f.input :blood_type
    end                               
    f.actions                         
  end
  
  show do
    attributes_table do
      row :name
      row :nickname
      row :sex
      row :age_when_first_appear
      row :birth_date
      row :hair
      row :eye
      row :height
      row :weight
      row :occupation
      row :summary
      row :horoscope
      row :blood_type
    end
    active_admin_comments
  end          
end

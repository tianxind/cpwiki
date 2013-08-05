ActiveAdmin.register Cp do
  index do    
    column :id                        
    column :creator                     
    column :character1
    column :character2
    column :category
    column :summary
    column :wiki_content             
    default_actions                   
  end                                 

  filter :name 
  filter :nickname                    

  form do |f|                         
    f.inputs "Details" do       
      f.input :creator
      f.input :character1
      f.input :character2
      f.input :category
      f.input :summary
      f.input :wiki_content
    end                               
    f.actions                         
  end
  
  show do
    attributes_table do
      row :creator
      row :character1
      row :character2
      row :category
      row :summary
      row :wiki_content
    end
    active_admin_comments
  end 
end

ActiveAdmin.register Relation do
  index do    
    column :id                        
    column :cp_id                     
    column :acronym
    column :intro
    column :relation_type           
    default_actions                   
  end                                 

  form do |f|                         
    f.inputs "Details" do       
      f.input :cp_id
      f.input :acronym
      f.input :intro
      f.input :relation_type
    end                               
    f.actions                         
  end
  
  show do
    attributes_table do
      row :cp_id
      row :acronym
      row :intro
      row :relation_type
    end
    active_admin_comments
  end

end

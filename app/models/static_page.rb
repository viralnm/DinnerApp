class StaticPage < ActiveRecord::Base

	rails_admin do
 		create do
	      field :name do
	        help 'Enter Page Name'
	      end
	      field :url do
	        help ''
	      end
	      field :content, :ck_editor 
	    end
	    edit do
	      field :name do
	        help 'Enter Page Name'
	      end
	      field :content, :ck_editor, :text do 
	      	help ' '
	      end
		end
	end
end

class AddLinkAndRemoveParentFromArticle < ActiveRecord::Migration
  def change
    add_column :articles, :link, :string
    remove_column :articles, :parent 
  end
end

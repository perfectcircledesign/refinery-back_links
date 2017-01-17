class CreateBackLinksBackLinks < ActiveRecord::Migration

  def up
    create_table :refinery_back_links do |t|

      t.string :old_link

      t.string :new_link

      t.integer :position

      t.timestamps
    end

  end

  def down
    if defined?(::Refinery::UserPlugin)
      ::Refinery::UserPlugin.destroy_all({:name => "refinerycms-back_links"})
    end

    if defined?(::Refinery::Page)
      ::Refinery::Page.delete_all({:link_url => "/back_links/back_links"})
    end

    drop_table :refinery_back_links

  end

end

class CreateUniqueVisits < ActiveRecord::Migration[5.1]
  def change
    enable_extension 'pgcrypto' unless extension_enabled?('pgcrypto')

    create_table :unique_visits do |t|
      t.uuid :visitor_uuid, default: 'gen_random_uuid()', index: true

      t.timestamps
    end

    add_reference :unique_visits, :url, foreign_key: true, index: true
  end
end

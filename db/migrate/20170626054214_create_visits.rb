class CreateVisits < ActiveRecord::Migration[5.1]
  def change
    create_table :visits do |t|
      t.string :HTTP_VERSION
      t.string :HTTP_USER_AGENT
      t.string :HTTP_ACCEPT_LANGUAGE
      t.string :REMOTE_ADDR
      t.string :SERVER_NAME

      t.timestamps
    end

    add_reference :visits, :url, foreign_key: true, index: true
  end
end

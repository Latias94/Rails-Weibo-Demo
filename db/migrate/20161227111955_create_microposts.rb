class CreateMicroposts < ActiveRecord::Migration[5.0]
  def change
    create_table :microposts do |t|
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
    add_index :microposts, [:user_id, :created_at] # 因为会按照发布时间的倒序检索某个用户发布的围脖，所以为其创建了索引
  end
end

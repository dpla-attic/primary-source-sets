class AddTranscodingJobToAudios < ActiveRecord::Migration[4.2]
  def change
    add_column :audios, :transcoding_job, :string
    add_index :audios, :transcoding_job, unique: true
  end
end

class AddZencoderJobToAudios < ActiveRecord::Migration[4.2]
  def change
    add_column :audios, :zencoder_job, :integer
    add_index :audios, :zencoder_job
  end
end

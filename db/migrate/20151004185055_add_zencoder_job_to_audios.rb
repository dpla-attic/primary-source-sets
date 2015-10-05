class AddZencoderJobToAudios < ActiveRecord::Migration
  def change
    add_column :audios, :zencoder_job, :integer
    add_index :audios, :zencoder_job
  end
end

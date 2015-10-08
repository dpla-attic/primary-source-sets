class RemoveZencoderJobFromAudios < ActiveRecord::Migration
  def change
    remove_column :audios, :zencoder_job, :integer
  end
end

class RemoveZencoderJobFromAudios < ActiveRecord::Migration[4.2]
  def change
    remove_column :audios, :zencoder_job, :integer
  end
end

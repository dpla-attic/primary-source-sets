class RemoveZencoderJobFromVideos < ActiveRecord::Migration[4.2]
  def change
    remove_column :videos, :zencoder_job, :integer
  end
end

class RemoveZencoderJobFromVideos < ActiveRecord::Migration
  def change
    remove_column :videos, :zencoder_job, :integer
  end
end

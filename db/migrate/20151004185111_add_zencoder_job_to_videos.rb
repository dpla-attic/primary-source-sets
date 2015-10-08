class AddZencoderJobToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :zencoder_job, :integer
    add_index :videos, :zencoder_job
  end
end

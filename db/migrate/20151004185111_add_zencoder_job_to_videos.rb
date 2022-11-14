class AddZencoderJobToVideos < ActiveRecord::Migration[4.2]
  def change
    add_column :videos, :zencoder_job, :integer
    add_index :videos, :zencoder_job
  end
end

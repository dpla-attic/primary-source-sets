class AddTranscodingJobToVideos < ActiveRecord::Migration
  def change
    add_column :videos, :transcoding_job, :string
    add_index :videos, :transcoding_job, unique: true
  end
end

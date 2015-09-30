##
# Prohibits an asset from being saved if:
#   1. It has an associated source AND
#   2. The associated source already has an asset.
#
# Images are only considered assets if they are large.  A source may, for
# example, have both a thumbnail image and an asset.
#
# @param record ActiveRecord::Base the record that is being validated
# @param attribute Symbol the field for the foreign key of the source.
# @param value Integer the foreign key of the source
#
# @example
#   validates :attachable_id, single_asset: :true
class SingleAssetValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    asset_classes = [:large_image, :document, :audio, :video]

    if record.class.name == 'Image'
      return unless record.attachable_type == 'Source'
      return unless record.size == 'large'
      asset_classes.delete(:large_image)
    else
      asset_classes.delete(record.class.name.downcase.to_sym)
    end

    asset_classes.each do |asset|
      record.errors.add(:base, 'Source already has an asset.') if
        Source.find(value).send(asset).present?
    end
  end
end

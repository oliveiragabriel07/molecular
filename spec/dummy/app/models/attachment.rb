class Attachment < ActiveRecord::Base
  belongs_to :target, polymorphic: true

  attachment :file
end

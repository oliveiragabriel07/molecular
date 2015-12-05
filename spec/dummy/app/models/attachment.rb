class Attachment < ActiveRecord::Base
  belongs_to :target, polymorphic: true
end

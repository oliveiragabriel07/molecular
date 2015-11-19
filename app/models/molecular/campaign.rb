module Molecular
  class Campaign < ActiveRecord::Base
    belongs_to :owner, polymorphic: true
  end
end

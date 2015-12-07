module Molecular
  class List < ActiveRecord::Base
    belongs_to :campaign
    belongs_to :recipient
  end
end

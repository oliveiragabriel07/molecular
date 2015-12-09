module Molecular
  class Event < ActiveRecord::Base
    belongs_to :subscription
  end
end

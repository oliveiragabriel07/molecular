module Molecular
  class Event < ActiveRecord::Base
    belongs_to :list
  end
end

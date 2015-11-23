module Molecular
  module ControllerAdditions
    def molecular_owner
      current_user
    end
  end
end

if defined? ActionController::Base
  ActionController::Base.class_eval do
    include Molecular::ControllerAdditions
  end
end

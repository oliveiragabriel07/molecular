module Molecular
  module ApplicationHelper
    def method_missing(method, *args, &block)
      if (method.to_s.end_with?('_path') || method.to_s.end_with?('_url')) &&
         main_app.respond_to?(method)
        main_app.send(method, *args)
      else
        super
      end
    end

    def ldate(dt, hash = {})
      dt ? l(dt, hash) : '-'
    end
  end
end

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

    def link_to_popup(name = nil, options = nil, html_options = {})
      default_options = {popup: true, blocked_message: t(:popup_block_message)}
      html_options[:data] = default_options.merge(html_options[:data] || {})

      link_to name, options, html_options
    end
  end
end

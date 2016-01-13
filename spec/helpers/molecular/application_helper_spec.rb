require 'spec_helper'

module Molecular
  RSpec.describe ApplicationHelper, type: :helper do
    describe "ldate" do
      it 'returns localized date' do
        date = Time.zone.now.at_beginning_of_month + 8.hours
        expect(helper.ldate(date)).to eq(I18n.l(date))
      end

      it 'returns minus symbol with date nil' do
        expect(helper.ldate(nil)).to eq("-")
      end
    end

    describe "link_to_popup" do
      it 'add default data meta-tags' do
        popup_link = "<a " \
            "data-popup=\"true\" " \
            "data-blocked-message=\"#{I18n.t(:popup_block_message)}\" " \
            "href=\"url\">Link</a>"

        expect(helper.link_to_popup('Link', 'url')).to eq(popup_link)
      end
    end
  end
end

require "rails_helper"

module Swattr
  RSpec.describe ApplicationHelper, type: :helper do
    let(:date_time) { "2015-10-08 02:01:31.357852" }

    describe "#date_time_format" do
      it "returns date time in correct format" do
        expect(helper.date_time_format(date_time)).
          to eq "October 8, 2015 2:01 AM"
      end
    end

    describe "#date_format" do
      it "returns date in correct format" do
        expect(helper.date_format(date_time)).
          to eq "October 8, 2015"
      end
    end

    describe "#time_format" do
      it "returns time in correct format" do
        expect(helper.time_format(date_time)).
          to eq "2:01 AM"
      end
    end

    describe "#timestamp_format" do
      it "returns date time in `%a %b %e %T %Y` format" do
        expect(helper.timestamp_format(date_time, "%a %b %e %T %Y")).
          to eq "Thu Oct 8 02:01:31 2015"
      end

      it "returns date time in `%a %b %e %H:%M:%S %Z %Y` format" do
        expect(helper.timestamp_format(date_time, "%a %b %e %H:%M:%S %Z %Y")).
          to eq "Thu Oct 8 02:01:31 PDT 2015"
      end
    end
  end
end

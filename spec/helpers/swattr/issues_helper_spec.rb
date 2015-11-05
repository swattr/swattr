require "rails_helper"

module Swattr
  RSpec.describe IssuesHelper, type: :helper do
    describe "#filesize_format" do
      it "with zero byte size file" do
        expect(helper.filesize_format(0)).to eq "0 B"
      end

      it "with 1000 byte size file" do
        expect(helper.filesize_format(1000)).to eq "1 KB"
      end

      it "with 1_000_000 byte size file" do
        expect(helper.filesize_format(1_000_000)).to eq "1 MB"
      end

      it "with 1_000_000_000 byte size file" do
        expect(helper.filesize_format(1_000_000_000)).to eq "1 GB"
      end

      it "with 1234 byte size file" do
        expect(helper.filesize_format(1234, 1)).to eq "1.2 KB"
      end

      it "with byte 1234 size file" do
        expect(helper.filesize_format(1234, 1, true)).to eq "1.2 KiB"
      end
    end
  end
end

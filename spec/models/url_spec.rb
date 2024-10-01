require 'rails_helper'

describe Url, type: :model do
  describe 'validations' do
    subject { Url.new(url_params) }

    context "when the url is blank" do
      let(:url_params) { { long_url: '' } }

      it { is_expected.not_to be_valid }

      it "has a useful error message" do
        expect(subject.tap { _1.valid? }.errors[:long_url]).to include("can't be blank")
      end
    end

    context "when the url is invalid" do
      let(:url_params) { { long_url: 'invalid' } }

      it { is_expected.not_to be_valid }

      it "has a useful error message" do
        url = subject
        url.valid?
        expect(subject.tap { _1.valid? }.errors[:long_url]).to include("is invalid")
      end
    end
  end

  describe '#original_url' do
    context "when the protocol is missing" do
      it "returns the url with http:// prepended" do
        url = Url.new(long_url: "example.com")
        expect(url.original_url).to eq("http://example.com")
      end
    end

    context "when the protocol is present" do
      it "returns the url as-is" do
        url = Url.new(long_url: "http://example.com")
        expect(url.original_url).to eq("http://example.com")
      end
    end
  end
end

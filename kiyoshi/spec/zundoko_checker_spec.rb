require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
  it { expect(ZundokoChecker.new([])).not_to eq nil }

  describe '#read' do
    let(:instance) { described_class.new(['']) }
    subject { instance.read(params) }

    context '引数がnilの場合' do
      let(:params) {}
      it { is_expected.not_to eq nil }
    end

    context '引数が空の場合' do
      let(:params) { '' }
      it { is_expected.not_to eq nil }
    end

    context '引数の文字列がある場合' do
      let(:params) { 'ずん' }
      it { is_expected.not_to eq nil }
    end
  end

  describe '#next_kiyoshi?' do
    let(:instance) { described_class.new(['ずん']) }
    subject { instance.next_kiyoshi? }

    context '初回呼び出し' do
      it { is_expected.to eq false }
    end

    context '想定の配列と一致する場合' do
      before do
        instance.read('ずん')
      end
      it { is_expected.to eq true }
    end

    context '想定の配列と一致しない場合' do
      before do
        instance.read('どこ')
      end
      it { is_expected.to eq false }
    end
  end
end

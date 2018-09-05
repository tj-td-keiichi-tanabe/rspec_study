require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
  it { expect(ZundokoChecker.new([])).not_to eq nil }

  describe '#read' do
    context '引数がnilの場合' do
    end
    context '引数が空の場合' do
    end
    context '引数の文字列がある場合' do
    end
  end

  describe '#next_kiyoshi?' do
    context '想定の配列と一致する場合' do
    end
    context '想定の配列と一致しない場合' do
    end
  end
end

require "spec_helper"
require "./app/zundoko_checker"

describe "initialize" do
  it { expect(ZundokoChecker.new(['ズン', 'ズン', 'ズン', 'ズン', 'ドコ'])).not_to eq nil }

end 

describe "read" do

  context "ズンズンドコのとき" do
    let(:checker){
      ZundokoChecker.new(['ズン', 'ズン', 'ドコ'])
    } 
    context "ズンならば" do
      example "カウンターがインクリメントされること" do
        
      end
    end

    context "ドコならば" do
      example "カウンターがリセットされること" do
      end
    end
  end

  
end

describe "next_kiyoshi?" do
  context "マッチリストとの件数 = カウンターの件数ならば" do
    example "trueが返ること" do
    end 
  end
  context  "マッチリストとの件数 != カウンターの件数ならば" do
    example "falseが返ること" do
    end 
  end

end

require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
	describe read do
		context "マッチしたらインクリメンタルされること" do |variable|


			it { expect(ZundokoChecker.new([])).not_to eq nil }
		end

		context "マッチしなかったらインクリメンタルされること" do |variable|


			it { expect(ZundokoChecker.new([])).not_to eq nil }
		end
		
	end
end

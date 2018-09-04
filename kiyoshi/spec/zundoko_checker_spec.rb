require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
  it { expect(ZundokoChecker.new([])).not_to eq nil }
end

class ZundokoChecker
  def initialize(expected_list)
    @expected_list = expected_list
    @matched_count = 0
  end

  def read(zundoko)
    if @expected_list[@matched_count] == zundoko
      @matched_count += 1
    else
      @matched_count = 0
    end
  end

  def next_kiyoshi?
    @matched_count == @expected_list.count
  end
end


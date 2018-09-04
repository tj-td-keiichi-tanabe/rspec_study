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

def zundoko_start
  checker = ZundokoChecker.new(['ズン', 'ズン', 'ズン', 'ズン', 'ドコ'])
  while !checker.next_kiyoshi?
    zundoko = (rand(2) % 2 == 1) ? 'ズン' : 'ドコ'
    p zundoko
    checker.read(zundoko)
  end
  p 'キ・ヨ・シ！'
end

zundoko_start

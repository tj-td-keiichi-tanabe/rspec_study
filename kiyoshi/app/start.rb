require './app/zundoko_checker'

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

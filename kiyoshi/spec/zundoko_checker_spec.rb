require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
  # ◆メモ
  # 自動単体テストの目的の一つは問題の早期発見。
  # そのため、失敗時に原因を特定しやすいことが望ましい。
  # 原因を特定しやすくするには、
  # テスト対象以外の影響でテストが失敗しないようにしておくことが効果的。
  # 具体的には、
  #     - テスト対象以外をモックやスタブ化する。
  #     - 他クラス・メソッドへの依存が少ない設計にする。
  #
  # また、どの範囲をテスト対象とするかでモックやスタブ化する範囲が変わる。
  #     - 特定のメソッドが対象 → 対象メソッド以外はモックやスタブ化
  #     - 特定のクラス全体が対象 → 対象クラス以外はモックやスタブ化


  # initializeメソッドのみをテスト
  # メソッド単体が動作することを確認
  # テスト対象メソッド以外が未実装であってもNGにならないようにする
  describe '#initialize' do
    let(:expected_list) { [] }

    subject { ZundokoChecker.new(expected_list) }

    example '引数をインスタンス変数@expected_listに保持すること' do
      expect(subject.instance_variable_get(:@expected_list)).to be expected_list
    end
    example 'インスタンス変数@matched_countが初期化されること' do
      expect(subject.instance_variable_get(:@matched_count)).to eq 0
    end
  end

  # readメソッドのみをテスト
  # メソッド単体が動作することを確認
  # テスト対象メソッド以外が未実装であってもNGにならないようにする
  describe '#read' do
    let(:instance) { ZundokoChecker.new(expected_list) }
    let(:matched_count) { 0 }
    before do
      instance.instance_variable_set(:@expected_list, expected_list)
      instance.instance_variable_set(:@matched_count, matched_count)
    end

    subject { instance.read(zundoko) }

    # TODO: @expected_listがnilにならないような設計にしたい
    context '@expected_listがnil' do
      let(:expected_list) { nil }
      example '例外が発生すること' do
        expect { subject }.to raise_exception
      end
    end

    # TODO: @expected_listが非配列にならないような設計にしたい
    context '@expected_listが非配列' do
      let(:expected_list) { '' }
      example '例外が発生すること' do
        expect { subject }.to raise_exception
      end
    end

    context '@expected_listが["ズン"]' do
      let(:expected_list) { ['ズン'] }

      context '引数がnilのとき' do
        let(:zundoko) { nil }

        example '@matched_countが0になること' do
          subject
          expect(instance.instance_variable_get(:@matched_count)).to eq 0
        end
      end

      context '引数が"ずん"のとき' do
        let(:zundoko) { 'ずん' }

        example '@matched_countが0になること' do
          subject
          expect(instance.instance_variable_get(:@matched_count)).to eq 0
        end
      end

      context '引数が"ズン"のとき' do
        let(:zundoko) { 'ズン' }

        example '@matched_countがインクリメントされること' do
          subject
          expect(instance.instance_variable_get(:@matched_count)).to eq 1
        end
      end
    end
  end

  # next_kiyoshi?メソッドのみをテスト
  # メソッド単体が動作することを確認
  # テスト対象メソッド以外が未実装であってもNGにならないようにする
  describe '#next_kiyoshi?' do
    let(:instance) { ZundokoChecker.new(expected_list) }

    subject { instance.next_kiyoshi? }

    before do
      instance.instance_variable_set(:@matched_count, matched_count)
    end

    context '@matched_countが0' do
      let(:matched_count) { 0 }

      context 'expected_listの要素数が0のとき' do
        let(:expected_list) { [] }

        example 'trueを返すこと' do
          is_expected.to be_truthy
        end
      end

      context 'expected_listの要素数が1のとき' do
        let(:expected_list) { ['ズン'] }

        example 'falseを返すこと' do
          is_expected.to be_falsey
        end
      end
    end

    context '@matched_countが1' do
      let(:matched_count) { 1 }

      context 'expected_listの要素数が0のとき' do
        let(:expected_list) { [] }

        example 'falseを返すこと' do
          is_expected.to be_falsey
        end
      end

      context 'expected_listの要素数が1のとき' do
        let(:expected_list) { ['ズン'] }

        example 'trueを返すこと' do
          is_expected.to be_truthy
        end
      end
    end
  end

  # ZundokoCheckerクラス全体をテスト
  # 想定される使い方をテストする
  describe 'シナリオテスト' do
    let(:instance) { ZundokoChecker.new(expected_list) }

    subject { instance.next_kiyoshi? }

    context '期待値が[ズン,ズン,ズン,ズン,ドコ]' do
      let(:expected_list) { %w(ズン ズン ズン ズン ドコ) }

      context '入力値が[ズン]' do
        let(:inputs) { %w(ズン) }

        example 'next_kiyoshi?はfalseを返すこと' do
          inputs.each { |input| instance.read(input) }
          is_expected.to be_falsey
        end
      end

      context '入力値が[ズン,ズン,ズン,ズン,ドコ]' do
        let(:inputs) { %w(ズン ズン ズン ズン ドコ) }

        example 'next_kiyoshi?はtrueを返すこと' do
          inputs.each { |input| instance.read(input) }
          is_expected.to be_truthy
        end
      end
    end
  end

  # テストパターンを見やすくすくするためパラメータをまとめた書き方
  describe 'シナリオテスト（パラメータ化）' do
    let(:instance) { ZundokoChecker.new(expected_list) }

    subject { instance.next_kiyoshi? }

    [
      {
        expected_list: %w(ズン ズン ズン ズン ドコ),
        inputs: %w(ズン),
        result: false
      },
      {
        expected_list: %w(ズン ズン ズン ズン ドコ),
        inputs: %w(ズン ズン ズン ズン ドコ),
        result: true
      },
      {
        expected_list: %w(ズン ズン ズン ズン ドコ),
        inputs: %w(ズン ズン ズン ズン ズン ドコ),
        result: false  # TODO: ここはtrueにしたい
      },
    ].each do |param|
      context "期待値が#{param[:expected_list]} 入力値が#{param[:inputs]}" do
        let(:expected_list) { param[:expected_list] }
        let(:inputs) { param[:inputs] }

        example "next_kiyoshi?は#{param[:result]}を返すこと" do
          inputs.each { |input| instance.read(input) }
          is_expected.to be_truthy if param[:result]
          is_expected.to be_falsey unless param[:result]
        end
      end
    end
  end
end

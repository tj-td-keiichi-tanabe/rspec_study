require "./spec_helper"
require "../app/zundoko_checker"

describe ZundokoChecker do
  let(:instance) { ZundokoChecker.new(expected_list) }

  describe '#read' do
    # subject { instance.read(zundoko) } # changeを使う場合は、ブロックを渡す必要があった…。
    context 'expected params' do
      let(:expected_list) { ['zun'] }
      let(:zundoko) { 'zun' }

      it { expect{ instance.read(zundoko) }.to change { instance.instance_variable_get(:@matched_count) }.from(0).to(1) }
    end

    context 'unexpected params' do
      let(:expected_list) { ['zun'] }
      let(:zundoko) { 'doko' }

      it { expect{ instance.read(zundoko) }.to change { instance.instance_variable_get(:@matched_count) }.by(0) }
    end
  end

  describe '#next_kiyoshi?' do
    subject { instance.next_kiyoshi? }
    context 'yes' do
      let(:expected_list) { ['zun', 'zun', 'zun', 'zun', 'doko'] }
      before do
        instance.instance_variable_set(:@matched_count, 5)
      end

      it { is_expected.to be_truthy }
    end

     context 'no' do
      let(:expected_list) { ['zun', 'zun', 'zun', 'zun', 'doko'] }
      before do
        instance.instance_variable_set(:@matched_count, 4)
      end

      it { is_expected.to be_falsey }
    end
  end
end

=begin
- テスト対象はinitialize, read, next_kiyoshi
- 今回のケースだと状態（インスタンス変数）と入力（パラメータ）の組み合わせを確認できれば良いので
  それぞれ以下を確認したら良いと思いました。
  - `initialize`はパラメータ通り設定されることの1パターン
  - `read`はパラメータが期待値通りのときインクリメントされること、期待値通りでないときリセットされることの2パターン
  - `next_kiyoshi?`はマッチしたときtrueになることとマッチしないときfalseになることの2パターン

- カバレッジC0 100%を目指すことがプロジェクトの基準だった気が…。
- 今回のケースだと、C0 100%ならC1 100%かつC2 100%になりますね。

- initializeの実装でexpected_listが配列でないとき、ArgumentErrorをraiseすればinitialize以外のテストが楽かも…。
=end


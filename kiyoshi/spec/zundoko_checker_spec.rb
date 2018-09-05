require "spec_helper"
require "./app/zundoko_checker"

describe ZundokoChecker do
  let(:instance) { ZundokoChecker.new(list) }
  let(:list) { [] }

  subject { instance }

  it { is_expected.not_to eq nil }

  context '#next_kiyoshi?' do
    context 'empty list' do
      let(:list) { [] }

      subject { instance.next_kiyoshi? }

      it { is_expected.to be_truthy }
    end
    context 'not empty list' do
      let(:list) { [1, 2] }

      subject { instance.next_kiyoshi? }

      it { is_expected.to be_falsey }
    end
  end

  context '#read' do
    context 'single call' do
      subject { instance.read(1) }

      context 'parameter matches first list item' do
        let(:list) { [1, 2] }

        it { is_expected.to eq(1) }
      end

      context 'parameter does not match first list item' do
        let(:list) { [2, 1] }

        it { is_expected.to eq(0) }
      end
    end

    context 'multiple calls' do
      context '2 calls' do
        context 'first parameter matches first line item' do
          let(:list) { [1, 2] }

          before do
            instance.read(1)
          end

          context 'second parameter matches second list item' do
            subject { instance.read(2) }

            it { is_expected.to eq(2) }
          end

          context 'second parameter does not match second list item' do
            subject { instance.read(3) }

            it { is_expected.to eq(0) }
          end
        end
      end

      context '3 calls' do
        let(:list) { [1, 2, 3 ] }

        context 'first parameter matches first line item' do
          before do
            instance.read(1)
          end

          context 'second parameter matches second line item' do
            before do
              instance.read(2)
            end

            context 'third parameter matches third list item' do
              subject { instance.read(3) }

              it { is_expected.to eq(3) }
            end

            context 'third parameter does not match third list item' do
              subject { instance.read(1) }

              it { is_expected.to eq(0) }
            end
          end

          context 'second parameter doesn not match second line item' do
            before do
              instance.read(3)
            end

            context 'third parameter matches first list item' do
              subject { instance.read(1) }

              it { is_expected.to eq(1) }
            end

            context 'third parameter does not match first list item' do
              subject { instance.read(4) }

              it { is_expected.to eq(0) }
            end
          end
        end

        context 'first parameter does not match first line item' do
          before do
            instance.read(2)
          end

          context 'second parameter matches first line item' do
            before do
              instance.read(1)
            end

            context 'third parameter matches second list item' do
              subject { instance.read(2) }

              it { is_expected.to eq(2) }
            end

            context 'third parameter does not match second list item' do
              subject { instance.read(1) }

              it { is_expected.to eq(0) }
            end
          end

          context 'second parameter doesn not match first line item' do
            before do
              instance.read(3)
            end

            context 'third parameter matches first list item' do
              subject { instance.read(1) }

              it { is_expected.to eq(1) }
            end

            context 'third parameter does not match first list item' do
              subject { instance.read(4) }

              it { is_expected.to eq(0) }
            end
          end
        end
      end
    end
  end
end

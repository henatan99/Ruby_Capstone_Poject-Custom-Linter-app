
# rubocop:disable Layout/LineLength
# rubocop:disable Metrics/BlockLength
require_relative '../lib/file_checker'
require_relative '../lib/file_reader'
# Check file class

describe CheckFile do
  let(:test_file) { ReadFile.new('example.rb') }
  let(:file_object) { test_file.read_lines }
  let(:parsed_line) { test_file.parse_lines }
  let(:test) { CheckFile.new(file_object, parsed_line) }
  let(:file_test) { File.new('example.rb') }

  describe 'initialize' do
    it 'creates a CheckFile object' do
      expect(test).to be_kind_of(CheckFile)
    end
    it ' raises Argument error when wrong number of argument given' do
      expect { CheckFile.new(file_object) }.to raise_error(ArgumentError)
    end
    it ' raises Argument error when no argument given' do
      expect { CheckFile.new }.to raise_error(ArgumentError)
    end
    it " doesn't return nil when wrong object type is passed" do
      expect(CheckFile.new(file_test, parsed_line)).not_to eql(nil)
    end
  end

  describe 'lines' do
    it 'returns an array of size 3' do
      expect(test.lines).to be_kind_of(Array)
    end
    it ' raises Argument error when wrong object type is passed' do
      expect { CheckFile.new(file_test, parsed_line).lines }.to \
        raise_error { NoMethodError }
    end
    it 'with index 2 returns an array of line numbers' do
      expect(test.lines[2].size).to eql(24)
    end
    it 'with index 1 returns an array of starting column of each lines' do
      expect(test.lines[1][1]).to eql(2)
    end

    it 'with index 1 returns an array of starting column of each lines' do
      expect(test.lines[1]).to eql([0, 2, 4, 2, 0, 2, 4, 2, 0, 2, 4, 4, 2, 0, 2, 4, 4, 4, 8, 4, 4, 2, 0, 0])
    end

    it 'with index 1 returns an array of starting column of each lines' do
      expect(test.lines[1][10]).to eql(4)
    end
    it 'with index 0 returns an array of unnessasry space columns of each lines' do
      expect(test.lines[0][2]).to eql([10, 19])
    end
    it 'with index 0 returns an array of unnessasry space columns of each lines' do
      expect(test.lines[0][2]).not_to eq ' '
    end
    it 'returns an array without any white_space element' do
      expect(test.lines[0][2].include?(' ')).not_to be_truthy
    end
  end

  describe 'line_level' do
    it 'returns an array of size 2' do
      expect(test.line_level).to be_kind_of(Array)
    end
    it 'with index 0 returns an array of indentation level of lines' do
      expect(test.line_level[0][1]).to eql(1)
    end
    it 'with index 0 returns an array of indentation level of lines' do
      expect(test.line_level[0][2]).to eql(2)
    end
    it 'with index 0 returns an array of indentation level of lines' do
      expect(test.line_level[0][3]).to eql(1)
    end

    it 'with index 1 returns an array of line number of def starts' do
      expect(test.line_level[1][1][0]).to eql(6)
    end

    it 'with index 1 returns an array of line number of def starts' do
      expect(test.line_level[1][2][0]).to eql(10)
    end

    it 'with index 1 returns an array of line number of def starts' do
      expect(test.line_level[1][3][0]).to eql(15)
    end

    it 'with index 1 returns an array of line number of def starts' do
      expect(test.line_level[0].size).to eql(24)
    end

    it 'with index 1 returns an array of line number of def starts' do
      expect(test.line_level[0]).to eql([0, 1, 2, 1, 1, 1, 2, 1, 1, 1, 2,\
                                         2, 1, 1, 1, 2, 2, 2, 3, 2, 2, 1, 0, 0])
    end
  end

  describe 'check_indent' do
    it 'returns an array of pairs' do
      expect(test.check_indent).to be_kind_of(Array)
    end
    it 'returns an array of pairs' do
      expect(test.check_indent[0]).to eql([19, 2])
    end
    it 'returns an array of pairs' do
      expect(test.check_indent).to eql([[19, 2]])
    end
  end

  describe 'method_check' do
    it 'returns an array' do
      expect(test.method_check).to be_kind_of(Array)
    end

    it 'returns an array' do
      expect(test.method_check).to eql([[2, 3], [6, 3], [10, 4], [15, 8]])
    end
  end
end

# rubocop:enable Metrics/PerceivedComplexity
# rubocop:enable Metrics/CyclomaticComplexity
# rubocop:enable Metrics/AbcSize
# rubocop:enable Metrics/MethodLength
# rubocop:enable Layout/LineLength
# rubocop:enable Metrics/BlockLength

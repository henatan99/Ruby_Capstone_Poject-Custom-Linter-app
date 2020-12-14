require_relative '../lib/file_checker'
require_relative '../lib/file_reader'
# test examples
describe CheckFile do
  let(:test_file) { ReadFile.new('example.txt') }
  let(:file_object) { test_file.read_lines }
  let(:parsed_line) { test_file.parse_lines }
  let(:test) { CheckFile.new(file_object, parsed_line) }
  let(:file_test) { File.new('example.txt') }

  describe 'initialize' do
    it 'creates a CheckFile object' do
      expect(test).to be_kind_of(CheckFile)
    end

    it 'creates a CheckFile object' do
      expect(file_object[4][5]).to eql(nil)
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

  describe 'line_sizes' do
    it 'returns an array' do
      expect(test.line_sizes(10)).to be_kind_of(Array)
    end
    it 'returns an ArumentError' do
      expect { test.line_sizes }.to raise_error(ArgumentError)
    end
    it 'returns an ArumentError' do
      expect { test.line_sizes }.to raise_error(ArgumentError)
    end
    it 'returns index Array of too long lines' do
      expect(test.line_sizes(35)).to eql([[2, 38], [7, 42], [19, 38], [28, 38]])
    end
  end

  describe 'white_space' do
    it 'returns nil' do
      expect(test.white_space(' shfsh')).to eql(nil)
    end
    it 'returns nil' do
      expect(test.white_space(' shfsh hkh')).to eql(nil)
    end
    it 'returns column for white space eol' do
      expect(test.white_space(' shfsh ')).to eql(7)
    end
    it 'returns column for white space eol' do
      expect(test.white_space(' ')).to eql(1)
    end
    it 'returns nil when line is empty' do
      expect(test.white_space('')).to eql(nil)
    end
  end

  describe 'line_spaces' do
    it 'returns an Array' do
      expect(test.line_space).to be_kind_of(Array)
    end
    it 'returns an Array' do
      expect(test.line_space).to eql([[3, 30], [5, 3], \
                                      [7, 42], [10, 19], [18, 24], [36, 5]])
    end
  end

  describe 'method_indent' do
    it ' returns the index of method start' do
      expect(test.method_indent).to eql([[2, 0], \
                                         [6, 1], [10, 1], [15, 1], [24, 1]])
    end
  end

  describe 'line_level' do
    it ' returns the relative level of a line' do
      expect(test.line_level(parsed_line[2], parsed_line[1])).to eql(1)
    end
  end

  describe 'line_indent' do
    it ' returns the standard indent of a line' do
      expect(test.line_indent[2]).to eql(2)
    end
    it ' returns the standard indent of a line' do
      expect(test.line_indent[6]).to eql(2)
    end
    it ' returns the standard indent of a line' do
      expect(test.line_indent[5]).to eql(1)
    end
  end

  describe 'check_indent' do
    it 'returns the array of wrong indented lines' do
      expect(test.check_indent).to eql([[6, 1], \
                                        [16, -2], [19, 2], [25, -2], [28, 2]])
    end
  end

  describe 'method_check' do
    it 'returns arrau of method index with too long' do
      expect(test.method_check(15)).to eql([[24, 20]])
    end
  end

  describe 'empty_line' do
    it 'returns array of index of unecessary empty lines' do
      expect(test.empty_line).to eql([30, 36])
    end
  end
end

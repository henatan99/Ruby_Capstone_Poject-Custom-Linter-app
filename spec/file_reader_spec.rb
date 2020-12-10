require_relative '../lib/file_reader'
describe ReadFile do
  let(:test_file) { ReadFile.new('example.txt') }
  let(:no_file) { ReadFile.new('tssh.txt') }
  describe 'initialize' do
    it ' creates a ReadFile object' do
      expect(test_file).to be_kind_of(ReadFile)
    end
    it ' creates a ReadFile object with arbitrary name' do
      expect(no_file).to be_kind_of(ReadFile)
    end
    it ' creates a ReadFile object' do
      expect(no_file.file_name).to eql('tssh.txt')
    end
  end

  describe 'open_file' do
    it ' opens object of File class' do
      expect(test_file.open_file).to be_kind_of(File)
    end
    it ' raises error when no file found' do
      expect { no_file.open_file }.to raise_error(Errno::ENOENT)
    end
  end

  describe 'read_lines' do
    it ' returns a line as a string when called with index' do
      expect(test_file.read_lines[1]).to eq "  def initialize(file_name = 'empty')\n"
    end

    it ' stores the file in line by line elements array' do
      expect(test_file.read_lines).to be_kind_of(Array)
    end

    it " doesn't return error when index is out of range" do
      expect { test_file.read_lines[26] }.not_to raise_error
    end

    it ' returns nil when index is out of range' do
      expect(test_file.read_lines[26]).to eql(nil)
    end

    it ' returns methiod error when index is out of range' do
      expect(test_file.read_lines.size).to eql(24)
    end
  end

  describe 'parse_lines' do
    it 'returns array of parsed lines by white space delimitter' do
      expect(test_file.parse_lines).to be_kind_of(Array)
    end
    it ' ' do
      expect(test_file.parse_lines[1][0]).not_to eq ' '
    end
    it ' ' do
      expect(test_file.parse_lines[1].last).to eq ''
    end
    it ' ' do
      expect(test_file.parse_lines[4]).to eql([''])
    end
    it ' ' do
      expect(test_file.parse_lines[1].last).not_to eql(nil)
    end
    it ' ' do
      expect(test_file.parse_lines.size).to eql(24)
    end
  end
end

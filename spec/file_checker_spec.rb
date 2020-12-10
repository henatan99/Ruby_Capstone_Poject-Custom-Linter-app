require_relative '../lib/file_checker'
require_relative '../lib/file_reader'

describe CheckFile do 
    let(:test_file) {ReadFile.new('example.rb')}
    let(:file_object) {test_file.read_lines}
    let(:parsed_line) {test_file.parse_lines}
    let(:test){CheckFile.new(file_object, parsed_line)}
    describe "initialize" do         
        it "creates a CheckFile object" do 
            expect(test).to be_kind_of(CheckFile)
        end 
    end

    describe "lines" do 
        it "returns an array of size 3" do 
            expect(test.lines).to be_kind_of(Array)
        end 
    end

    describe "line_level" do 
        it "returns an array of size 2" do 
            expect(test.line_level).to be_kind_of(Array)
        end 
    end

    describe "check_indent" do 
        it "returns an array of pairs" do 
            expect(test.check_indent).to be_kind_of(Array)
        end 
    end

    describe "method_check" do 
        it "returns an array" do 
            expect(test.method_check).to be_kind_of(Array)
        end 
    end
end 
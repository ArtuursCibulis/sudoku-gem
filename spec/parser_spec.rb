require "sudoku"

describe Parser do
    describe "parse" do
        context "given a sudoku field in string format" do
            let(:puzzle_string) { File.read("spec/fixtures/simple.sudoku") }
            it "returns ready instance of a Board class" do
                expect(Parser.parse(puzzle_string)).to be_a(Board)
            end
        end
    end
end

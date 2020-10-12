# require 'irb'
require "sudoku"


describe Validator do
    let(:board) {Parser.parse(puzzle_string)} 
    describe "valid?" do
        context "receives an instance of a board class" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            it "using Board methods it checks if sudoku is correct" do
                # binding.irb
                expect(Validator.new(board).valid?).to be_truthy
            end
        end
    end
end
require "sudoku"

describe Board do
    let(:board) {Parser.parse(puzzle_string)} 
    describe "columns" do
        let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
        it "returns array of columns" do
            expect(board.columns).to eq([
                [8, 7, 1, 9, 3, 2, 4, 6, 5], 
                [5, 2, 6, 8, 7, 4, 3, 1, 9], 
                [9, 3, 4, 6, 5, 1, 2, 7, 8], 
                [6, 8, 3, 1, 2, 5, 9, 4, 7], 
                [1, 5, 7, 4, 6, 9, 8, 2, 3], 
                [2, 4, 9, 7, 8, 3, 1, 5, 6], 
                [4, 1, 5, 3, 9, 7, 6, 8, 2], 
                [3, 6, 2, 5, 1, 8, 7, 9, 4], 
                [7, 9, 8, 2, 4, 6, 5, 3, 1]
            ])
        end
    end

    describe "filled?" do
        context "with completed board" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            it "returns true" do
                expect(board.filled?).to be true
            end
        end

        context "with incompleted board" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_incomplete.sudoku") }
            it "returns false" do
                expect(board.filled?).to be false
            end
        end
    end

    describe "valid?" do
        context "with valid sudoku" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            it "returns true" do
                expect(board.valid?).to be true
            end
        end

        context "with invalid sudoku" do
            let(:puzzle_string) { File.read("spec/fixtures/invalid_due_to_row_dupe.sudoku") }
            it "returns false" do
                expect(board.valid?).to be false
            end
        end
    end

    describe "subgroups" do
        context "given a sudoku field" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            it "returns array with sudoku fields subgroups" do
                expect(board.subgroups).to eq([
                    [[8, 5, 9], [7, 2, 3], [1, 6, 4]], 
                    [[6, 1, 2], [8, 5, 4], [3, 7, 9]], 
                    [[4, 3, 7], [1, 6, 9], [5, 2, 8]], 
                    [[9, 8, 6], [3, 7, 5], [2, 4, 1]], 
                    [[1, 4, 7], [2, 6, 8], [5, 9, 3]], 
                    [[3, 5, 2], [9, 1, 4], [7, 8, 6]], 
                    [[4, 3, 2], [6, 1, 7], [5, 9, 8]], 
                    [[9, 8, 1], [4, 2, 5], [7, 3, 6]], 
                    [[6, 7, 5], [8, 9, 3], [2, 4, 1]]
                ])
            end
        end
    end

    describe "to_s" do
        let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
        it "returns string which is like .sudoku file" do
            expect(board.to_s).to eq(puzzle_string)
        end
    end

    describe "insert" do
        context "with passed value being a number" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_incomplete.sudoku") }
            let(:x) {2}
            let(:y) {3}
            let(:val) {7}
            let(:new_array) do
                idk = Parser.parse_to_array(puzzle_string)
                idk[x][y] = val
                idk
            end
            it "returns updated array" do
                expect(board.insert(x, y, val)).to eq(new_array)
                expect(board.array).not_to eq(new_array)
            end
        end

        context "with passed value not being a number" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_incomplete.sudoku") }
            let(:x) {1}
            let(:y) {2}
            let(:val) {'z'}
            it "returns error message" do
                expect{board.insert(x, y, val)}.to raise_error(PermissionDeniedError, "Kļūda! Ievadīt var tikai 1-9")
            end
        end

        context "with locked being true" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            let(:x) {4}
            let(:y) {3}
            let(:val) {1}
            it "returns error" do
                expect{board.insert(x, y, val)}.to raise_error(PermissionDeniedError, "Šo vērtību nevar izmainīt")
            end
        end
    end

    describe "insert!" do
        context "with passed value being a number" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_incomplete.sudoku") }
            let(:x) {5}
            let(:y) {3}
            let(:val) {7}
            let(:new_array) do
                Parser.parse(puzzle_string)
                board.insert!(x, y, val)
            end
            it "returns updated array" do
                expect(board.insert!(x, y, val)).to eq(new_array)
            end
        end

        context "with passed value not being a number" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_incomplete.sudoku") }
            let(:x) {5}
            let(:y) {3}
            let(:val) {'z'}
            it "returns error message" do
                expect{board.insert(x, y, val)}.to raise_error(PermissionDeniedError, "Kļūda! Ievadīt var tikai 1-9")
            end
        end

        context "with locked being true" do
            let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
            let(:x) {2}
            let(:y) {1}
            let(:val) {9}
            it "returns error" do
                expect{board.insert(x, y, val)}.to raise_error(PermissionDeniedError, "Šo vērtību nevar izmainīt")
            end
        end
    end

    describe "[]" do
        let(:puzzle_string) { File.read("spec/fixtures/valid_complete.sudoku") }
        it "allows to access array data through another board instance" do
            expect(board[5]).to eq([2, 4, 1, 5, 9, 3, 7, 8, 6])
        end
    end
end

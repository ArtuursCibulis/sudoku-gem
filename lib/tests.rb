require 'sudoku'

board = Parser.parse(File.read("spec/fixtures/valid_incomplete.sudoku"))

def skaitla_ievade(board)
    puts board
    puts "Ievadi x koordinātu!"
    x = iziet
    puts "Ievadi y koordinātu!"
    y = iziet
    puts "Ievadi skaitli, kuru vēlies ievietot!"
    val = iziet
    board.insert!(x, y, val)
    puts board
    gets
    system("clear")
rescue PermissionDeniedError => e
    p e
    retry
end

loop do
    skaitla_ievade(board)
    if board.filled?
        puts "esi aizpildijis sudoku. tagad to var pārbaudīt"
        if board.valid?
            puts "sudoku ir pareizs"
            return
        else
            puts "sudoku nav pareizs. izlabo kļūdas"
        end
    end
end

def iziet
    Integer(gets == "beigt" && exit)
end


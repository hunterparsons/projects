import Sudoku as sud
degree = 0 # indicates size of board (e.g. 9 is 9x9)
while degree < 1 or degree == 5 or degree == 7 or degree > 9:
    print("5 & 7 are NOT valid inputs")
    degree = int(input("How width and height of your board (max 9)? "))
    if degree < 1 or degree == 5 or degree == 7 or degree > 9:
        print("Invalid Input!")
sudoku = sud.Sudoku(degree) # Initializes board
# Allows user to add numbers to specific cells
print("Add spaces:")
cont = input("Would you like to add a number to a space? (y/n) ")
# Input validation
while cont != 'n' and cont != 'y':
    print("Invalid input! Please type 'y' or 'n'")
    cont = input("Would you like to add a number to a space? (y/n) ")
while cont != 'n':
    num = int(input("What number would you like to add? ")) # choose number to add
    # Input validation
    while num > sudoku.degree or num < 1:
        print(f"Number has to be between 1 and {sudoku.degree}!")
        num = int(input("What number would you like to add? "))
    row = int(input("What row would you like to add it to? ")) # select row
    # Input validation
    while row > sudoku.degree or row < 1:
        print(f"Row has to be between 1 and {sudoku.degree}!")
        row = int(input("What row would you like to add it to? "))
    col = int(input("What column would you like to add it to? ")) # select column
    # Input validation
    while col > sudoku.degree or col < 1:
        print(f"Column has to be between 1 and {sudoku.degree}!")
        col = int(input("What column would you like to add it to? "))
    sudoku.add_cell(num, row, col) # adds cell
    cont = input("Would you like to add a number to a space? (y/n) ")
    # Input validation
    while cont != 'n' and cont != 'y':
        print("Invalid input! Please type 'y' or 'n'")
        cont = input("Would you like to add a number to a space? (y/n) ")
print("Initial Board:")
sudoku.print_board()
print("Solved Board:")
sudoku.solve_sudoku()
sudoku.print_board()
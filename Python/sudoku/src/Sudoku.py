import numpy as np
class Sudoku:
    # Pre : None
	# Post : sets all member variables of the class
	# Purpose : serves as a default constructor if a degree is not passed in, automatically creates 9x9
    def __init__(self):
        self.degree = 9
        self.gridWidth = 3
        self.gridHeight = 3
        self.gridRowTot = 3
        self.gridColTot = 3
        self.board = np.full((self.gridRowTot, self.gridColTot, self.gridHeight, self.gridWidth), 0)
	# Pre : degree should be between 1 and 9
	# Post : sets all member variables of the class
	# Purpose : serves as constructor for sudoku class when given a degree
    def __init__(self, degree):
        self.degree = degree
        if degree == 1:
            self.gridWidth = 1
            self.gridHeight = 1
            self.gridRowTot = 1
            self.gridColTot = 1
        elif degree == 2:
            self.gridWidth = 1
            self.gridHeight = 1
            self.gridRowTot = 2
            self.gridColTot = 2
        elif degree == 3:
            self.gridWidth = 1
            self.gridHeight = 1
            self.gridRowTot = 3
            self.gridColTot = 3
        elif degree == 4:
            self.gridWidth = 2
            self.gridHeight = 2
            self.gridRowTot = 2
            self.gridColTot = 2
        elif degree == 6:
            self.gridWidth = 3
            self.gridHeight = 2
            self.gridRowTot = 3
            self.gridColTot = 2
        elif degree == 8:
            self.gridWidth = 4
            self.gridHeight = 2
            self.gridRowTot = 4
            self.gridColTot = 2
        elif degree == 9:
            self.gridWidth = 3
            self.gridHeight = 3
            self.gridRowTot = 3
            self.gridColTot = 3
        self.board = np.full((self.gridRowTot, self.gridColTot, self.gridHeight, self.gridWidth), 0)
    # Pre: Row and column should be between one and the degree of the board.
    # Post: Updates board at given row and column.
    # Purpose: Adds number to the given row and column.
    def add_cell(self, num, subRow, subCol):
        # Update subRow and subCol to match 0 indexing
        subRow -= 1
        subCol -= 1
        # Gets the grid that the row and column are in
        gridRow = subRow // self.gridWidth
        gridCol = subCol // self.gridHeight
        # Updates subrow to match coordinates within a smaller grid
        subRow = subRow % self.gridWidth
        subCol = subCol % self.gridHeight
        # Checks to make sure number isn't out of bounds
        if gridCol >= self.gridColTot or gridRow >= self.gridRowTot:
            raise("Out of Bounds!") 
        # Checks to make sure the added number doesn't make board impossible
        if self.check_col(num, gridCol, subCol):
            print(f"This column already contains {num} and would make the board impossible!")
            return
        elif self.check_row(num, gridRow, subCol):
            print(f"This row already contains {num} and would make the board impossible!")
            return
        elif self.check_sub_grid(num, gridRow, gridCol):
            print(f"This grid already contains {num} and would make the board impossible!")
            return
        self.board[gridRow][gridCol][subRow][subCol] = num
    # Pre : none
    # Post : solves sudoku board if possible
    # Purpose : solve the given board of sudoku, function user calls
    def solve_sudoku(self):
        if not self.solve_sudoku_helper(0,0,0,0):
            print("This board cannot be solved!")
    # Pre: all parameters should be greater than -1 and less than their counterpart member variables (gridRow corresponds to totGridRows etc.)
    # Post: if cell is empty, it puts a valid number in the given cell, and moves onto the next through recursion, if no numbers work on following call, the next cell is now empty and returns back to calling function to try other numbers
    # Purpose: Solve sudoku through recursive backtracking and passing in position in the grid
    def solve_sudoku_helper(self, gridRow, gridCol, subRow, subCol):
        done = self.at_end(gridRow)
        num = 1
        taken = False
        if (done):
            return True
        # Checks to see if the spot has already been taken before solving
        if self.board[gridRow][gridCol][subRow][subCol] != 0:
            taken = True
            done = self.solve_sudoku_helper(*self.next_cell(gridRow, gridCol, subRow, subCol))
        while not done and num < self.degree + 1 and not taken: # Exits if done becomes true, the number is > degree, or if the cell 	was already taken
            if not (self.check_row(num, gridRow, subRow) or self.check_col(num, gridCol, subCol) or self.check_sub_grid(num, gridRow, gridCol)):
                self.board[gridRow][gridCol][subRow][subCol] = num
                done = self.solve_sudoku_helper(*self.next_cell(gridRow, gridCol, subRow, subCol))
            num += 1
        # If the cell ended up not being properly filled, replace number with a 0
        if not done and not taken:
            self.board[gridRow][gridCol][subRow][subCol] = 0

        return done
    # Pre: all parameters should be greater than -1 and less than their counterpart member variables (gridRow corresponds to totGridRows etc.)
    # Post: returns next cell if moving horizontally through board
    # Purpose: used to get next cell needed for solution
    def next_cell(self, gridRow, gridCol, subRow, subCol):
        subCol += 1
        if subCol == self.gridWidth:
            subCol = 0
            gridCol += 1
            if gridCol == self.gridColTot:
                gridCol = 0
                subRow += 1
                if subRow == self.gridHeight:
                    subRow = 0
                    gridRow += 1
        return gridRow, gridCol, subRow, subCol
    # Pre: pNum should be less than the degree + 1, and greater than 0, other parameters should be greater than -1 and less than their counterpart member variables (gridRow corresponds to totGridRows etc.)
    # Post: returns true if a number is in a sub grid, false otherwise
    # Purpose: to check if a number is present in a smaller grid
    def check_row(self, pNum, gridRow, subRow):
        for gridCol in range(self.gridColTot):
            for subCol in range(self.gridWidth):
                if (self.board[gridRow][gridCol][subRow][subCol] == pNum):
                    return True
        return False
    # Pre: pNum should be less than the degree + 1, and greater than 0, other parameters should be greater than -1 and less than their counterpart member variables (gridRow corresponds to totGridRows etc.)
    # Post: returns true if a number is in a sub grid, false otherwise
    # Purpose: to check if a number is present in a smaller grid
    def check_col(self, pNum, gridCol, subCol): # col will need to be changed so that the array can be : arr[i][constant1][j][constant2]
        for gridRow in range(self.gridRowTot):
            for subRow in range(self.gridHeight):
                if (self.board[gridRow][gridCol][subRow][subCol] == pNum):
                    return True
        return False
    # Pre: pNum should be less than the degree + 1, and greater than 0, other parameters should be greater than -1 and less than their counterpart member variables (gridRow corresponds to totGridRows etc.)
    # Post: returns true if a number is in a sub grid, false otherwise
    # Purpose: to check if a number is present in a smaller grid
    def check_sub_grid(self, pNum, gridRow, gridCol): #returns true if pnum matches num in grid
        for x in self.board[gridRow][gridCol]:
            for num in x:
                if num == pNum:
                    return True
        return False
    # Pre: none
    # Post: returns true if at the end (indicative by the value of gridRow), and false otherwise
    # Purpose: checks if at the end of the board
    def at_end(self, gridRow):
        if gridRow == self.gridRowTot:
            return True
        return False
    # Pre: none
    # Post: prints the board formatted
    # Purpose: prints the entire board
    def print_board(self): #have to print row by row, not easy with this array system
        for gridRow in range(self.gridRowTot):
            for subRow in range(self.gridHeight):
                for gridCol in range(self.gridColTot):
                    for subCol in range(self.gridWidth):
                        print(self.board[gridRow][gridCol][subRow][subCol], end=' ')
                    print(end='  ')
                print()
            print()

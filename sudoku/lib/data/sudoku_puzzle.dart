import 'dart:math';

List<List<int>> generateSudokuGrid(){
  List<List<int>> grid=List.generate(9, (_) => List.generate(9,(_)=>0));
  fillGrid(grid);
  return grid;
}

bool fillGrid(List<List<int>> grid){
  int row=0;
  int col=0;
  for(int i=0;i<81;i++){
    row=i~/9;
    col=i%9;
    if(grid[row][col]==0){
      List<int> numbers = List.generate(9, (index) => index + 1)..shuffle();
      for(int number in numbers){
        if(isValid(grid,row,col,number)){
          grid[row][col]=number;
          if(isGridFull(grid)){
            return true;
          }else{
            if (fillGrid(grid)) {
              return true;
            }
          }
          grid[row][col] = 0;
        }
      }
      return false;
    }
  }
  return true;
}

bool isGridFull(List<List<int>> grid){
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (grid[row][col] == 0) {
        return false;
      }
    }
  }
  return true;
}

bool isValid(List<List<int>> grid, int row, int col, int number) {
  for (int i = 0; i < 9; i++) {
    if (grid[row][i] == number || grid[i][col] == number) {
      return false;
    }
  }
  int startRow = row - row % 3;
  int startCol = col - col % 3;
  for (int i = 0; i < 3; i++) {
    for (int j = 0; j < 3; j++) {
      if (grid[startRow + i][startCol + j] == number) {
        return false;
      }
    }
  }
  return true;
}

List<List<int>> removeNumbersFromGrid(List<List<int>> grid, int blanks) {
  Random random = Random();
  while (blanks > 0) {
    int row = random.nextInt(9);
    int col = random.nextInt(9);
    if (grid[row][col] != 0) {
      grid[row][col] = 0;
      blanks--;
    }
  }
  return grid;
}

List<List<int>> generateNewSudokuPuzzle(String level) {
  List<List<int>> grid = generateSudokuGrid();

  int blanks;
  switch (level) {
    case 'Easy':
      blanks = 40;
      break;
    case 'Medium':
      blanks = 50;
      break;
    case 'Hard':
      blanks = 60;
      break;
    default:
      throw Exception('Invalid level');
  }
  return removeNumbersFromGrid(grid, blanks);
}

bool solveSudoku(List<List<int>> grid) {
  int row = 0;
  int col = 0;
  List<int> emptySpot = findEmptyLocation(grid);
  row = emptySpot[0];
  col = emptySpot[1];


  if (row == -1 && col == -1) {
    return true;
  }

  for (int num = 1; num <= 9; num++) {
    if (isValid(grid, row, col, num)) {
      grid[row][col] = num;
      if (solveSudoku(grid)) {
        return true;
      }
      grid[row][col] = 0; // Backtrack
    }
  }
  return false;
}

List<int> findEmptyLocation(List<List<int>> grid) {
  List<int> location = [-1, -1];
  for (int row = 0; row < 9; row++) {
    for (int col = 0; col < 9; col++) {
      if (grid[row][col] == 0) {
        location[0] = row;
        location[1] = col;
        return location;
      }
    }
  }
  return location;
}


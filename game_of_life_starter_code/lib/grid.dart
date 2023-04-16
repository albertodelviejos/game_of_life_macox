import 'package:game_of_life_starter_code/alive_cell.dart';
import 'package:game_of_life_starter_code/dead_cell.dart';

import 'cell.dart';

class Grid {
  final int _gridHeight;
  final int _gridWidth;
  List<List<Cell>>? _gridMatrix;

  Grid({required int gridHeight, required int gridWidth})
      : _gridHeight = gridHeight,
        _gridWidth = gridWidth;

  void initializeEmptyGrid() {
    _gridMatrix = [];
    for (int i = 0; i < _gridHeight; i++) {
      _gridMatrix!.add(List.generate(_gridWidth, (index) => DeadCell()));
    }
  }

  get getGridMatrix => _gridMatrix;
  get getGridHeight => _gridHeight;
  get getGridWidth => _gridWidth;

  void updateValuesFromBinaryList(List<List<int>> initialValues) {
    for (int i = 0; i < _gridHeight; i++) {
      for (int j = 0; j < _gridWidth; j++) {
        _gridMatrix![i][j] =
            (initialValues[i][j] == 1) ? AliveCell() : DeadCell();
      }
    }
  }

  void buildNextIteration() {
    List<List<int>> nextGrid =
        List.generate(_gridWidth, (_) => List.filled(_gridHeight, 0));
    for (int i = 0; i < _gridHeight; i++) {
      for (int j = 0; j < _gridWidth; j++) {
        int neighbors = _countAliveNeighbors(i, j);
        if (_gridMatrix![i][j] is AliveCell) {
          if (neighbors == 2 || neighbors == 3) {
            nextGrid[i][j] = 1;
          } else {
            nextGrid[i][j] = 0;
          }
        } else {
          if (neighbors == 3) {
            nextGrid[i][j] = 1;
          } else {
            nextGrid[i][j] = 0;
          }
        }
      }
    }
    updateValuesFromBinaryList(nextGrid);
  }

  void binaryListDebugPrinter(List<List<int>> binaryList) {
    String visual = '';
    for (var element in binaryList) {
      for (var element2 in element) {
        visual += '$element2';
      }
      visual += '\n';
    }
    print(visual);
  }

  int _countAliveNeighbors(int row, int column) {
    int count = 0;
    for (int i = -1; i <= 1; i++) {
      for (int j = -1; j <= 1; j++) {
        if (i == 0 && j == 0) continue;
        int r = row + i;
        int c = column + j;
        if (r >= 0 &&
            r < _gridHeight &&
            c >= 0 &&
            c < _gridWidth &&
            _gridMatrix![r][c] is AliveCell) {
          count++;
        }
      }
    }
    return count;
  }
}

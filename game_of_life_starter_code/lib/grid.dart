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

  void _initializeEmptyGrid() {
    _gridMatrix = [];
    for (int i = 0; i < _gridHeight; i++) {
      _gridMatrix!.add(List.generate(_gridWidth, (index) => DeadCell()));
    }
  }

  get gridMatrix => _gridMatrix;

  void setInitialValues(List<List<int>> initialValues) {
    for (int i = 0; i < _gridHeight; i++) {
      for (var element in initialValues[i]) {
        if (element == 1) {
          _gridMatrix![i][initialValues[i].indexOf(element)] = AliveCell();
        }
      }
    }
  }

  void buildNextIteration(){
    //TODO Logic Of The Game
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
            _gridMatrix[r][c] == _alive) {
          count++;
        }
      }
    }
    return count;
  }
}

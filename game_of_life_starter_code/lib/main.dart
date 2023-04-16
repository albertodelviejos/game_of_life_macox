import 'package:flutter/material.dart';
import 'package:game_of_life_starter_code/alive_cell.dart';
import 'package:game_of_life_starter_code/timer_singleton.dart';

import 'grid.dart';

const int _alive = 1;
const int _dead = 0;
bool isFirstTime = true;
TimerSingleton _timerSingleton = TimerSingleton.instance;

void main() {
  //add this
  runApp(
    const MaterialApp(home: GameOfLife()),
  );
}

class GameOfLife extends StatefulWidget {
  const GameOfLife({Key? key}) : super(key: key);

  @override
  _GameOfLifeState createState() => _GameOfLifeState();
}

class _GameOfLifeState extends State<GameOfLife> {
  late final Grid _grid = Grid(gridHeight: 30, gridWidth: 30);
  final List<List<int>> _visualGrid = [];

  @override
  void initState() {
    super.initState();
    _grid.initializeEmptyGrid();
    for (int i = 0; i < _grid.getGridHeight; i++) {
      _visualGrid.add(List.generate(_grid.getGridWidth, (_) => 0));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Generation ${_timerSingleton.tick}'),
      ),
      body: GridView.count(
        crossAxisCount: _grid.getGridWidth,
        children:
            List.generate(_grid.getGridHeight * _grid.getGridWidth, (index) {
          int row = index ~/ _grid.getGridWidth;
          int column = index % _grid.getGridHeight as int;
          return GestureDetector(
            onTap: () => setState(() {
              _visualGrid[row][column] = 1;
            }),
            child: Container(
              decoration: BoxDecoration(
                color: (isFirstTime
                        ? (_visualGrid[row][column] == 1)
                        : (_grid.getGridMatrix[row][column] is AliveCell))
                    ? Colors.black
                    : Colors.white,
                border: Border.all(color: Colors.grey),
              ),
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (isFirstTime) {
            _grid.updateValuesFromBinaryList(_visualGrid);
            _grid.binaryListDebugPrinter(_visualGrid);
            isFirstTime = false;
            _timerSingleton.startTimer(
                onTick: () => setState(() {
                      _grid.buildNextIteration();
                    }));
          }
          // setState(() {
          //   _grid.buildNextIteration();
          // });
        },
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}

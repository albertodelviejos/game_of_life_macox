import 'cell.dart';

class AliveCell implements Cell {
  final CellStateEnum _state = CellStateEnum.alive;

  @override
  void getState() => _state;
}

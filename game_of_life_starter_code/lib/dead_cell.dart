import 'cell.dart';

class DeadCell implements Cell{
  final CellStateEnum _state = CellStateEnum.dead;

  @override
  void getState() => _state;
}
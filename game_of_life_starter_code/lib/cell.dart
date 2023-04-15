abstract class Cell {
  final CellStateEnum _state = CellStateEnum.dead;

  void getState();
}

enum CellStateEnum {
  alive,
  dead,
}

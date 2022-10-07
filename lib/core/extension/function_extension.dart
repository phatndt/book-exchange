
extension Ext on Object? {
  void ifNotEmpty(Function() action, Function() empty) {
    if (this != "") {
      action();
    } else {
      empty();
    }
  }
}

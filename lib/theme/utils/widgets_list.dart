import '../theme.dart';

/// Add a given widget between each widget of a list.
extension XWidgetsList on List<Widget> {
  List<Widget> separateWith(Widget gap) {
    List<Widget> newList = [];
    for (int i = 0; i < length; i++) {
      newList.add(this[i]);
      if (i < length - 1) {
        newList.add(gap);
      }
    }
    return newList;
  }
}

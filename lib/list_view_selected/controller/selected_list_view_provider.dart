import 'package:flutter/cupertino.dart';

import '../model/Select_item_model.dart';

class SelectedListViewProvider extends ChangeNotifier {
  List<SelectItemModel> listItems = List.generate(
      20, (index) => SelectItemModel('Main Title', 'SubTitle', false));
  bool inSelctionMode = false;
  void toggleChecked(int index) {
    listItems.elementAt(index).isChecked =
        !listItems.elementAt(index).isChecked;
    notifyListeners();
  }

  void enterInSelectionMode(int index) {
    inSelctionMode = true;
    toggleChecked(index);
  }

  void clearSelection() {
    for (var element in listItems) {
      if (element.isChecked) {
        element.isChecked = false;
      }
    }
    inSelctionMode = false;
    notifyListeners();
  }
}

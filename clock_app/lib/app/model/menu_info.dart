import 'package:clock_app/app/model/enums.dart';
import 'package:flutter/foundation.dart';

class MenuInfor extends ChangeNotifier {
  MenuType menuType;
  String? imageSource;
  String? title;

  MenuInfor(this.menuType, {this.imageSource, this.title});

  updateMenu(MenuInfor menuInfor) {
    this.menuType = menuInfor.menuType;
    this.title = menuInfor.title;
    this.imageSource = menuInfor.imageSource;
    notifyListeners();
  }
}

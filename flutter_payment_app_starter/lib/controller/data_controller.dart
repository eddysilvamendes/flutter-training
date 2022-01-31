import 'package:flutter_payment_app/models/data_models.dart';
import 'package:flutter_payment_app/services/data_service.dart';
import 'package:get/get.dart';

class DataController extends GetxController {
  RxList<DataModel> list = <DataModel>[].obs;
  final service = DataServices();
  var _loading = false.obs;

  get loading => _loading.value;

  @override
  void onInit() {
    _loadData();
    super.onInit();
  }

  get newList =>
      list.where((e) => e.status == 0 ? false : true).map((e) => e).toList();

  _loadData() async {
    _loading.value = false;
    try {
      var info = service.getUsers();
      list.addAll(await info);
    } catch (e) {
      print("Error!!");
      print(e);
    } finally {
      _loading.value = true;
    }
  }
}

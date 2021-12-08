import 'package:get/get.dart';
import 'package:marketplace_design/app/features/dashboard/explore/views/screen/explore_screen.dart';
import 'package:marketplace_design/app/features/dashboard/index/views/screens/dashboard_screen.dart';
import 'package:marketplace_design/app/features/product/product_detail/views/screens/product_detail.dart';

part 'app_routes.dart';

/// contains all configuration pages
class AppPages {
  /// when the app is opened this page will be the first to be shown
  static const initial = Routes.dashboard;

  static final routes = [
    GetPage(
      name: _Paths.dashboard,
      page: () => DashboardScreen(),
      bindings: [
        DashboradBinding(),
        ExploreBinding(),
      ],
    ),
    GetPage(
      name: _Paths.product + "/:id",
      page: () => ProductDetailScreen(),
      binding: ProductDetailBinding(),
      transition: Transition.downToUp,
    )
  ];
}

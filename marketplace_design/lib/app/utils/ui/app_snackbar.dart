part of ui_utils;

class AppSnackBar {
  static void showStatusFavoriteProduct(
      {required ImageProvider productImage,
      required String productName,
      required bool isFavorite}) {
    Get.snackbar(
      (isFavorite) ? "add to favorite" : "removed from favorites",
      productName,
      icon: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Image(
          image: productImage,
          fit: BoxFit.cover,
        ),
      ),
      colorText: kFontColorPallets[0],
      backgroundColor: Colors.white,
      isDismissible: true,
      duration: Duration(seconds: 1),
    );
  }
}

// ignore_for_file: constant_identifier_names

class AppConstants {
  static const String APP_NAME = "Cheff";
  static const int APP_VERSION = 1;

  static const String BASE_URL = "https://central.eddymendes.com";
  //static const String BASE_URL = "http://mvs.bslmeiyu.com";
  //static const String BASE_URL = "http://192.168.1.67:8000";

  //Products ENDPOINT
  static const String POPULAR_PRODUCT_URI = "/api/v1/products/popular";
  static const String RECOMENDED_PRODUCT_URI = "/api/v1/products/recommended";
  static const String PRODUCT_URI = "/api/v1/products/list";
  //static const String NATURAL_DRINKS_URI = "/api/v1/products/natural_drinks";
  static const String CATEGORIES_URI = "/api/v1/products/categories";
  static const String UPLOAD_URL = "/uploads/";

  //Address Endpoit
  static const String USER_ADDRESS = "user_address";
  static const String ADD_USER_ADDRESS = "/api/v1/customer/address/add";
  static const String GEOCODE_URI = "/api/v1/config/geocode-api";
  static const String ADDRESS_LIST_URI = "/api/v1/customer/address/list";
  static const String ZONE_URI = "/api/v1/config/get-zone-id";
  static const String SEARCH_LOCATION_URI =
      "api/v1/config/place-api-autocomplete";
  static const String PLACE_DETAILS_URI = "api/v1/config/place-api-details";

  //User and auth endPoint
  static const String REGISTRATION_URI = "/api/v1/auth/register";
  static const String LOGIN_URI = "/api/v1/auth/login";
  static const String USER_INFO_URI = "/api/v1/customer/info";

  static const String TOKEN = "";
  static const String PHONE = "";
  static const String PASSWORD = "";
  static const String CARTKEY = "Cart-list";
  static const String CART_HISTORY_KEY = "cart-history-list";

  //ORDER
  static const String PLACE_ORDER_URI = "api/v1/customer/order/place";
}

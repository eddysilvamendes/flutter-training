import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(clientId: _clientIDWeb);
  // ignore: prefer_const_declarations
  static final _clientIDWeb =
      '290408619996-ua414cprk0i33ks4bul48o8pa80pupli.apps.googleusercontent.com';

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future logout() => _googleSignIn.disconnect();
}

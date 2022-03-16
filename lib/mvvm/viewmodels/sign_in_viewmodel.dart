import 'package:ecommerce_qrcode/routes/routes.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SignInViewModel extends GetxController {
  var googleSignIn = GoogleSignIn(scopes: ['email']);
  GoogleSignInAccount? currentUser;
  Future<void> signIn() async {
    try {
      await googleSignIn.signIn();
      if (currentUser != null) {
        Get.toNamed(RouteName.homeScreen);
      }
    } catch (e) {
      print("Error signing in $e");
    }
  }

  GoogleSignInAccount? getUser() {
    return googleSignIn.currentUser;
  }
  
  void signOut() {
    googleSignIn.disconnect();
  }

  @override
  void onInit() {
    googleSignIn.onCurrentUserChanged.listen((account) {
      currentUser = account;
      if (currentUser != null) {
        Get.toNamed(RouteName.homeScreen);
      }
    });
    googleSignIn.signInSilently();
    super.onInit();
  }
}

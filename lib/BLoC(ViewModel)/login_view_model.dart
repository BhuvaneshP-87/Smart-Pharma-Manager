import 'package:pharmacy_store/UI/login/user_form.dart';
import 'package:pharmacy_store/UI/main_screens/landing_page.dart';
import 'package:pharmacy_store/resources/local_storage.dart';
import 'package:pharmacy_store/models/login_status.dart';
import 'package:pharmacy_store/resources/auth_services.dart';
import 'package:pharmacy_store/UI/login/login_screen.dart';



class LoginViewModel{

  LoginStatus instance=new LoginStatus();


  Future setLoginStatus(value) async{
    await LocalStorage().setLoginCompleted(value);
    instance.isLoggedIn=await LocalStorage().getLoginCompleted();
  }

  Future setUserFormStatus(value) async{
    await LocalStorage().setUserForm(value);
    instance.isUserForm=await LocalStorage().getUserForm();
  }

  Future checkScreenStatus() async {
    print("Called");
    instance.isLoggedIn = await LocalStorage().getLoginCompleted();
    instance.isLanguageSelected = await LocalStorage().getLanguageProcessComplete();
    instance.isUserForm=await LocalStorage().getUserForm();

    print("UserForm status: ${instance.isUserForm}");
    print("LoggedIn status: ${instance.isLoggedIn}");
    print("Onboarding status: ${instance.isOnBoardingDone}");

    //Cases for complete flow of module
    if (instance.isLoggedIn == null || !instance.isLoggedIn) {
      return LoginScreen();
    } else if (instance.isUserForm == null || !instance.isUserForm) {
      return Userform();
    } else {
      return LandingPage();
    }
  }

  Future signOut()async{
    await setLoginStatus(false);
    await AuthService().signOut();
  }
}
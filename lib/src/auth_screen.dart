//import 'package:country_code_picker/country_code_picker.dart';
//import 'package:country_code_picker/country_codes.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:passwordless/src/auth_bloc.dart';
import 'package:passwordless/src/auth_bloc_provider.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:passwordless/src/constants.dart';
import 'package:passwordless/src/property_list_db.dart';
import 'package:passwordless/src/repository.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
//import 'package:pin_view/pin_view.dart';
import 'login_page.dart';

class AuthScreen extends StatefulWidget {
  @override
  AuthScreenState createState() => AuthScreenState();
}

class AuthScreenState extends State<AuthScreen> {
  final _repository = Repository();
  AuthBloc _bloc;
  Locale _myLocale;
  FirebaseUser user;
  var existingemail;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _bloc = AuthBlocProvider.of(context);
    this.initDynamicLinks();
    _myLocale = Localizations.localeOf(context);

    /// We need to reflect the initial selection of the dialcode, in case the phone's selected locale
    /// matches the phone dial code, which is the majority of the cases.
    /// We do this by loading up a list of dialcodes and their respected country code, from there
    /// we find the matching dialcode for the phone's locale.
    /*List<CountryCode> elements = codes
        .map((s) => CountryCode(
              name: "",
              code: s['code'],
              dialCode: s['dial_code'],
              flagUri: "",
            ))
        .toList();
    String dialCode =
        elements.firstWhere((c) => c.code == _myLocale.countryCode).dialCode;
    _bloc.changeDialCode(dialCode);*/
  }

  void initDynamicLinks() async {
    final PendingDynamicLinkData data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri deepLink = data?.link;

    if (deepLink != null) {
      /// Change status to a loading state, so user would not get confused even for a second.
      _bloc.changeAuthStatus(AuthStatus.isLoading);
      _bloc
          .signInWIthEmailLink(
              await _bloc.getUserEmailFromStorage(), deepLink.toString())
          .whenComplete(() => _authCompleted());
      //.whenComplete() =>  _authCompleted());
    }
  }
 void _authCompleted() async {
    var email = await _bloc.getUserEmailFromStorage();
    print("email" + email); 
    Firestore.instance
        .collection("users")
        .where("email", isEqualTo: email.toLowerCase())
        .getDocuments()
        .then((string) {
      print('Firestore response111: , ${string.documents.length}');
      string.documents.forEach(
        (doc) =>   
            print("data available"),
      );
      if (string.documents.length == 0) {
        print("email not avilable");
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  existingemail: email.toString().toLowerCase(),
                )));
        } 
        else {
          print("email  alreadyexists");
            /*Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => FirstScreen(
                  email: email.toString(),
                )));*/
            Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => PropertyListdbScreen(
                  email: email.toString().toLowerCase(),
                )));    
        }
    });
  }


  /*_authCompleted() async {
    var email = await _bloc.getUserEmailFromStorage();
    print("email" + email);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
                  existingemail: email.toString(),
                )));
  }*/

  void init() {
    existingemail = "";
    super.initState();
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            StreamBuilder(
                stream: _bloc.authStatus,
                builder: (context, snapshot) {
                  switch (snapshot.data) {
                    case (AuthStatus.emailAuth):
                      return _authForm(true);
                      break;
                    case (AuthStatus.phoneAuth):
                      return _authForm(false);
                      break;
                    case (AuthStatus.emailLinkSent):
                      return Center(
                          child: Text(
                        Constants.sentEmail,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ));
                      break;
                    /*case (AuthStatus.smsSent):
                      return _smsCodeInputField();
                      break;*/
                    case (AuthStatus.isLoading):
                      return Center(child: CircularProgressIndicator());
                      break;
                    default:
                      // By default we will show the email auth form
                      return _authForm(true);
                      break;
                  }
                })
          ],
        ),
      ),
    );
  }

  /// Widget is specfied for auth method by [isEmail] value.
  /// If its false, a form for phone auth is given.
  /// This is to make it easier for the email and phone auth forms to be more similar looking.
  /// Keeping that in mind we'll try to share all the widgets to a reasonable extent.
  Widget _authForm(bool isEmail) {
    return StreamBuilder(
        stream: isEmail ? _bloc.email : _bloc.phone,
        builder: (context, snapshot) {
          //vijay
          return StreamBuilder<FirebaseUser>(
              stream: FirebaseAuth.instance.onAuthStateChanged,
              builder: (context, snapshot2) {
                if (snapshot2.connectionState == ConnectionState.active) {
                  user = snapshot2.data;
                }

                return SingleChildScrollView(
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        _emailInputField(snapshot.error),
                        SizedBox(
                          height: 32.0,
                        ),

                        SizedBox(
                          width: 300.0,
                          height: 60.0,
                          child: RaisedButton(
                            onPressed: () {
//                Widget user=_usercheck(snapshot.data.toString());
                              //  print("user.data"+user.toString());
                              print("user456" + user.toString());
                              print("user789" + snapshot2.data.toString());
                              //   print("existinduser"+snapshot2.data.email);
                              print("snapshot.data" +
                                  snapshot.data
                                      .toString()); //print data from auth
                              print("snapshot.hasData" +
                                  snapshot.hasData
                                      .toString()); //return true or false
                              //  FirebaseUser user=snapshot.data;
                              //  print("user"+user.toString());
                              if (snapshot.hasData) {
                                var currentemail = snapshot.data;
                                print(currentemail);
                                existingemail = snapshot2.data;
                                if (existingemail == null) {
                                  print("Not an existingemail first time login");
                                  _authenticateUserWithEmail();
                                } else {
                                   print("existingemail");
                                   Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => PropertyListdbScreen(
                                                email: existingemail.email,
                                              ))
                                              );
                                  /*Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => FirstScreen(
                                                email: existingemail.email,
                                              ))
                                              );*/
                                }
                              }
                            },
                            child: const Text(
                              'Next',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12))),
                            color: Color(0xff6839ed),
                          ),
                        ),
                        //  SizedBox(height: 32),
                        GestureDetector(
                            onTap: () => _bloc.changeAuthStatus(isEmail
                                ? AuthStatus.phoneAuth
                                : AuthStatus.emailAuth),
                            child: Text(
                              isEmail
                                  ? Constants.usePhone.toUpperCase()
                                  : Constants.useEmail.toUpperCase(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ]),
                );
                //);
              });
        });
  }

  /// The method takes in an [error] message from our validator.

  Widget _emailInputField(String error) {
    return Container(
      //  width: MediaQuery.of(context).size.width,
      //height: MediaQuery.of(context).size.height,
      //height: 400.0,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            new LinearPercentIndicator(
              padding: const EdgeInsets.symmetric(horizontal: 1.0),
              maskFilter: MaskFilter.blur(BlurStyle.solid, 1.0),
              animateFromLastPercent: true,
              //width: MediaQuery.of(context).size.width,
              //width: 100.0,
              animation: true,
              lineHeight: 25.0,
              percent: 0.2,
              progressColor: Color(
                0xffF43669,
              ),
              backgroundColor: Color(0xff151232),
            ),
            SizedBox(height: 32),
            Text(
              "Let's get started",
              textAlign: TextAlign.start,
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 30.0),
            ),
            SizedBox(height: 32),
            Text(
              "We'll use this information to do x,y and also z",
              style: TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
            ),
            SizedBox(height: 32),
            Align(
              alignment: Alignment(-.85, 0),
              //     widthFactor: left
              child: Container(
                // color: Color(0xffD6C9F5),
                child: Text(
                  "Your Email address",
                  style: TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                ),
              ),
            ),
            SizedBox(height: 32),
            Align(
              alignment: Alignment(-.100, 0),
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width - 100,
                decoration: new BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(12.0)),
                child: TextField(
                  onChanged: _bloc.changeEmail,
                  //  controller: existingemail,
                  keyboardType: TextInputType.emailAddress,
                  autofocus: false,

                  decoration: InputDecoration(
                    hintText: 'Email',
                    errorText: error,
                    //prefixIcon: Icon(Icons.mail),
                    contentPadding: EdgeInsets.all(20),

                    // contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                    //border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
                  ),
                ),
              ),
            ),

            SizedBox(height: 10),
            Align(
              alignment: Alignment.bottomRight,
              //     widthFactor: left
              child: Container(
                child: Text(
                  "By creating an account, you agree to our Terms of Services and privacy Policy ",
                  style: TextStyle(color: Color(0xffD6C9F5), fontSize: 15.0),
                ),
              ),
            ),
            //SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  /// Besides the user entering their phone number, we also need to know the user's country code
  /// for that we are gonna use a library CountryCodePicker.
  /// The method takes in an [error] message from our validator.
  /*Widget _phoneInputField(String error) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Flexible(
            child: Padding(
              padding: EdgeInsets.fromLTRB(0, 16, 0, 0),
               
              child: Container(),
            ),
          ),
          Expanded(
            flex: 2,
            child: TextField(
              onChanged: _bloc.changePhone,
              keyboardType: TextInputType.phone,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                hintText: Constants.enterPhone,
                errorText: error,
                labelText: Constants.labelPhone,
                labelStyle: TextStyle(
                  color: Colors.blue,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }*/

  /*Widget _smsCodeInputField() {
    return Column(children: <Widget>[
      PinView(
          count: 6, // describes the field number
          margin: EdgeInsets.all(2.5), // margin between the fields
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
          submit: (String smsCode) {
            AuthCredential credential = PhoneAuthProvider.getCredential(
                verificationId: _bloc.getVerificationId, smsCode: smsCode);
            _bloc.signInWithCredential(credential).then((result) =>
                // You could potentially find out if the user is new
                // and if so, pass that info on, to maybe do a tutorial
                // if (result.additionalUserInfo.isNewUser)
                _authCompleted());
          }),
    ]);
  }*/

  void _authenticateUserWithEmail() {
    _bloc.sendSignInWithEmailLink().whenComplete(() => _bloc
        .storeUserEmail()
        .whenComplete(() => _bloc.changeAuthStatus(AuthStatus.emailLinkSent)));
  }

  /*void _authenticateUserWithPhone() {
    PhoneVerificationFailed verificationFailed = (AuthException authException) {
      _bloc.changeAuthStatus(AuthStatus.phoneAuth);
      _showSnackBar(Constants.verificationFailed);

      print(
          'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
    };

    PhoneVerificationCompleted verificationCompleted =
        (AuthCredential phoneAuthCredential) {
      _bloc
          .signInWithCredential(phoneAuthCredential)
          .then((result) => _authCompleted());
      print('Received phone auth credential: $phoneAuthCredential');
    };

    PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      _bloc.changeVerificationId(verificationId);
      print(
          'Please check your phone for the verification code. $verificationId');
    };

    PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      print("auto retrieval timeout");
    };

    _bloc.changeAuthStatus(AuthStatus.smsSent);
    _bloc.verifyPhoneNumber(codeAutoRetrievalTimeout, codeSent,
        verificationCompleted, verificationFailed);
  }*/

  _showSnackBar(String error) {
    final snackBar = SnackBar(content: Text(error));
    Scaffold.of(context).showSnackBar(snackBar);
  }

  /*_authCompleted() {
    var email = _bloc.changeEmail;
    print(email);
    print(existingemail);
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) => LoginPage(
               existingemail:existingemail,
                )));
  }*/
}

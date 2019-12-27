 
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

 

class Ucreate extends StatefulWidget {
//Ucreate({this.username});
//final String username;
@override
  _UcreateState createState() => new _UcreateState();
}
  
class _UcreateState extends State<Ucreate> {
      FocusNode _focusNode = new FocusNode();

String dropdownValue;
 String msg='';
TextEditingController uname = new TextEditingController();
TextEditingController pass = new TextEditingController();
TextEditingController cpass = new TextEditingController();
TextEditingController addr = new TextEditingController();
TextEditingController phno = new TextEditingController();
TextEditingController aphno = new TextEditingController();
// String product_image;
  /// String p_img;


        void dispProduct(){
 // var url="http://192.168.122.1/ecart/disp_pimg.php";
    var url="http://fluttertest.000webhostapp.com/edisp_pimg.php";
  http.post(url, body: {
    //'id': widget.list[widget.index]['id']
  });
        }

 void usercreate(){
    //Future<List> usercreate() async {
  //var url="http://192.168.122.1/ecart/usercreation.php";
    var url="http://fluttertest.000webhostapp.com/eusercreation.php";

   print(uname.text);
  print(cpass.text);
   print(addr.text);
    print(phno.text);
     print(aphno.text);
http.post(url, body: {
      "username": uname.text,
      "password": cpass.text,
      "addr" : addr.text,
      "phno" : phno.text,
      "aphno" : aphno.text

     // "level":dropdownValue
    });


   }

          String name, email, mobile;

 

  final  formKey=GlobalKey<FormState>();
  final  scaffoldkey = GlobalKey<ScaffoldState>();
  @override
   void initState(){
        super.initState();
       // _focusNode.addListener(_focusNodeListener);
    }
    /* void dispose(){
        _focusNode.removeListener(_focusNodeListener);
        super.dispose();
    }
        Future<Null> _focusNodeListener() async {
        if (_focusNode.hasFocus){
            print('TextField got the focus');
        } else {
            print('TextField lost the focus');
        }
        }*/

  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldkey,
    // resizeToAvoidBottomPadding: false,
            // resizeToAvoidBottomPadding: true,

      appBar: AppBar(title: Text("Welcome"),),
      //added scroll to scroll screen, I commented the resizeToAvoidBottomPadding
      body:SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Form(
     // key: scaffoldkey,
          child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Form(
            key: formKey,
            child: Column(
              children: <Widget>[
                    new TextFormField(
      validator: (value){
               if(value.isEmpty){
                    return "please enter username";
                }else if(value.length>8){
                    return "username must have eight character";
                }
               },
          controller: uname,
                        autofocus: true,

          decoration: new InputDecoration(
            icon: const Icon(Icons.person_add),
            labelText: "Enter Username",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
         new TextFormField(
           obscureText: true, 
            validator: (value){
                if(value.isEmpty){

                    return "please enter password";
                } 
               },
          controller: pass,            autofocus: true,

          decoration: new InputDecoration(
            icon: const Icon(Icons.lock),
            labelText: "Enter password",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
         new TextFormField(
           obscureText: true, 
            validator: (value){
                if(value.isEmpty){
                    return "please confirm password";
                } 
               },
          controller: cpass,            autofocus: true,

          decoration: new InputDecoration(
            icon: const Icon(Icons.verified_user),
            labelText: "Re-Type Password",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
                new TextFormField(
           
          controller: addr,            autofocus: true,

          decoration: new InputDecoration(
            icon: const Icon(Icons.verified_user),
            labelText: "Enter Address ",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
                    new TextFormField(
                      
          controller: phno,             

          validator: validateMobile,
            maxLength: 10,
                                      autofocus: true,

          focusNode: _focusNode,
             keyboardType: TextInputType.phone,
           
          onSaved: (String val) {
      mobile = val;
          },
           decoration: new InputDecoration(
            icon: const Icon(Icons.verified_user),
            labelText: "Enter PhoneNumber ",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
   
        ),
        SizedBox(
          height: 10.0,
        ),
                new TextFormField(
            
          controller: aphno,            
          autofocus: true,
          maxLength: 10,
          keyboardType: TextInputType.phone,
          onSaved: (String val) {
              mobile = val;
            },
          decoration: new InputDecoration(
            filled: true,
            icon: const Icon(Icons.verified_user),
            labelText: "Enter Alternative PhoneNumber ",
            fillColor: Colors.white,
            border: new OutlineInputBorder(
              borderRadius: new BorderRadius.circular(25.0),
              borderSide: new BorderSide(),
            ),
          ),
        ),
        SizedBox(
          height: 10.0,
        ),
              ],
            ),
          ),
        
        
                            
                                         ButtonBar(
                            children: <Widget>[
                            
                              FlatButton(
                                child: Text('CANCEL'),
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                ),
                                onPressed: () {
                                uname.clear();
                                pass.clear();
                                cpass.clear();
                                
                                },
                              ),

                     /*   child: RaisedButton(
                 onPressed: (){
                    if (formKey.currentState.validate()) {
                       scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Form validation Succesfully"),
                      ));
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (contex)=> FirstPage()
                      ));
                    }else{
                        scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Form validation Failed"),
                      ));
                    }
                 },
                 child: Text("LOGIN", style:TextStyle(color:Colors.white),
                 ),
               ), */
                              RaisedButton(
                                child: Text('SignUp'),
                                 color: Colors.blueAccent,
                                shape: BeveledRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(7.0)),
                                ),

                                  // Navigator.pop(context);                                      
                             /*   onPressed: (){
                               //       onPressed: //_validateInputs,                            
                          usercreate();
                                   Navigator.pop(context);    
         },*/
          onPressed: (){
             usercreate();
         if (formKey.currentState.validate()) {
                       scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Account Created Sucessfully"),
                      ));
                      
                    }else{
                        scaffoldkey.currentState.showSnackBar(SnackBar(
                        content: Text("Failed to Created Sucessfully"),
                      ));
                    }
                 },
          
                               
                                
                                
                              ),  
                         
                                  // Text(msg,style: TextStyle(fontSize: 20.0,color: Colors.red),),
                            ],
                          ),
        
                      ],
                    ),
         ),
                  ),
      )
      
                        );
                      }
                    }
    

  String validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }

  String validateEmail(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Enter Valid Email';
    else
      return null;
  }

   /* if (property_name.text == "") {
                            setState(() {
                              _error = "Must fill Your Property Name";
                              _visible = true;
                            });
                          }
                            if (property_email.text == "") {
                            setState(() {
                              _error = "Must fill Your Property Email";
                              _visible = true;
                            });
                          }
                            if (img1 == null) {
                            setState(() {
                              _error = "Must Select Your Property Image";
                              _visible = true;
                            });
                          }
                            if (property_phone.text == "") {
                            setState(() {
                              _error = "Must fill Your Property Phone";
                              _visible = true;
                            });
                          }
                            if (property_staff.text == "") {
                            setState(() {
                              _error = "Must fill Your Staff Email Id";
                              _visible = true;
                            });
                          }
                            if (dropdownValue == null) {
                            setState(() {
                              _error = "Must select role of the user";
                              _visible = true;
                            });
                          }
                            if (address_line1.text == "") {
                            setState(() {
                              _error = "Must fill Your Property Address";
                              _visible = true;
                            });
                          }
                            if (city.text == "") {
                            setState(() {
                              _error = "Must fill  Your Property City";
                              _visible = true;
                            });
                          }
                            if (state.text == "") {
                            setState(() {
                              _error = "Must fill  Your Property State";
                              _visible = true;
                            });
                          }*/

                          
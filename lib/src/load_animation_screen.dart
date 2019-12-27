import 'dart:async';
import 'package:flutter/material.dart';
import './property_list.dart';
//import './main1.dart';
import 'package:percent_indicator/percent_indicator.dart';

class AnimationScreen extends StatefulWidget {
  String address,email;
  AnimationScreen({this.address,this.email});
  @override
  _AnimationScreenState createState() => new _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  startTime() async {
    var _duration = new Duration(seconds:2);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).push(new MaterialPageRoute(
    builder: (BuildContext context) => new Property_ListScreen(
       address:"${widget.address}",
       email:  "${widget.email}"
    )));
  }

  @override
  void initState() {
        this.startTime();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
   
         body: Center(
           child: Column(
             
                  mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
       // fit: StackFit.expand,
        children: <Widget>[
           SizedBox(
               height: 30.0,
             ),
            new LinearPercentIndicator(              
               padding: const EdgeInsets.symmetric(horizontal: 1.0),
                      maskFilter: MaskFilter.blur( BlurStyle.solid,1.0),
                     // MainAxisAlignment alignment = MainAxisAlignment.start,
               animateFromLastPercent: true,
                width: MediaQuery.of(context).size.width - 0,
                //animation: true,
                lineHeight: 25.0,
                //animationDuration: 30000,
                //addAutomaticKeepAlive: true,
                //clipLinearGradient: false,
                percent: 0.7,                
                //linearStrokeCap: LinearStrokeCap.values[2],
                progressColor: Color(0xffF43669,),  
                 backgroundColor : Color(0xff151232),  
               // progressColor: Colors.greenAccent,
              ), 
             SizedBox(
               height: 200.0,
             ),
          SizedBox(
    height: 100.0,
    width: 100.0,
           child:  CircularProgressIndicator(
               valueColor: AlwaysStoppedAnimation(Color(0xff6839ed)),
        strokeWidth: 10.0
             ),),

        ],)
      ),
    );
  }
}
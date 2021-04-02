import 'dart:async';

import 'package:flutter/material.dart';

class TimerAdapter extends StatefulWidget {

  TextEditingController controller;
  GlobalKey<FormState> formKey;
  TimerAdapter({this.controller,this.formKey});

  @override
  _TimerAdapterState createState() => _TimerAdapterState();
}

// Used the AutomaticKeepAliveClientMixin Mixin to maintain state when list is scrolled
class _TimerAdapterState extends State<TimerAdapter> with AutomaticKeepAliveClientMixin{

  Timer _timer;
  int seconds;
  DateTime afterDate;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec, (Timer timer) {
        if (seconds == 0) {
            timer.cancel();
            setState(() {});
        } else {
            seconds--;
            setState(() { });
        }
      },
    );
  }

  void _startTimerCalculation() {
    // Updating seconds timer should run and setting initial values to timer
    seconds = int.tryParse(widget.controller.text);
    afterDate = DateTime.now().add(Duration(seconds: seconds));
    setState(() {});

    // starting timer
    startTimer();

    // Removing value from textField after Starting timer.
    widget.controller.clear();
  }

  String get timerText{
    if(afterDate==null){
      return null;
    }
    Duration timerDuration = afterDate.difference(DateTime.now());
    return timerDuration.toString().split('.').first.padLeft(8, "0");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Row(
        children: [
          Expanded(
            flex:1,
            child: Form(
              key: widget.formKey,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: widget.controller,
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Cannot Be null';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  focusedBorder:UnderlineInputBorder(

                  ),
                  enabledBorder:UnderlineInputBorder(
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Seconds",
                  hintStyle: TextStyle(
                    color: Colors.black.withOpacity(0.7),
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                  ),
                  contentPadding: EdgeInsets.fromLTRB(20, 19, 18, 16),
                ),
                style: TextStyle(
                  color: Colors.black.withOpacity(0.7),
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ),
          ),

          Expanded(
            flex:1,
            child: Text(timerText ?? 'hh:mm:ss',
              textAlign: TextAlign.center,
              style: TextStyle(
              color: Colors.black.withOpacity(0.7),
              fontSize: 14,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
            ),),
          ),

          Expanded(
            flex:1,
            child:  Container(
              padding: EdgeInsets.all(10),
              height: 50,
              child: FlatButton(
                onPressed: (){
                  // if there is some seconds value then only start timer or else shoe validation method
                  if(widget.formKey.currentState.validate()){
                    _startTimerCalculation();
                  }
                },
                child: Text(
                  'Start',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                    fontStyle: FontStyle.normal,
                  ),
                  maxLines: 1,
                ),
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Set This getter value to true to save state
  @override
  bool get wantKeepAlive => true;

}

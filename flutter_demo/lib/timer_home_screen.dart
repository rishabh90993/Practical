import 'package:flutter/material.dart';
import 'package:TimerApp/timer_adapter.dart';

class TimerHomeScreen extends StatefulWidget {
  @override
  _TimerHomeScreenState createState() => _TimerHomeScreenState();
}

class _TimerHomeScreenState extends State<TimerHomeScreen> {


  List<TextEditingController> controllerList = [];
  List<GlobalKey<FormState>> formKeyList = [];

  @override
  void initState() {
    for(int i=0 ; i<20 ; i++) {
      controllerList.add(TextEditingController());
      formKeyList.add(GlobalKey<FormState>());
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        // Dismissing Keyboard on touching anywhere on screen
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child:Scaffold(
      appBar: AppBar(
        title: Text('Timer',style: TextStyle(fontSize: 18,),),
      ),
      body: Container(
          child: ListView.separated(itemBuilder: (ctx,index) {
            return TimerAdapter(controller: controllerList[index],formKey: formKeyList[index],);
          },
          padding: EdgeInsets.only(top: 20,bottom: 20),
          separatorBuilder: (ctx,index)=>SizedBox(height: 20,),
          itemCount: 20,
          ),
        ),
      ),
    );
  }
}

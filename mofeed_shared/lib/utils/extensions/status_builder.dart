import 'package:flutter/cupertino.dart';


extension StatusBuilder on Object {
  Widget builder<T>(
      Map<T, Widget Function()> widgetMap,
  {
    Widget?placeHolder,

  }
      ) {
    if (widgetMap.containsKey(this )) {
      return widgetMap[this]!();
    }
    if(placeHolder!=null){
      return placeHolder;
    }
    else {
      return Container();
    }

  }

  void  when <T>(
  Map<T, Function()> functionMap
  ) {
  if (functionMap.containsKey(this )) {
  functionMap[this]!();
  }
  }

  bool isSame(Object t)=>t==this;

  
}
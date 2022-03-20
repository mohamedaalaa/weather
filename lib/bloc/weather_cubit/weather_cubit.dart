

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:untitled/api_provider/api_provider.dart';
import 'package:untitled/bloc/weather_cubit/weather_state.dart';
import 'package:untitled/models/weather.dart';

import '../../models/location.dart';

class WeatherCubit extends Cubit<WeatherState>{
  WeatherCubit() : super(InitialState());

  WeatherModel? model;
  Future fetchWeather(int number,BuildContext context)async{

      emit(LoadingState());
      print("here");
      await ApiProvider().fetchWeather(number, context).then((value) {
        if(value!=null){
          model=value;
        }else{
          print("loaded with error");
          emit(LoadedWithError());
        }
      });
      emit(LoadedState());
  }




  var isSwitched=false;

  void toggle(){
    emit(SwitchState());
    isSwitched=!isSwitched;
    emit(SwitchDone());
  }
  
}
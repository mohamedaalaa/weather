

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:untitled/api_provider/api_provider.dart';
import 'package:untitled/bloc/location_cubit/location_states.dart';
import 'package:untitled/models/location.dart';

import '../../models/weather.dart';

class LocationCubit extends Cubit<LocationStates>{
  LocationCubit() : super(InitialState());


  List<LocationModel> cities=[];
  Future<void> fetchData(String value)async{
    emit(LoadingState());
    await ApiProvider().fetchData(value).then((value) {
      if(value.isNotEmpty){
        cities=value;
      }
      else{
        emit(LoadedError());
      }
    });
    emit(LoadedState());
  }


}
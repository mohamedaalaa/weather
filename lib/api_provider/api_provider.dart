


import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;
import 'package:untitled/models/location.dart';
import 'package:untitled/models/weather.dart';

class ApiProvider{

  Future<List<LocationModel>> fetchData(String value)async{
    List<LocationModel> cities=[];
     var url=Uri.parse("https://www.metaweather.com/api/location/search/?query=$value");
     try{
       Response response=await http.get(url);
       var data=json.decode(response.body);
       cities=List<LocationModel>.from(data.map((x)=>LocationModel.fromJson(x)));
       return cities;
     }catch(e){
       print(e);
     }
     return cities;
  }

  Future<WeatherModel?> fetchWeather(int number,BuildContext context)async{

    var url=Uri.parse("https://www.metaweather.com/api/location/$number");
    WeatherModel? model;
    try{
      Response response=await http.get(url);
      model=WeatherModel.fromJson(json.decode(response.body));
      return model;
    }catch(e){
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()),duration: const Duration(seconds: 2),));
    }
    return model;
  }
}


import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/weather_cubit/weather_cubit.dart';
import 'package:untitled/bloc/weather_cubit/weather_state.dart';

class Settings extends StatefulWidget {
  Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body:BlocConsumer<WeatherCubit,WeatherState>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, Object? state) {
         return  Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Temperature Units"),
                Switch(
                  onChanged: (bool value) {
                    context.read<WeatherCubit>().toggle();
                  },
                  value: context.read<WeatherCubit>().isSwitched,
                  activeColor: Colors.blue,
                  activeTrackColor: Colors.blueAccent,
                  inactiveThumbColor: Colors.redAccent,
                  inactiveTrackColor: Colors.redAccent,
                ),
              ],
            ),
          );
        },

      )
    );
  }
}

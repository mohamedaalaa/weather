import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/weather_cubit/weather_cubit.dart';
import 'package:untitled/bloc/weather_cubit/weather_state.dart';
import 'package:untitled/settings/settings.dart';
import 'package:untitled/widgets/weather_error.dart';
import 'package:untitled/widgets/weather_loading.dart';
import 'package:untitled/widgets/weather_populated.dart';

class WeatherView extends StatelessWidget {
  int number;
  WeatherView({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather"),
        actions: [
          IconButton(
              onPressed: () => Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => Settings())),
              icon: const Icon(Icons.settings))
        ],
      ),
      body: Center(
        child: BlocConsumer<WeatherCubit, WeatherState>(
          listener: (context, state) {
            if(state is InitialState)print("initial");
            if(state is LoadingState)print("loading");
            if(state is LoadedState)print("loaded");
            if(state is LoadedWithError)print("loaded with error");
          },
          builder: (context, state) {
            if (state is InitialState) {
              context.read<WeatherCubit>().fetchWeather(number, context);
              return const WeatherLoading();
            }
            if (state is LoadingState) {
              return const WeatherLoading();
            }
            if (state is LoadedState) {
              return WeatherPopulated(
                weather: context.read<WeatherCubit>().model,
                value: context.read<WeatherCubit>().isSwitched,
              );
            }
            if(state is SwitchDone){
              return WeatherPopulated(
                weather: context.read<WeatherCubit>().model,
                value: context.read<WeatherCubit>().isSwitched,
              );
            }
            return const WeatherError();
          },
        ),
      ),
    );
  }
}

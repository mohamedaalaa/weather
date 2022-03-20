


abstract class WeatherState{}

class InitialState extends WeatherState{}

class LoadingState extends WeatherState{}

class LoadedState extends WeatherState{}

class LoadedWithError extends WeatherState{}

class SwitchState extends WeatherState{}

class SwitchDone extends WeatherState{}

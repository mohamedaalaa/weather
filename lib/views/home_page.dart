import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled/bloc/location_cubit/location_cubit.dart';
import 'package:untitled/bloc/location_cubit/location_states.dart';
import 'package:untitled/bloc/weather_cubit/weather_cubit.dart';
import 'package:untitled/bloc/weather_cubit/weather_state.dart';
import 'package:untitled/views/weather_view.dart';
import 'package:untitled/widgets/wather_empty.dart';
import 'package:untitled/widgets/weather_error.dart';
import 'package:untitled/widgets/weather_loading.dart';
import 'package:untitled/widgets/weather_populated.dart';
/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<void> _showSearch() async {
    await showSearch(
      context: context,
      delegate: TheSearch(),
      query: "",
    );
  }
  


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocationCubit,LocationStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, Object? state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Weather'),
            actions: [
              IconButton(
                  onPressed: () {
                    _showSearch();
                  },
                  icon: const Icon(Icons.search))
            ],
          ),
        );
      },
    );
  }
}

class TheSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var cities=context.read<LocationCubit>().cities.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();

    return cities.isEmpty?
    const Center(
      child: Text("no cities found"),
    ):
        ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context,i)=>
                ListTile(
                  //onTap: ()=>Navigator.of(context).,
                  title: Text(cities[i].title),
                  subtitle: Text(cities[i].locationType),
                ));
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var cities = context.read<LocationCubit>().cities.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
    return FutureBuilder(
        future: context.read<LocationCubit>().fetchData(query.toLowerCase()),
        builder: (context, snapshot) =>
         snapshot.connectionState== ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : (cities.isEmpty||query.isEmpty)
                    ? const Center(
                        child: Text("no cities found"),
                      )
                    : ListView.builder(
                        itemCount: cities.length,
                        itemBuilder: (context, i) => ListTile(
                          onTap: () {
                            query=cities[i].title;
                            showResults(context);
                          },
                              title: Text(cities[i].title),
                            )
         )
    );
  }
}
*/

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {

    Future<void> _showSearch() async {
      await showSearch(
        context: context,
        delegate: TheSearch(),
        query: "",
      );
    }


        return BlocConsumer<LocationCubit,LocationStates>(
          listener: (BuildContext context, state) {  },
          builder: (BuildContext context, Object? state) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Weather'),
                actions: [
                  IconButton(
                      onPressed: () {
                        _showSearch();
                      },
                      icon: const Icon(Icons.search))
                ],
              ),
              body: const Center(child: WeatherEmpty(),),
            );
          },
        );

  }
}

class TheSearch extends SearchDelegate<String> {
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ),
        onPressed: () {
          close(context, "");
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    var cities=context.read<LocationCubit>().cities.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
     return cities.isEmpty?const Center(child: Text("no cities found"),):
         ListView.builder(
             itemCount: cities.length,
             itemBuilder: (context,i)=>ListTile(
               title: Text(cities[i].title),
               onTap: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>WeatherView(number: cities[i].woeid))),
             ));

  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var c=context.read<LocationCubit>();
    var cities = c.cities.where((element) => element.title.toLowerCase().contains(query.toLowerCase())).toList();
    return FutureBuilder(
        future: c.fetchData(query.toLowerCase()),
        builder: (context, snapshot) =>
        snapshot.connectionState== ConnectionState.waiting
            ? const Center(
          child: CircularProgressIndicator(),
        )
            : (cities.isEmpty||query.isEmpty)
            ? const Center(
          child: Text("no cities found"),
        )
            : ListView.builder(
            itemCount: cities.length,
            itemBuilder: (context, i) => ListTile(
              title: Text(c.cities[i].title),
              onTap: (){
                query=cities[i].title;
                showResults(context);
              }
        )
        )
    );
  }}

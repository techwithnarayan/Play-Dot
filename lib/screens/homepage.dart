

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:playdot/blocs/bloc/apidata_bloc.dart';
import 'package:playdot/blocs/bloc/internet_bloc.dart';
import 'package:playdot/helpers/models/data_model.dart';
import 'package:playdot/screens/grid_title_screen.dart';
import 'package:playdot/screens/title_info_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //bool isConnected = true;
  @override
  void initState() {
    Future.delayed(Duration(seconds: 3, ),(){SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);});
    BlocProvider.of<ApiDataBloc>(context).add(ApiDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetLostState) {
         // isConnected? null:
          showDialog(
              barrierDismissible: false,
              context: context,
              builder: (context) {
                return Dialog(
                  backgroundColor: Colors.transparent,
                  child: Container(
                      alignment: Alignment.center,
                      height: 250,
                      width: 250,
                      decoration: BoxDecoration(
                          color: Colors.grey.shade700,
                          borderRadius: BorderRadius.circular(20)),
                      child: Column(
                        children: [
                          LottieBuilder.asset(
                            'assets/no_internet.json',
                            height: 200,
                          ),
                          Text(
                            "No Internet",
                            style: TextStyle(
                                fontSize: 30, fontWeight: FontWeight.w600),
                          )
                        ],
                      )),
                );
              });
        }
        if (state is InternetGainState) {
         Navigator.of(context).maybePop(); // Close the dialog
    // Defer the execution of these actions
    Future.delayed(Duration(milliseconds: 100), () {
      setState(() {
        //isConnected = true;
      });
      BlocProvider.of<ApiDataBloc>(context).add(ApiDataFetchEvent());
    });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.grey.shade900,
              Colors.grey,
              // Colors.white
            ])),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: const Text("HomePage"),
            ),
          ),
          body: BlocBuilder<ApiDataBloc, ApiDataState>(
            builder: (context, state) {
              if (state is ApidataLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is ApidataErrorState) {
                return Center(
                    child: Text(
                  state.error,
                  style: TextStyle(),
                ));
              } else if (state is ApidataLoadedState) {
                final List<Movie> allPosts = state.movies;
                // Group the posts by category
                final Map<String, List<Movie>> postsByCategory = {};
                for (final post in allPosts) {
                  if (postsByCategory.containsKey(post.type)) {
                    postsByCategory[post.type]!.add(post);
                  } else {
                    postsByCategory[post.type] = [post];
                  }
                }

                // if (snapshot.connectionState == ConnectionState.waiting) {
                //   return const CircularProgressIndicator();
                // } else if (snapshot.hasError) {
                //   return Text('Error: ${snapshot.error}');
                // } else if (snapshot.hasData) {
                //   final List<Movie> allPosts = snapshot.data!;
                //   // Group the posts by category
                //   final Map<String, List<Movie>> postsByCategory = {};
                //   for (final post in allPosts) {
                //     if (postsByCategory.containsKey(post.type)) {
                //       postsByCategory[post.type]!.add(post);
                //     } else {
                //       postsByCategory[post.type] = [post];
                //     }
                //   }
                return SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    children: [
                      const SizedBox(height: 100),
                      const SizedBox(height: 30),
                      for (final category in postsByCategory.keys)
                        _buildSection(category, category, 200,
                            postsByCategory[category]!),
                      const SizedBox(
                        height: 50,
                      ),
                    ],
                  ),
                );
              } else {
                return const Text('No data available.');
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, String type, double height, List<Movie> posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 130,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GridTitle(category: type, posters: posts),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TitleInfo(
                                data: posts[index],
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(posts[index].poster),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    // height: 200,
                    width: 140,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/*-------------------------
---------------------------
This is old screen
---------------------------
---------------------------


import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:playdot/blocs/bloc/internet_bloc.dart';
import 'package:playdot/helpers/api/api_provider.dart';
import 'package:playdot/helpers/models/data_model.dart';
import 'package:playdot/screens/grid_title_screen.dart';
import 'package:playdot/screens/title_info_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // final PostDetails _postDetails = PostDetails();
  // late Future<List<Movie>> _moviesAndSeries = Future.value([]); // Initialize with an empty list

  // @override
  // void initState() {
  //   super.initState();
  //   SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  //   _fetchMoviesAndSeries();
  // }

  // Future<void> _fetchMoviesAndSeries() async {
  //   try {
  //     await InternetAddress.lookup('techwithnarayan.github.io');
  //     setState(() {
  //       _moviesAndSeries = _postDetails.fetchMoviesAndSeries();
  //     });
  //   } on SocketException catch (error) {
  //     print('Host lookup error: $error');

  //   }
  // }

  final PostDetails _postDetails = PostDetails();
  late Future<List<Movie>> _moviesAndSeries;

  @override
  void initState() {
    super.initState();
    //BlocProvider.of<InternetBloc>(context).add(InternetEvent());

    Future.delayed(const Duration(milliseconds: 500), () async{
       try {
  await InternetAddress.lookup('techwithnarayan.github.io');
  // Proceed with using addresses
} on SocketException catch (error) {
  print('Host lookup error: $error');
  // Handle no internet connection here
}
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    });

      _moviesAndSeries = _postDetails.fetchMoviesAndSeries();

  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InternetBloc, InternetState>(
      listener: (context, state) {
        if (state is InternetLostState) {
          showDialog(
              context: context,
              builder: (_) {
                return AlertDialog(
                  title: Text("No Internet"),
                );
              });
        }
        if (state is InternetGainState) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Connected")));
        }
      },
      child: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              Colors.grey.shade900,
              Colors.grey,
              // Colors.white
            ])),
        child: Scaffold(
          extendBody: true,
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.grey.shade800,
                  borderRadius: BorderRadius.circular(10)),
              height: 50,
              child: const Text("HomePage"),
            ),
          ),
          backgroundColor: Colors.transparent,
          body: Center(
            child: FutureBuilder<List<Movie>>(
              future: _moviesAndSeries,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  print(snapshot.error);
                  if (snapshot.error is SocketException) {
                    return Center(
                      child: Text("No internet connection"),
                    );
                  } else {
                    // Handle other errors
                    return Text('Error: ${snapshot.error}');
                  }
                } else if (snapshot.hasData) {
                  final List<Movie> allPosts = snapshot.data!;
                  // Group the posts by category
                  final Map<String, List<Movie>> postsByCategory = {};
                  for (final post in allPosts) {
                    if (postsByCategory.containsKey(post.type)) {
                      postsByCategory[post.type]!.add(post);
                    } else {
                      postsByCategory[post.type] = [post];
                    }
                  }

                  // if (snapshot.connectionState == ConnectionState.waiting) {
                  //   return const CircularProgressIndicator();
                  // } else if (snapshot.hasError) {
                  //   return Text('Error: ${snapshot.error}');
                  // } else if (snapshot.hasData) {
                  //   final List<Movie> allPosts = snapshot.data!;
                  //   // Group the posts by category
                  //   final Map<String, List<Movie>> postsByCategory = {};
                  //   for (final post in allPosts) {
                  //     if (postsByCategory.containsKey(post.type)) {
                  //       postsByCategory[post.type]!.add(post);
                  //     } else {
                  //       postsByCategory[post.type] = [post];
                  //     }
                  //   }
                  return SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        const SizedBox(height: 100),
                        const SizedBox(height: 30),
                        for (final category in postsByCategory.keys)
                          _buildSection(category, category, 200,
                              postsByCategory[category]!),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  );
                } else {
                  return const Text('No data available.');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
      String title, String type, double height, List<Movie> posts) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //SizedBox(height: 130,),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.w600),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          GridTitle(category: type, posters: posts),
                    ),
                  );
                },
                child: Text(
                  "See All",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey.shade300,
                      fontWeight: FontWeight.w400),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: height,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posts.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(left: 20),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => TitleInfo(
                                data: posts[index],
                              )),
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(posts[index].poster),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey,
                    ),
                    // height: 200,
                    width: 140,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
*/
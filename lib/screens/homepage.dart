import 'package:flutter/material.dart';
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
  final PostDetails _postDetails = PostDetails();
  late Future<List<Movie>> _moviesAndSeries;

  @override
  void initState() {
    super.initState();
    _moviesAndSeries = _postDetails.fetchMoviesAndSeries();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
                return const CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
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

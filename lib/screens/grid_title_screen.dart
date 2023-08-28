
import 'package:flutter/material.dart';
import 'package:playdot/helpers/models/data_model.dart';
import 'package:playdot/screens/title_info_screen.dart';

class GridTitle extends StatelessWidget {
  final String category;
  final List<Movie> posters;
  const GridTitle({super.key, required this.category, required this.posters});

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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            
            category,
          ),
        ),
        body: GridView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: posters.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.7, crossAxisCount: 3),
            itemBuilder: (context, index) {
              final poster = posters[index];
              return Padding(
                padding: const EdgeInsets.only(left: 10, bottom: 20, right: 10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TitleInfo(data: posters[index],
                                  
                                )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                        image: NetworkImage(poster.poster),
                         fit: BoxFit.cover),
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.shade700),
                    width: 140,
                    height: 250,
                  ),
                ),
              );
            }),
      ),
    );
  }
}




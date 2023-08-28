import 'package:flutter/material.dart';
import 'package:playdot/helpers/models/data_model.dart';
import 'package:playdot/screens/download_screen.dart';
import 'package:playdot/screens/player_screen.dart';
import 'package:playdot/screens/player_screen_movie.dart';

class TitleInfo extends StatefulWidget {
  final Movie data;
  const TitleInfo({super.key, required this.data});

  @override
  State<TitleInfo> createState() => _TitleInfoState();
}

class _TitleInfoState extends State<TitleInfo> {
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
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                      image: DecorationImage(
                          image: NetworkImage(widget.data.poster),
                          fit: BoxFit.cover),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: const Offset(
                              6,
                              6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10
                            //blurStyle: BlurStyle.outer
                            ),
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: const Offset(
                              -6,
                              -6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10),
                      ]),
                  height: MediaQuery.of(context).size.height * 0.5,
                  width: MediaQuery.of(context).size.width * 0.7,
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      if (widget.data.type == 'Series') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerScreen(
                                      seriesdata: widget.data,
                                    )));
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PlayerScreenMovie(
                                      titleInfo: widget.data,
                                    )));
                      }

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                    seriesdata: widget.data,
                                  )));
                    },
                    child: Container(
                        decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(
                                    6,
                                    6,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 10
                                  //blurStyle: BlurStyle.outer
                                  ),
                              BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(
                                    -6,
                                    -6,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 10),
                            ]),
                        height: 60,
                        width: 60,
                        //width: MediaQuery.of(context).size.width * 0.4,
                        child: const Icon(
                          Icons.play_arrow_rounded,
                          size: 40,
                        )),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=> DownloadScreen()));
                    },
                    child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.yellow.shade800,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(
                                    6,
                                    6,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 10
                                  //blurStyle: BlurStyle.outer
                                  ),
                              BoxShadow(
                                  color: Colors.grey.shade800,
                                  offset: const Offset(
                                    -6,
                                    -6,
                                  ),
                                  blurRadius: 20,
                                  spreadRadius: 10),
                            ]),
                        height: 60,
                        width: MediaQuery.of(context).size.width * 0.4,
                        child: const Text(
                          "DOWNLOAD ",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 22,
                              color: Colors.white),
                        )),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    widget.data.title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 50,
                        color: Colors.white,
                        fontWeight: FontWeight.w700),
                  )),
              const SizedBox(
                height: 40,
              ),
              Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade400,
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: const Offset(
                              6,
                              6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10
                            //blurStyle: BlurStyle.outer
                            ),
                        BoxShadow(
                            color: Colors.grey.shade800,
                            offset: const Offset(
                              -6,
                              -6,
                            ),
                            blurRadius: 20,
                            spreadRadius: 10),
                      ]),
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "PLOT",
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Divider(
                        thickness: 2,
                      ),
                      Text(
                        widget.data.plot,
                        style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.italic),
                      )
                    ],
                  )),
              const SizedBox(
                height: 100,
              )
            ],
          ),
        ),
      ),
    );
  }
}

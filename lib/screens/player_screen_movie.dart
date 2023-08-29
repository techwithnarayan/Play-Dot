import 'dart:async';

import 'package:chewie/chewie.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:flutter/material.dart';
import 'package:playdot/helpers/models/data_model.dart';

import 'package:video_player/video_player.dart';

class PlayerScreenMovie extends StatefulWidget {
  final Movie titleInfo;
  const PlayerScreenMovie({super.key, required this.titleInfo});

  @override
  State<PlayerScreenMovie> createState() => _PlayerScreenMovieState();
}

class _PlayerScreenMovieState extends State<PlayerScreenMovie> {
  // late VideoPlayerController _videoPlayerController;
  // late ChewieController _chewieController;

  // @override
  // void initState() {
  //   super.initState();
  //   print(widget.titleInfo.playLink);
  //   _videoPlayerController =

  //       // VideoPlayerController.networkUrl(Uri.parse(widget.titleInfo.playLink!));
  //       VideoPlayerController.networkUrl(Uri.parse(widget.titleInfo.playLink!));

  //   _videoPlayerController.initialize().then((_) => setState(() =>
  //       _chewieController = ChewieController(
  //           showOptions: false,
  //           autoInitialize: true,
  //           errorBuilder: (context, errorMessage) {
  //             return Center(child: Text("Error $errorMessage"));
  //           },
  //           materialProgressColors:
  //               ChewieProgressColors(bufferedColor: Colors.grey),
  //           videoPlayerController: _videoPlayerController,
  //           aspectRatio: _videoPlayerController.value.aspectRatio)));
  // }

  // @override
  // void dispose() {
  //   _chewieController.dispose();
  //   _videoPlayerController.dispose();
  //   super.dispose();
  // }

  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool isConnected = true;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  @override
  void initState() {
    super.initState();
    _initializeVideoPlayer();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_handleConnectivityChange);
  }

  void _initializeVideoPlayer() {
    _videoPlayerController =

        // VideoPlayerController.networkUrl(Uri.parse(widget.titleInfo.playLink!));
        VideoPlayerController.networkUrl(Uri.parse(widget.titleInfo.playLink!));
    _videoPlayerController.initialize().then((_) {
      setState(() {
        _chewieController = ChewieController(
            showOptions: false,
            autoInitialize: true,
            errorBuilder: (context, errorMessage) {
              return Center(child: Text("Error $errorMessage"));
            },
            materialProgressColors:
                ChewieProgressColors(bufferedColor: Colors.grey),
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio);
      });
    });
  }

  void _handleConnectivityChange(ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      setState(() {
        isConnected = false;
      });
    } else {
      setState(() {
        isConnected = true;
        _initializeVideoPlayer();
      });
    }
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _videoPlayerController.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _videoPlayerController.value.aspectRatio,
                        child: Chewie(controller: _chewieController),
                      )
                    : SizedBox(
                        height: MediaQuery.of(context).size.height * 0.27,
                        child:
                            const Center(child: CircularProgressIndicator())),
                const SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Text(
                          widget.titleInfo.title,
                          textAlign: TextAlign.justify,
                          style: const TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(widget.titleInfo.year),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Plot",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.titleInfo.plot,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Cast",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.titleInfo.actors,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Director",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.titleInfo.director,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    "Writer",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    widget.titleInfo.writer,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w200),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

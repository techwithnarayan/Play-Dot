import 'package:chewie/chewie.dart';

import 'package:flutter/material.dart';

import 'package:playdot/helpers/models/data_model.dart';
import 'package:video_player/video_player.dart';

class PlayerScreen extends StatefulWidget {
  final Movie seriesdata;
  //final Season season;
  const PlayerScreen({
    super.key,
    required this.seriesdata,
  });

  @override
  State<PlayerScreen> createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isDownloadComplete = false;
  String videoUrl =
      'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4';

  String filename = "demo.mkv"; // Specify the desired filename
  String url =
      "https://demo.seafile.com/f/cab44c593b5549c9acb0/?dl=1"; // Replace with your download URL
  late VideoPlayerController _videoPlayerController;
  late ChewieController _chewieController;
  bool isPermissionGranted = false;

  @override
  void initState() {
    super.initState();

    _videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(videoUrl));

    _videoPlayerController.initialize().then((_) => setState(() =>
        _chewieController = ChewieController(
            showOptions: false,
            materialProgressColors:
                ChewieProgressColors(bufferedColor: Colors.grey),
            videoPlayerController: _videoPlayerController,
            aspectRatio: _videoPlayerController.value.aspectRatio)));
  }

  @override
  void dispose() {
    _chewieController.dispose();
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        physics:const BouncingScrollPhysics(),
        child: Column(
          children: [
            _videoPlayerController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _videoPlayerController.value.aspectRatio,
                    child: Chewie(controller: _chewieController),
                  )
                : SizedBox(
                    height: MediaQuery.of(context).size.height * 0.27,
                    child: const Center(child: CircularProgressIndicator())),
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
                      widget.seriesdata.title,
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
              height: 20,
            ),
            // SizedBox(
            //   height: 500,
            //   child: ListView.builder(
            //       shrinkWrap: true,
            //       physics: const BouncingScrollPhysics(),
            //       itemCount: widget.seriesdata.seasons?.length??null,
            //       itemBuilder: (context, index) {

            //         print(widget.seriesdata.seasons?.length.toString());
            //         return Padding(
            //           padding: const EdgeInsets.only(
            //               bottom: 20, left: 10, right: 10),
            //           child: Container(
            //               alignment: Alignment.center,
            //               height: 150,
            //               decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(10),
            //                 color: Colors.grey.shade800,
            //               ),
            //               child: ListTile(
            //                 title: Text(),
            //               )),
            //         );
            //       }),
            // )
          ],
        ),
      ),
    );
  }
}

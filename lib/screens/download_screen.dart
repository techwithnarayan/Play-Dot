import 'package:flutter/material.dart';

class DownloadScreen extends StatefulWidget {
  const DownloadScreen({super.key});

  @override
  State<DownloadScreen> createState() => _DownloadScreenState();
}

class _DownloadScreenState extends State<DownloadScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.grey.shade900,
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 200.0,
              child: Stack(
                children: [
                  Center(
                    child: SizedBox(
                      width: 180,
                      height: 180,
                      child:  CircularProgressIndicator(
                        strokeWidth: 20,
                        //value: 1.0,
                        strokeCap: StrokeCap.round,
                      ),
                    ),
                  ),
                  Center(
                      child: Text(
                    "50%",
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.w600),
                  )),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: LinearProgressIndicator(
                minHeight: 20,
                borderRadius: BorderRadius.circular(20),
              ),
            )
          ],
        ),
      ),
    );
  }
}

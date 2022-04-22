import 'package:flutter/material.dart';
import 'package:flutter_netflix_ui_clone/models/models.dart';
import 'package:flutter_netflix_ui_clone/widgets/widgets.dart';
import 'package:video_player/video_player.dart';

class ContentHeader extends StatelessWidget {
  final Content featuredContent;

  const ContentHeader({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: _ContentHeaderMobile(featuredContent: featuredContent),
      desktop: _ContentHeaderDesktop(featuredContent: featuredContent),
    );
  }
}

class _ContentHeaderMobile extends StatelessWidget {
  final Content featuredContent;

  const _ContentHeaderMobile({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 500.0,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(featuredContent.imageUrl),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          height: 500.0,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black, Colors.transparent],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            ),
          ),
        ),
        Positioned(
          bottom: 110.0,
          child: SizedBox(
            width: 250.0,
            child: Image.asset(featuredContent.titleImageUrl!),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 40.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              VerticalIconButton(
                icon: Icons.add,
                title: "List",
                onTap: () => print("Added"),
              ),
              //  _PlayButton(),
              VerticalIconButton(
                icon: Icons.info_outline,
                title: "Info",
                onTap: () => print("Info"),
              ),
            ],
          ),
        )
      ],
    );
  }
}

class _ContentHeaderDesktop extends StatefulWidget {
  final Content featuredContent;

  const _ContentHeaderDesktop({Key? key, required this.featuredContent})
      : super(key: key);

  @override
  State<_ContentHeaderDesktop> createState() => _ContentHeaderDesktopState();
}

class _ContentHeaderDesktopState extends State<_ContentHeaderDesktop> {
  late VideoPlayerController videoPlayerController;
  bool _isMuted = true;

  @override
  void initState() {
    videoPlayerController =
        VideoPlayerController.network(widget.featuredContent.videoUrl!)
          ..initialize().then((_) => setState(() {}))
          ..setVolume(0)
          ..play();
    super.initState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => videoPlayerController.value.isPlaying
          ? videoPlayerController.pause()
          : videoPlayerController.play(),
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          AspectRatio(
            aspectRatio: videoPlayerController.value.isInitialized
                ? videoPlayerController.value.aspectRatio
                : 2.344,
            child: videoPlayerController.value.isInitialized
                ? VideoPlayer(videoPlayerController)
                : Image.asset(
                    widget.featuredContent.imageUrl,
                    fit: BoxFit.cover,
                  ),
          ),
          Positioned(
            bottom: -1.0,
            left: 0,
            right: 0,
            child: AspectRatio(
              aspectRatio: videoPlayerController.value.isInitialized
                  ? videoPlayerController.value.aspectRatio
                  : 2.344,
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 60.0,
            right: 60.0,
            bottom: 150.0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 250.0,
                  child: Image.asset(
                    widget.featuredContent.titleImageUrl!,
                  ),
                ),
                const SizedBox(height: 15.0),
                Text(
                  widget.featuredContent.description!,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                      shadows: [
                        Shadow(
                            color: Colors.black,
                            offset: Offset(2.0, 4.0),
                            blurRadius: 6.0)
                      ]),
                ),
                const SizedBox(height: 20.0),
                Row(
                  children: [
                    _PlayButton(videoPlayerController: videoPlayerController),
                    const SizedBox(width: 16.0),
                    // ignore: deprecated_member_use
                    FlatButton.icon(
                      padding: const EdgeInsets.fromLTRB(
                        25.0,
                        10.0,
                        30.0,
                        10.0,
                      ),
                      color: Colors.white,
                      onPressed: () => print('More info'),
                      icon: const Icon(
                        Icons.info_outline,
                        size: 30.0,
                      ),
                      label: const Text(
                        "More Info",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(width: 20.0),
                    if (videoPlayerController.value.isInitialized)
                      IconButton(
                        icon:
                            Icon(_isMuted ? Icons.volume_off : Icons.volume_up),
                        onPressed: () => setState(
                          () {
                            _isMuted
                                ? videoPlayerController.setVolume(100)
                                : videoPlayerController.setVolume(0);
                            _isMuted = videoPlayerController.value.volume == 0;
                          },
                        ),
                        color: Colors.white,
                        iconSize: 30.0,
                      )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PlayButton extends StatefulWidget {
  final VideoPlayerController? videoPlayerController;
  const _PlayButton({Key? key, this.videoPlayerController}) : super(key: key);

  @override
  State<_PlayButton> createState() => _PlayButtonState();
}

class _PlayButtonState extends State<_PlayButton> {
  @override
  Widget build(BuildContext context) {
    // ignore: deprecated_member_use
    return FlatButton.icon(
      padding: !Responsive.isDesktop(context)
          ? const EdgeInsets.fromLTRB(
              15.0,
              5.0,
              20.0,
              5.0,
            )
          : const EdgeInsets.fromLTRB(
              25.0,
              10.0,
              30.0,
              10.0,
            ),
      onPressed: () {
        widget.videoPlayerController!.value.isPlaying
            ? widget.videoPlayerController!.pause()
            : widget.videoPlayerController!.play();

        setState(() {
          !widget.videoPlayerController!.value.isPlaying
              ? Icons.play_arrow
              : Icons.pause;
        });
      },
      color: Colors.white,
      icon: Icon(
        !widget.videoPlayerController!.value.isPlaying
            ? Icons.play_arrow
            : Icons.pause,
        size: 30.0,
      ),
      label: const Text(
        "Play",
        style: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

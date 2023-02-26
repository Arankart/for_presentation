import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import '../../../domain/data.dart';

class StoryPage extends StatefulWidget {
  const StoryPage({super.key});

  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;
  final Duration duration = const Duration(milliseconds: 300);

  int _currentIndex = 0;

  @override
  void initState() {
    _pageController = PageController();
    _animationController = AnimationController(vsync: this);

    _loadStory(story: stories[_currentIndex], animateToPage: false);

    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animationController.stop();
        _animationController.reset();
        setState(() {
          if (_currentIndex + 1 < stories.length) {
            _currentIndex += 1;
            _loadStory(story: stories[_currentIndex]);
          } else {
            _currentIndex = 0;
            _loadStory(story: stories[_currentIndex]);
          }
        });
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _loadStory({String? story, bool animateToPage = true}) {
    _animationController.stop();
    _animationController.reset();
    _animationController.duration = Duration(seconds: 5);
    _animationController.forward();

    if (animateToPage) {
      _pageController.animateToPage(_currentIndex,
          duration: duration, curve: Curves.easeInOut);
    }
  }

  void _onTapDown(TapDownDetails details) {
    final double screnWidth = MediaQuery.of(context).size.width;
    final double screnHeight = MediaQuery.of(context).size.height;

    final double dx = details.globalPosition.dx;
    final double dy = details.globalPosition.dy;

    if (dx < screnWidth / 3) {
      if (_currentIndex - 1 >= 0) _currentIndex -= 1;
    } else if (dx > 2 * screnWidth / 3) {
      if (_currentIndex + 1 < stories.length)
        _currentIndex += 1;
      else
        _currentIndex = 0;
    } else {
      if (dy > screnHeight - screnHeight / 6) {
        Navigator.pop(context);
      }
    }
    setState(() {
      _currentIndex;
      _loadStory(story: stories[_currentIndex]);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: NeverScrollableScrollPhysics(),
              itemCount: stories.length,
              itemBuilder: (context, index) {
                return CachedNetworkImage(
                  imageUrl: stories[index],
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              top: 40,
              left: 10,
              right: 10,
              child: Row(
                children: stories
                    .asMap()
                    .map(
                      (key, value) => MapEntry(
                        key,
                        AnimatedBar(
                          animController: _animationController,
                          position: key,
                          currentIndex: _currentIndex,
                        ),
                      ),
                    )
                    .values
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  AnimatedBar(
      {super.key,
      required this.animController,
      required this.position,
      required this.currentIndex});

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
          color: color,
          border: Border.all(
            color: Colors.black26,
            width: 0.8,
          ),
          borderRadius: BorderRadius.circular(3)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Flexible(
        child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.5),
      child: LayoutBuilder(
        builder: (context, constrains) {
          return Stack(
            children: [
              _buildContainer(
                double.infinity,
                position < currentIndex
                    ? Colors.white
                    : Colors.white.withOpacity(0.5),
              ),
              position == currentIndex
                  ? AnimatedBuilder(
                      animation: animController,
                      builder: (context, child) {
                        return _buildContainer(
                          constrains.maxWidth * animController.value,
                          Colors.white,
                        );
                      },
                    )
                  : SizedBox.shrink(),
            ],
          );
        },
      ),
    ));
  }
}


// position == currentIndex
//                     ? 
// AnimatedBuilder(
//                         animation: animController,
//                         builder: (context, child) {
//                           return _buildContainer(
//                             Colors.white,
//                           );
//                         },
//                       )
//                     : SizedBox.shrink(),
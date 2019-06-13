import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import '../../models/models.dart';
import '../../screens/screens.dart';

class ViewByCarousel extends StatefulWidget {
  final Collection collection;

  ViewByCarousel(this.collection);

  @override
  _ViewByCarouselState createState() => _ViewByCarouselState();
}

class _ViewByCarouselState extends State<ViewByCarousel> {
  PageController _pageController = new PageController();
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();

    _pageController.addListener(() {
      setState(() {
        _currentPage = _pageController.page.floor();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CollectionItem> collectionItems = widget.collection.items ?? [];

    return Stack(
      children: <Widget>[
        Container(
          height: 210,
          child: PageView.builder(
            controller: _pageController,
            itemCount: collectionItems.length,
            itemBuilder: (context, index) {
              CollectionItem collectionItem = collectionItems[index];
              return Container(
                height: double.infinity,
                child: FadeInImage(
                  placeholder: AssetImage("assets/images/placeholder.png"),
                  image: NetworkImage(
                    collectionItem.imageUrl,
                  ),
                  fit: BoxFit.cover,
                ),
              );
            },
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 12,
          child: Container(
            alignment: Alignment.bottomCenter,
            child: DotsIndicator(
              dotsCount: (widget.collection.items ?? []).length,
              position: _currentPage,
              decorator: DotsDecorator(
                color: Colors.white.withOpacity(0.2),
                activeColor: Colors.white,
                size: const Size.square(7.0),
                activeSize: const Size.square(7.0),
                activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

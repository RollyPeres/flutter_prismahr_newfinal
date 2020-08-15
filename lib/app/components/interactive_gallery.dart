import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_prismahr/app/data/models/image_model.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class InteractiveGallery extends StatefulWidget {
  final bool autoPlay;
  final bool enableInfiniteScroll;
  final double height;
  final double viewportFraction;
  final List<ImageModel> images;

  const InteractiveGallery({
    Key key,
    this.autoPlay = false,
    this.enableInfiniteScroll = false,
    this.height,
    this.viewportFraction = 1.0,
    @required this.images,
  }) : super(key: key);

  @override
  _InteractiveGalleryState createState() => _InteractiveGalleryState();
}

class _InteractiveGalleryState extends State<InteractiveGallery> {
  final CarouselController _carouselController = CarouselController();
  int currentCarouselPageIndex;

  @override
  void initState() {
    currentCarouselPageIndex = 0;
    super.initState();
  }

  void _updateCarouselIndex(
    int pageIndex,
    CarouselPageChangedReason reason,
  ) {
    setState(() {
      currentCarouselPageIndex = pageIndex;
    });
  }

  void _open() async {
    final int lastViewedIndex = await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => GalleryPhotoViewWrapper(
          images: widget.images,
          initialIndex: currentCarouselPageIndex,
        ),
      ),
    );
    _carouselController.jumpToPage(lastViewedIndex);
  }

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      carouselController: _carouselController,
      options: CarouselOptions(
        enableInfiniteScroll: widget.enableInfiniteScroll,
        autoPlay: widget.autoPlay,
        viewportFraction: widget.viewportFraction,
        height: widget.height ?? MediaQuery.of(context).size.height * 0.3,
        onPageChanged: _updateCarouselIndex,
      ),
      items: widget.images.map((image) {
        return Hero(
          tag: image.url,
          child: CachedNetworkImage(
            imageUrl: image.url,
            imageBuilder: _cachedNetworkImageBuilder,
          ),
        );
      }).toList(),
    );
  }

  Widget _cachedNetworkImageBuilder(
    BuildContext context,
    ImageProvider<dynamic> provider,
  ) {
    return Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: provider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        Positioned.fill(
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              highlightColor: Colors.black26,
              splashColor: Colors.black12,
              onTap: _open,
            ),
          ),
        ),
      ],
    );
  }
}

class GalleryPhotoViewWrapper extends StatefulWidget {
  final int initialIndex;
  final List<ImageModel> images;

  GalleryPhotoViewWrapper({
    Key key,
    @required this.initialIndex,
    @required this.images,
  }) : super(key: key);

  @override
  _GalleryPhotoViewWrapperState createState() =>
      _GalleryPhotoViewWrapperState();
}

class _GalleryPhotoViewWrapperState extends State<GalleryPhotoViewWrapper> {
  int currentIndex;

  @override
  void initState() {
    currentIndex = widget.initialIndex;
    super.initState();
  }

  void _updateInitialIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.black54,
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Platform.isIOS ? Icons.arrow_back_ios : Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pop(currentIndex);
          },
        ),
      ),
      body: Center(
        child: PhotoViewGallery.builder(
          itemCount: widget.images.length,
          builder: _galleryImageBuilder,
          onPageChanged: _updateInitialIndex,
          pageController: PageController(initialPage: widget.initialIndex),
        ),
      ),
    );
  }

  PhotoViewGalleryPageOptions _galleryImageBuilder(
    BuildContext context,
    int index,
  ) {
    final ImageModel image = widget.images[index];
    return PhotoViewGalleryPageOptions(
      imageProvider: CachedNetworkImageProvider(image.url),
      initialScale: PhotoViewComputedScale.contained,
      minScale: PhotoViewComputedScale.contained * (0.5 + index / 10),
      maxScale: PhotoViewComputedScale.covered * 1.1,
      heroAttributes: PhotoViewHeroAttributes(tag: image.url),
    );
  }
}

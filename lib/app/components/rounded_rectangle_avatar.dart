import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundedRectangleAvatar extends StatelessWidget {
  final String url;
  final double height;
  final double width;

  const RoundedRectangleAvatar({
    Key key,
    this.url,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AssetImage defaultImg = AssetImage("assets/images/avatardefault.png");
    return CachedNetworkImage(
      imageUrl: this.url ?? 'https://api.adorable.io/avatars/100/.png',
      imageBuilder: (context, imageProvider) => _buildImage(imageProvider),
      placeholder: (context, url) => _buildImage(defaultImg),
      errorWidget: (context, url, error) => _buildImage(defaultImg),
    );
  }

  Widget _buildImage(ImageProvider provider) {
    return Container(
      height: this.height ?? 52.00,
      width: this.width ?? 52.00,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: provider,
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset(0.00, 3.00),
            color: Color(0xff000000).withOpacity(0.16),
            blurRadius: 6,
          ),
        ],
        borderRadius: BorderRadius.circular(10.00),
      ),
    );
  }
}

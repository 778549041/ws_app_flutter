import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetImageWidget extends StatelessWidget {
  final double width;
  final double height;
  final String imageUrl;
  final String placeholder;
  final BoxFit fit;

  NetImageWidget(
      {this.width, this.height, this.imageUrl, this.placeholder, this.fit})
      : assert(imageUrl != null);

  Widget _buildPlaceholder() {
    if (placeholder != null) {
      return Image.asset(
        placeholder,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return imageUrl.length > 0
        ? CachedNetworkImage(
            imageUrl: imageUrl,
            width: width,
            height: height,
            placeholder: (context, url) => _buildPlaceholder(),
            fit: fit,
          )
        : _buildPlaceholder();
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetImageWidget extends StatelessWidget {
  final double? width;
  final double? height;
  final String? imageUrl;
  final String? placeholder;
  final BoxFit fit;
  final Color? color;

  NetImageWidget({
    this.width,
    this.height,
    this.imageUrl,
    this.placeholder,
    this.fit = BoxFit.cover,
    this.color,
  });

  Widget _buildPlaceholder() {
    if (placeholder != null) {
      return Image.asset(
        placeholder!,
        width: width,
        height: height,
        fit: fit,
      );
    } else {
      return Container(
        width: width,
        height: height,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return (imageUrl != null && imageUrl!.contains('http'))
        ? CachedNetworkImage(
            imageUrl: imageUrl!,
            color: color,
            width: width,
            height: height,
            placeholder: (context, url) => _buildPlaceholder(),
            errorWidget: (context, url, error) => _buildPlaceholder(),
            fit: fit,
          )
        : _buildPlaceholder();
  }
}

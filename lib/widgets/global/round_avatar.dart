import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundAvatar extends StatelessWidget {
  final double height;
  final double borderWidth;
  final Color borderColor;
  final String placeHolder;
  final String? imageUrl;
  final VoidCallback? onPressed;

  RoundAvatar({
    this.height = 60.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
    this.placeHolder = 'assets/images/mine/ic_people.png',
    this.imageUrl,
    this.onPressed,
  });

  Widget _buildPlaceholder() {
    return Image.asset(
      this.placeHolder,
      fit: BoxFit.fill,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed ?? null,
      child: Container(
        width: height,
        height: height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: borderWidth, color: borderColor),
        ),
        child: ClipOval(
          child: imageUrl != null
              ? CachedNetworkImage(
                  imageUrl: imageUrl!,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => _buildPlaceholder(),
                  errorWidget: (context, url, error) => _buildPlaceholder(),
                )
              : _buildPlaceholder(),
        ),
      ),
    );
  }
}
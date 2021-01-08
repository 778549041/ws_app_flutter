import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class RoundAvatar extends StatelessWidget {
  final double height;
  final double borderWidth;
  final Color borderColor;
  final String placeHolder;
  final String imageUrl;
  final VoidCallback onPressed;

  RoundAvatar({
    this.height = 60.0,
    this.borderWidth = 2.0,
    this.borderColor = Colors.white,
    this.placeHolder = 'assets/images/mine/ic_people.png',
    @required this.imageUrl,
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
      onTap: this.onPressed ?? null,
      child: Container(
        width: this.height,
        height: this.height,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(width: this.borderWidth, color: this.borderColor),
        ),
        child: ClipOval(
          child: this.imageUrl.length > 0
              ? CachedNetworkImage(
                  imageUrl: this.imageUrl ?? '',
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

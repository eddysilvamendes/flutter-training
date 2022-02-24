// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ProfileWidget extends StatelessWidget {
  final String imgPath;
  final bool isEdit;
  final VoidCallback onTap;
  const ProfileWidget(
      {Key? key,
      required this.imgPath,
      required this.isEdit,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: [
          _buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: _editIcon(Theme.of(context).colorScheme.primary),
          ),
        ],
      ),
    );
  }

  _editIcon(Color color) => _buildCircle(
        color: color,
        all: 8,
        child: Icon(
          isEdit == true ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      );

  _buildCircle(
          {required Color color, required double all, required Icon child}) =>
      ClipOval(
        child: Container(
          padding: EdgeInsets.all(all),
          color: color,
          child: child,
        ),
      );

  _buildImage() {
    final image = NetworkImage(imgPath);
    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 128,
          height: 128,
          child: InkWell(
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}

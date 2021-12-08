part of product_details;

class _ShareButton extends StatelessWidget {
  const _ShareButton({required this.onPressed, Key? key}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustonIconButton(
      icon: Icon(
        FontAwesomeIcons.share,
      ),
      onPressed: onPressed,
      size: 40,
      borderRadius: 10,
      tolltip: "share",
    );
  }
}

part of product_details;

class _BackButton extends StatelessWidget {
  const _BackButton({required this.onPressed, Key? key}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustonIconButton(
      icon: Icon(
        FontAwesomeIcons.chevronLeft,
      ),
      onPressed: onPressed,
      size: 40,
      borderRadius: 10,
      tolltip: "back",
    );
  }
}

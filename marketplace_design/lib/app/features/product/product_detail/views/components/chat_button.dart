part of product_details;

class _ChatButton extends StatelessWidget {
  const _ChatButton({required this.onPressed, Key? key}) : super(key: key);

  final Function() onPressed;
  @override
  Widget build(BuildContext context) {
    return CustonIconButton(
      icon: Icon(
        FontAwesomeIcons.commentAlt,
        color: Theme.of(context).primaryColor,
      ),
      onPressed: onPressed,
      size: 40,
      borderRadius: 10,
      color: Theme.of(context).primaryColor.withOpacity(.2),
      tolltip: "Chat",
    );
  }
}
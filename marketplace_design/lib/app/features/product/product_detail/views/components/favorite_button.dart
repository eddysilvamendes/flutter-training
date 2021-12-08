part of product_details;

class _FavoriteButtom extends StatelessWidget {
  const _FavoriteButtom(
      {required this.initial, required this.onChanged, Key? key})
      : super(key: key);

  final bool initial;
  final Function(bool isFavorite) onChanged;
  @override
  Widget build(BuildContext context) {
    final RxBool isFavorite = RxBool(initial);
    return Obx(() => CustonIconButton(
          icon: Icon(
            FontAwesomeIcons.solidStar,
            color: isFavorite.value
                ? Colors.white
                : Theme.of(context).iconTheme.color,
          ),
          onPressed: () {
            isFavorite.toggle();
            onChanged(isFavorite.value);
          },
          color: isFavorite.value ? Theme.of(context).primaryColor : null,
          size: 40,
          borderRadius: 10,
          tolltip: "favorite",
        ));
  }
}

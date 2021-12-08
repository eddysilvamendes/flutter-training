part of product_details;

class _NameText extends StatelessWidget {
  const _NameText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
        fontWeight: FontWeight.bold,
        color: kFontColorPallets[0],
        fontSize: 18,
      ),
      textAlign: TextAlign.justify,
    );
  }
}

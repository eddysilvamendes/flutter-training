part of product_details;

class _PriceText extends StatelessWidget {
  const _PriceText(this.data, {Key? key}) : super(key: key);

  final String data;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          FontAwesomeIcons.dollarSign,
          size: 25,
          color: Theme.of(context).primaryColor,
        ),
        Expanded(
          child: Text(
            data,
            style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}

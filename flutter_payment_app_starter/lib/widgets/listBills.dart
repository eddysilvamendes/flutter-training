import 'package:flutter/material.dart';
import 'package:flutter_payment_app/component/colors.dart';
import 'package:flutter_payment_app/widgets/text_size.dart';

class ListBillsContent extends StatelessWidget {
  final String img;
  final String companyName;
  final String id;
  final String price;
  final String discription;
  final VoidCallback? onTap;
  final Color color;
  final Color? textColor;
  const ListBillsContent({
    Key? key,
    required this.img,
    required this.companyName,
    required this.id,
    required this.price,
    required this.discription,
    this.onTap,
    required this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      height: 130,
      width: MediaQuery.of(context).size.width - 10,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          bottomRight: Radius.circular(30),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColor.boxShadowCard,
            offset: Offset(1, 1),
            blurRadius: 20,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Container(
        margin: EdgeInsets.only(top: 10, left: 18),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      height: 60,
                      width: 60,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                          width: 3,
                          color: Colors.grey,
                        ),
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(img),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          companyName,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.mainColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          "ID: $id",
                          style: TextStyle(
                            fontSize: 16,
                            color: AppColor.idColor,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedText(
                  text: discription,
                  color: AppColor.green,
                ),
                SizedBox(height: 5),
              ],
            ),
            Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: color,
                        ),
                        child: Center(
                          child: Text(
                            "Select",
                            style: TextStyle(
                              fontSize: 16,
                              color: textColor,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(child: Container()),
                    Text(
                      "\$$price.00",
                      style: TextStyle(
                          fontSize: 18,
                          color: AppColor.mainColor,
                          fontWeight: FontWeight.w900),
                    ),
                    Text(
                      "Due in 3 days",
                      style: TextStyle(
                          fontSize: 14,
                          color: AppColor.idColor,
                          fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                  ],
                ),
                SizedBox(width: 5),
                Container(
                  width: 5,
                  height: 35,
                  decoration: BoxDecoration(
                    color: AppColor.halfOval,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

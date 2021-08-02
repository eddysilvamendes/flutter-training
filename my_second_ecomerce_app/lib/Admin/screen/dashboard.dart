import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/provider/app_states.dart';
import 'package:my_second_ecomerce_app/Admin/screen/add_Product.dart';
import 'package:my_second_ecomerce_app/Admin/screen/add_category.dart';
import 'package:my_second_ecomerce_app/Admin/widget/small_card.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:my_second_ecomerce_app/provider/order_provider.dart';
import 'package:my_second_ecomerce_app/provider/product_provider.dart';
import 'package:my_second_ecomerce_app/provider/user_provider.dart';
import 'package:my_second_ecomerce_app/User/screens/homePage.dart';
import 'package:my_second_ecomerce_app/User/widgets/commons.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class Task {
  String task;
  double taskvalue;
  Color colorval;

  Task(this.task, this.taskvalue, this.colorval);
}

class _DashboardState extends State<Dashboard> {
  TextEditingController categoryController = TextEditingController();
  late List<charts.Series<Task, String>> _seriesPieData =
      <charts.Series<Task, String>>[];
  _getData() {
    var piedata = [
      Task('Girls', 35.8, Colors.orange),
      Task('Women', 8.3, Colors.red),
      Task('Pants', 10.8, Colors.green),
      Task('Formal', 15.6, Colors.purple),
      Task('Shoes', 19.2, Colors.cyan),
      Task('Other', 10.3, Colors.amber),
    ];

    _seriesPieData.add(
      charts.Series(
        domainFn: (Task task, _) => task.task,
        measureFn: (Task task, _) => task.taskvalue,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(task.colorval),
        id: 'Air Pollution',
        data: piedata,
        labelAccessorFn: (Task row, _) => '${row.taskvalue}',
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _seriesPieData = <charts.Series<Task, String>>[];
    _getData();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    final user = Provider.of<UserProvider>(context);
    final order = Provider.of<OrderProvider>(context);
    final product = Provider.of<UserProductProvider>(context);
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: SafeArea(
        child: Row(
          children: [
            Container(
              decoration: BoxDecoration(color: white, boxShadow: [
                BoxShadow(
                    color: Colors.grey.shade400,
                    offset: Offset(1.0, 1.0),
                    blurRadius: 4)
              ]),
              width: 50,
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.menu,
                      color: black,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      appState.changeScreen(Screen.DASH);
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text("Dashboard"),
                        ),
                        Visibility(
                          visible: appState.selectedScreen == Screen.DASH,
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 60,
                                width: 5,
                                color: black,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      pushScreen(
                        context,
                        AddProduct(),
                      );
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text("Products"),
                        ),
                        Visibility(
                            visible: appState.selectedScreen == Screen.PRODUCTS,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 58,
                                  width: 5,
                                  color: black,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      pushScreen(
                        context,
                        AddCategory(),
                      );
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text("Categories"),
                        ),
                        Visibility(
                            visible:
                                appState.selectedScreen == Screen.CATEGORIES,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 58,
                                  width: 5,
                                  color: black,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      appState.changeScreen(Screen.BRANDS);
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text("Brands"),
                        ),
                        Visibility(
                            visible: appState.selectedScreen == Screen.BRANDS,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 58,
                                  width: 5,
                                  color: black,
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  InkWell(
                    onTap: () {
                      appState.changeScreen(Screen.ORDERS);
                    },
                    child: Wrap(
                      direction: Axis.horizontal,
                      children: [
                        RotatedBox(
                          quarterTurns: -1,
                          child: Text("Order"),
                        ),
                        Visibility(
                          visible: appState.selectedScreen == Screen.ORDERS,
                          child: Wrap(
                            children: [
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                height: 58,
                                width: 5,
                                color: black,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        pushScreenReplacement(
                          context,
                          HomePage(),
                        );
                      },
                      child: Wrap(
                        direction: Axis.horizontal,
                        children: [
                          RotatedBox(
                            quarterTurns: -1,
                            child: Text("User"),
                          ),
                          Visibility(
                            visible: appState.selectedScreen == Screen.ORDERS,
                            child: Wrap(
                              children: [
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 58,
                                  width: 5,
                                  color: black,
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.open_in_new),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.all(10),
                  child: RichText(
                    text: TextSpan(children: [
                      TextSpan(
                        text: 'Revenue\n',
                        style: TextStyle(fontSize: 35, color: Colors.grey),
                      ),
                      TextSpan(
                        text: '\$1287.99',
                        style: TextStyle(
                            fontSize: 55,
                            color: Colors.black,
                            fontWeight: FontWeight.w300),
                      ),
                    ]),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SmallCard(
                      color2: Colors.indigo,
                      color1: Colors.blue,
                      icon: Icons.person_outline,
                      value: user.userList.length,
                      title: 'Users',
                    ),
                    SmallCard(
                      color2: Colors.indigo,
                      color1: Colors.blue,
                      icon: Icons.shopping_cart,
                      value: order.order.length,
                      title: 'Orders',
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    SmallCard(
                      color2: Colors.black87,
                      color1: Colors.black87,
                      icon: Icons.attach_money,
                      value: product.sales.length,
                      title: 'Sales',
                    ),
                    SmallCard(
                      color2: Colors.black,
                      color1: Colors.black87,
                      icon: Icons.shopping_basket,
                      value: 230,
                      title: 'Stock',
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Text(
                    'Sales per category',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: white,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.shade400,
                                offset: Offset(1.0, 1.0),
                                blurRadius: 4)
                          ]),
                      width: MediaQuery.of(context).size.width / 1.2,
                      child: ListTile(
                        title: charts.PieChart(
                          _seriesPieData,
                          animate: true,
                          animationDuration: Duration(seconds: 3),
                          behaviors: [
                            new charts.DatumLegend(
                              outsideJustification:
                                  charts.OutsideJustification.endDrawArea,
                              horizontalFirst: false,
                              desiredMaxRows: 2,
                              cellPadding:
                                  new EdgeInsets.only(right: 4.0, bottom: 4.0),
                            )
                          ],
                          defaultRenderer: new charts.ArcRendererConfig(
                            arcWidth: 30,
                            arcRendererDecorators: [
                              new charts.ArcLabelDecorator(
                                  labelPosition: charts.ArcLabelPosition.inside)
                            ],
                          ),
                        ),
                      ),
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

import 'package:flutter/material.dart';
import 'package:my_second_ecomerce_app/Admin/screen/add_Product.dart';
import 'package:my_second_ecomerce_app/Admin/widget/dialog.dart';
import 'package:my_second_ecomerce_app/Admin/widget/menu.dart';
import 'package:my_second_ecomerce_app/Admin/widget/menu_button.dart';
import 'package:my_second_ecomerce_app/commons/commons.dart';

enum Page { dashboard, manage }

class Admin extends StatefulWidget {
  @override
  _AdminState createState() => _AdminState();
}

class _AdminState extends State<Admin> {
  Page _selectedPage = Page.dashboard;
  MaterialColor active = materialRed;
  MaterialColor notActive = materialGrey;
  TextEditingController categoryController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  GlobalKey<FormState> _categoryFormKey = GlobalKey();
  GlobalKey<FormState> _brandFormKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: <Widget>[
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.dashboard);
                      },
                      icon: Icon(
                        Icons.dashboard,
                        color: _selectedPage == Page.dashboard
                            ? active
                            : notActive,
                      ),
                      label: Text('Dashboard'))),
              Expanded(
                  child: FlatButton.icon(
                      onPressed: () {
                        setState(() => _selectedPage = Page.manage);
                      },
                      icon: Icon(
                        Icons.sort,
                        color:
                            _selectedPage == Page.manage ? active : notActive,
                      ),
                      label: Text('Manage'))),
            ],
          ),
          elevation: 0.0,
          backgroundColor: white,
        ),
        body: _loadScreen());
  }

  Widget _loadScreen() {
    switch (_selectedPage) {
      case Page.dashboard:
        return Column(
          children: <Widget>[
            ListTile(
              subtitle: FlatButton.icon(
                onPressed: null,
                icon: Icon(
                  Icons.attach_money,
                  size: 30.0,
                  color: green,
                ),
                label: Text('12,000',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 30.0, color: green)),
              ),
              title: Text(
                'Revenue',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24.0, color: grey),
              ),
            ),
            Expanded(
              child: GridView(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2),
                children: <Widget>[
                  MenuButton(
                    icon: Icon(Icons.people),
                    name: "Users",
                    subName: "7",
                  ),
                  MenuButton(
                    icon: Icon(Icons.category),
                    name: "Categories",
                    subName: "24",
                  ),
                  MenuButton(
                    icon: Icon(Icons.track_changes),
                    name: "Products",
                    subName: "120",
                  ),
                  MenuButton(
                    icon: Icon(Icons.tag_faces),
                    name: "Sold",
                    subName: "15",
                  ),
                  MenuButton(
                    icon: Icon(Icons.shopping_cart),
                    name: "Orders",
                    subName: "10",
                  ),
                  MenuButton(
                    icon: Icon(Icons.close),
                    name: "Return",
                    subName: "0",
                  ),
                ],
              ),
            ),
          ],
        );
        break;
      case Page.manage:
        return ListView(
          children: <Widget>[
            MyMenu(
              name: "Add Product",
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) => AddProduct(),
                  ),
                );
              },
              icon: Icon(Icons.add),
            ),
            Divider(),
            MyMenu(
              name: "Product List",
              onPressed: () {},
              icon: Icon(Icons.list),
            ),
            Divider(),
            MyMenu(
              name: "Add Category",
              onPressed: () {
                var dialog = AlertFormOption(
                  controllerKey: categoryController,
                  formKey: _categoryFormKey,
                  message: "Category Created",
                  name: "Add Category",
                  dbName: "category",
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.add_circle_outline),
            ),
            Divider(),
            MyMenu(
              name: " Category List",
              onPressed: () {},
              icon: Icon(Icons.category),
            ),
            Divider(),
            MyMenu(
              name: "Add Brand",
              onPressed: () {
                var dialog = AlertFormOption(
                  controllerKey: categoryController,
                  formKey: _categoryFormKey,
                  message: "Brand Created",
                  name: "Add Brand",
                  dbName: "brand",
                );
                showDialog(context: context, builder: (_) => dialog);
              },
              icon: Icon(Icons.add_circle),
            ),
            Divider(),
            MyMenu(
              name: "Brand List",
              onPressed: () {},
              icon: Icon(Icons.list_alt),
            ),
            Divider(),
          ],
        );
        break;
      default:
        return Container();
    }
  }
}

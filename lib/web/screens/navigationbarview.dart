import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ui/widgets/customdropdown.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:ui/controllers/scrollconroller.dart';
import 'package:ui/web/screens/form_screen.dart';
import 'package:ui/web/screens/homepage.dart';
import 'package:ui/web/screens/productfrom_screen.dart';

class TopNavigatiobarviewState extends StatefulWidget {
  const TopNavigatiobarviewState({super.key});

  @override
  State<TopNavigatiobarviewState> createState() =>
      _TopNavigatiobarviewStateState();
}

int screenIndex = 0;
final List<Widget> page = [
  HomePage(),
  FormScreen(),
  ProductFormScreen(),
];
late final ValueChanged<int> onTap;
double pageOffset = 0;
bool dropdowncheck = false;
bool atedge = true;
double minscrollextent = 0;
double maxscrollextent = 0;

class _TopNavigatiobarviewStateState extends State<TopNavigatiobarviewState> {
  @override
  Widget build(BuildContext context) {
    bool ismobile = MediaQuery.of(context).size.width < 700 ? true : false;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: ismobile
          ? AppBar(
              backgroundColor: Colors.green,
              flexibleSpace: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(width: 40, "assets/images/farmerallylogo.png"),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "FARMER",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          " ALLY",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            )
          : PreferredSize(preferredSize: Size(0, 0), child: Container()),
      drawer: ismobile
          ? Drawer(
              backgroundColor: Colors.green,
              child: ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image:
                              AssetImage("assets/images/farmerallylogo.png")),
                      color: Colors.green,
                    ),
                    child: Text(
                      'Farmer Ally',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ),
                  ),
                  ListTile(
                    title: Text('Home Page'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      setState(() {
                        screenIndex = 0;
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Crop Form'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      setState(() {
                        screenIndex = 1;
                      });
                    },
                  ),
                  ListTile(
                    title: Text('Product Form'),
                    onTap: () {
                      Navigator.pop(context); // Close the drawer
                      setState(() {
                        screenIndex = 2;
                      });
                    },
                  ),
                  Divider(),
                  ListTile(
                    title: Text('Log out'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                  ListTile(
                    title: Text('Close Drawer'),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            )
          : null,
      body: NestedScrollView(
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            ismobile
                ? SliverToBoxAdapter()
                : SliverAppBar(
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(9.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green.shade500,
                          borderRadius: BorderRadius.all(Radius.circular(40)),
                        ),
                        height: 2,
                        width: MediaQuery.of(context).size.width,
                      ),
                    ),
                    elevation: 9,
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        verticalDirection: VerticalDirection.up,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                screenIndex = 0;
                              });
                            },
                            child: Image.asset(
                                width: 40, "assets/images/farmerallylogo.png"),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: () {
                              setState(() {
                                screenIndex = 0;
                              });
                            },
                            child: Column(
                              children: [
                                Text(
                                  "Farmer",
                                  style: TextStyle(
                                    fontFamily: "Cursive Font",
                                    color: Colors.green[800],
                                    fontSize: 23,
                                  ),
                                ),
                                Text(
                                  "   Ally",
                                  style: TextStyle(
                                    fontFamily: "Cursive Font",
                                    color: Colors.green,
                                    fontSize: 23,
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    flexibleSpace: Container(
                      margin: EdgeInsets.only(
                        left: 250,
                        right: 100,
                      ),
                      constraints: BoxConstraints(maxWidth: 300, minWidth: 100),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              setState(() {
                                screenIndex = 0;
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  top: 15, left: 8, right: 8),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    "Home",
                                    style: TextStyle(
                                      fontSize: screenIndex == 0 ? 17 : 15,
                                      color: screenIndex == 0
                                          ? Colors.green
                                          : Colors.grey,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 13,
                                  ),
                                  AnimatedContainer(
                                    decoration: BoxDecoration(
                                        color: Colors.green[800],
                                        borderRadius: BorderRadius.only(
                                            bottomLeft: Radius.circular(9),
                                            bottomRight: Radius.circular(9))),
                                    duration: Duration(milliseconds: 500),
                                    width: screenIndex == 0 ? 20 : 0,
                                    height: 3,
                                  )
                                ],
                              ),
                            ),
                          ),
                          Flexible(
                            child: Container(
                              constraints:
                                  BoxConstraints(maxWidth: 80, minWidth: 0),
                            ),
                          ),
                          WindowStyleDropdownMenu(
                            dropdownBackgroundColor: Colors.grey[300],
                            titleWidget: Row(
                              children: [
                                Text(
                                  "Create",
                                  style: TextStyle(
                                    fontSize:
                                        screenIndex == 1 || screenIndex == 2
                                            ? 17
                                            : 15,
                                    color: screenIndex == 1 || screenIndex == 2
                                        ? Colors.green
                                        : Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            dropdownItems: [
                              ListTile(
                                  mouseCursor: SystemMouseCursors.click,
                                  title: TextButton(
                                    child: Text(
                                      "Crop form",
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        screenIndex = 1;
                                      });
                                    },
                                  )),
                              ListTile(
                                  mouseCursor: SystemMouseCursors.click,
                                  title: TextButton(
                                    child: Text("Prouct form",
                                        style: TextStyle(color: Colors.black)),
                                    onPressed: () {
                                      setState(() {
                                        screenIndex = 2;
                                      });
                                    },
                                  )),
                            ],
                            buttonTitle: 'Create',
                          ),
                        ],
                      ),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green[100]),
                            ),
                            onPressed: () {},
                            child: Text("Log In/Sign Up")),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(Colors.green[100]),
                            ),
                            onPressed: () {},
                            child: Text("Log out")),
                      )
                    ],
                  )
          ];
        },
        body: page[screenIndex],
      ),
      floatingActionButton: ClipRRect(
        borderRadius:
            BorderRadius.circular(20.0), // Adjust the radius as needed
        child: Container(
          color: Colors.green,
          width: 50.0,
          height: 50.0,
          child: Center(
              child: IconButton(
            icon: Icon(
              Icons.message,
              color: Colors.white,
            ),
            onPressed: () {},
          )),
        ),
      ),
    );
  }
}

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:footer/footer.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../controllers/scrollconroller.dart';
import '../../widgets/fotter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollControllerGetX _controller = Get.put(ScrollControllerGetX());
  List<String> flowcropformimages = [
    "assets/images/cropdetailsimg.png",
    "assets/images/cropstagesimg.png",
    "assets/images/productsimg.png",
    "assets/images/selectimgicon.png",
    "assets/images/submitimg.png",
  ];
  List<String> flowproductformimages = [
    "assets/images/productsimg.png",
    "assets/images/selectimgicon.png",
    "assets/images/submitimg.png",
  ];
  List<String> flowproductformstrings = [
    "Enter the basic details of the product",
    "Select a good and low mb image",
    "submit all the details"
  ];
  List<String> flowcropformstrings = [
    "Enter the basic details of the crop",
    "Add a stage to every part of that plant lifecycle you are refering to",
    "At every stage you can select the products that can be used,if the product is not avilable you can add it from Product from",
    "Select an image of the crop with less size ",
    "Submit all the details",
  ];
  List<String> curoselimages = [
    "assets/images/homepagecoroselimg1.jpg",
    "assets/images/homepagecoroselimg3.png",
    "assets/images/productbgimg.png",
    "assets/images/homepagecoroselimg2.png",
  ];
  int curoselindex = 0;
  CarouselController buttonCarouselController = CarouselController();
  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width > 700 ? false : true;
    return SingleChildScrollView(
      // Step 3: Assign ScrollController
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                opacity: 0.2,
                fit: BoxFit.cover,
                image: AssetImage(
                  "assets/images/homepagecoroselimg1.jpg",
                ))),
        child: Column(
          children: [
            Container(
                height: 700,
                width: MediaQuery.of(context).size.width,
                child: Stack(
                  children: [
                    CarouselSlider(
                      carouselController: buttonCarouselController,
                      options: CarouselOptions(
                        height: 700.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1,
                        autoPlay: true,
                        onPageChanged: (index, reason) {
                          setState(() {
                            curoselindex = index;
                          });
                        },
                      ),
                      items: curoselimages.map((imagePath) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.asset(
                                imagePath,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 40),
                        child: DotsIndicator(
                          onTap: (position) {
                            setState(() => curoselindex = position);
                            buttonCarouselController.jumpToPage(curoselindex);
                          },
                          dotsCount: curoselimages.length,
                          position: curoselindex,
                          decorator: DotsDecorator(
                            size: const Size.square(12.0),
                            activeSize: const Size(20.0, 12.0),
                            activeShape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                        ),
                      ),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 600),
                      opacity: curoselindex == 0 ? 1 : 0,
                      child: AnimatedAlign(
                          duration: Duration(milliseconds: 600),
                          alignment: curoselindex == 0
                              ? Alignment.center
                              : Alignment.bottomLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Welcome to the Farmer Ally",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white),
                              ),
                              Text(
                                " Your Gateway to Agricultural Excellence!",
                                style: TextStyle(
                                    fontSize: 8.sp, color: Colors.grey),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green[100]),
                                  ),
                                  onPressed: () {},
                                  child: Text("Know more"))
                            ],
                          )),
                    ),
                    AnimatedOpacity(
                      duration: Duration(milliseconds: 600),
                      opacity: curoselindex == 1 ? 1 : 0,
                      child: AnimatedAlign(
                          duration: Duration(milliseconds: 600),
                          alignment: curoselindex == 1
                              ? Alignment.center
                              : Alignment.topRight,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Prepare to unleash your crop's full potential! Share the details now",
                                style: TextStyle(
                                    fontSize: 10.sp, color: Colors.white),
                              ),
                              Text(
                                " Please provide the details for the crop!",
                                style: TextStyle(
                                    fontSize: 8.sp, color: Colors.grey),
                              ),
                              TextButton(
                                  style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.green[100]),
                                  ),
                                  onPressed: () {},
                                  child: Text("Enter details"))
                            ],
                          )),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 70),
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 60),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Your smart Ally on the go",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            color: Colors.green,
                            width: 20,
                            height: 2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      constraints:
                          BoxConstraints(minWidth: 12.w, maxWidth: 320.w),
                      child: Text(
                        "We help your crops grow – in a smart way, with our Crop Expert, Developed for the needs of professional users, with the focus on fruits, vegetables, field crops, turf & public green, nursery & ornamentals. The smartphone app includes fertilizer recommendation plans, for different growth stages, expert knowledge in the form of videos and documents and the option to get in touch with one of our experts. Your digital home for safe and sustainable growth.",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90, left: 70),
              child: Container(
                margin: EdgeInsets.only(bottom: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(bottom: 60),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Unlock Growth and Prosperity for Your Farm",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Container(
                            color: Colors.green,
                            width: 20,
                            height: 2,
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 30,
                    ),
                    Container(
                      padding: EdgeInsets.only(right: 8),
                      constraints:
                          BoxConstraints(minWidth: 12.w, maxWidth: 320.w),
                      child: Text(
                        "As a farmer, access to reliable information is crucial for the success of your crops and agricultural ventures. Farmer Ally empowers you with the tools and resources needed to enhance productivity and make informed decisions:",
                        style: TextStyle(
                          color: Colors.black45,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      child: Column(
                        children: [
                          Text(
                            "Flow of crop form",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 10.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 40),
                            width: MediaQuery.of(context).size.width,
                            height: 300,
                            child: ListView.builder(
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: flowcropformimages.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: EdgeInsets.all(15),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Card(
                                          child: Container(
                                            margin: EdgeInsets.all(10),
                                            child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  ClipOval(
                                                    child: Image.asset(
                                                      flowcropformimages[index],
                                                      width: 80,
                                                      height: 90,
                                                    ),
                                                  ),
                                                  Container(
                                                    constraints: BoxConstraints(
                                                        maxWidth: 200,
                                                        minWidth: 50),
                                                    child: Text(
                                                      flowcropformstrings[
                                                          index],
                                                      maxLines: 5,
                                                    ),
                                                  )
                                                ]),
                                          ),
                                        ),
                                        index == flowcropformimages.length - 1
                                            ? SizedBox()
                                            : Icon(Icons.arrow_circle_right)
                                      ],
                                    ),
                                  );
                                }),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 65),
              child: Container(
                margin: EdgeInsets.only(top: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Flow of product form",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 40),
                      width: MediaQuery.of(context).size.width,
                      height: 300,
                      child: ListView.builder(
                          shrinkWrap: true,
                          scrollDirection: Axis.horizontal,
                          itemCount: flowproductformimages.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.all(15),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Card(
                                    child: Container(
                                      margin: EdgeInsets.all(10),
                                      child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            ClipOval(
                                              child: Image.asset(
                                                flowproductformimages[index],
                                                width: 80,
                                                height: 90,
                                              ),
                                            ),
                                            Container(
                                              constraints: BoxConstraints(
                                                  maxWidth: 200, minWidth: 50),
                                              child: Text(
                                                flowproductformstrings[index],
                                                maxLines: 5,
                                              ),
                                            )
                                          ]),
                                    ),
                                  ),
                                  index == flowproductformimages.length - 1
                                      ? SizedBox()
                                      : Icon(Icons.arrow_circle_right)
                                ],
                              ),
                            );
                          }),
                    ),
                  ],
                ),
              ),
            ),
            Footer(child: CustomFooter())
          ],
        ),
      ),
    );
  }
}

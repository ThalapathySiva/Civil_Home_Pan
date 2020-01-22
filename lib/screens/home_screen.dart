import 'package:civil_home_plan/components/custom_text.dart';
import 'package:civil_home_plan/components/primary_button.dart';
import 'package:civil_home_plan/constants/colors.dart';
import 'package:civil_home_plan/models/plan_detail_model.dart';
import 'package:civil_home_plan/screens/result_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_view_indicators/page_view_indicators.dart';

final PageController controller = PageController();
final _currentPageNotifier = ValueNotifier<int>(0);

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool one = false, two = false, three = false;
  bool onebhk = false, twobhk = false, threebhk = false, fourbhk = false;
  String selectedLand;
  List<DropdownMenuItem<String>> _dropDownMenuItems;
  List<String> sizeOfLandList = [
    "800-900",
    "900-1000",
    "1000-1100",
    "1100-1200",
    "1200-1300",
    "1300-1400",
    "1400-1500",
    "1500-1600",
    "1600-1700",
    "1700-1800",
    "1800-1900",
    "1900-2000",
    "2000-2100",
    "2100-2200",
    "2200-2300",
    "2300-2400",
    "2400-3000",
    "3000-3500",
    "3500-4000",
    "Above 4000"
  ];

  List<PlanDetailItem> planList;

  Map inputs = {"sizeOfLand": "", "noOfStorey": "", "noOfBhk": ""};

  @override
  void initState() {
    _dropDownMenuItems = buildAndGetDropDownMenuItems(sizeOfLandList);
    selectedLand = _dropDownMenuItems[0].value;
    inputs["sizeOfLand"] = _dropDownMenuItems[0].value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: layout()));
  }

  Widget layout() {
    bool condition = inputs["sizeOfLand"] != "" &&
        inputs["noOfStorey"] != "" &&
        inputs["noOfBhk"] != "";
    return Stack(children: [
      Positioned(left: 20, top: 10, child: title()),
      PageView(
        controller: controller,
        onPageChanged: (int index) {
          _currentPageNotifier.value = index;
          getPageChange(index);
        },
        children: <Widget>[
          sqftWidget(),
          numberofStorey(),
          noofBhk(),
        ],
      ),
      Positioned(
        left: 0.0,
        right: 0.0,
        bottom: 30.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CirclePageIndicator(
            itemCount: 3,
            currentPageNotifier: _currentPageNotifier,
          ),
        ),
      ),
      Positioned(
        left: 60.0,
        right: 60.0,
        bottom: 10.0,
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: ArrowPageIndicator(
            iconColor: Colors.blue,
            pageController: controller,
            child: Padding(
              padding: EdgeInsets.all(30),
            ),
            currentPageNotifier: _currentPageNotifier,
            itemCount: 3,
            isInside: true,
            leftIcon: Icon(
              Icons.arrow_back,
              size: 40,
              color: Colors.blue,
            ),
            rightIcon: Icon(
              Icons.arrow_forward,
              size: 40,
              color: Colors.blue,
            ),
          ),
        ),
      ),
      condition
          ? Positioned(
              right: 60,
              bottom: 20,
              child: Visibility(
                visible: _currentPageNotifier.value == 2 ? true : false,
                child: SizedBox(
                  width: 50,
                  height: 50,
                  child: FloatingActionButton(
                    elevation: 0,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (BuildContext context) => ResultScreen(
                                inputs: inputs,
                              )));
                    },
                    child: Icon(
                      Icons.done,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            )
          : Container(),
    ]);
  }

  Widget title() {
    return Container(
        child: CustomText(text: "Let us know !", isBold: true, size: 32));
  }

  List<DropdownMenuItem<String>> buildAndGetDropDownMenuItems(List lands) {
    List<DropdownMenuItem<String>> items = List();
    for (String land in lands) {
      items.add(DropdownMenuItem(value: land, child: Text(land)));
    }
    return items;
  }

  void changedDropDownItem(String selected) {
    setState(() {
      selectedLand = selected;
      inputs["sizeOfLand"] = selected;
    });
  }

  Widget sqftWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CustomText(text: "Size of Land (in sqft) :", isBold: true, size: 18),
          DropdownButton(
            style: TextStyle(
                color: BLUE_COLOR, fontSize: 18, fontWeight: FontWeight.bold),
            elevation: 10,
            value: selectedLand,
            items: _dropDownMenuItems,
            onChanged: changedDropDownItem,
          ),
        ],
      ),
    );
  }

  Widget noofBhk() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(text: "No of BHK :", isBold: true, size: 18),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            typeofBuildItem("1 BHK", () {
              setState(() {
                onebhk = true;
                twobhk = false;
                threebhk = false;
                fourbhk = false;
                inputs["noOfBhk"] = "1";
              });
            }, onebhk),
            typeofBuildItem("2 BHK", () {
              setState(() {
                twobhk = true;
                onebhk = false;
                threebhk = false;
                fourbhk = false;
                inputs["noOfBhk"] = "2";
              });
            }, twobhk),
            typeofBuildItem("3 BHK", () {
              setState(() {
                threebhk = true;
                onebhk = false;
                twobhk = false;
                fourbhk = false;
                inputs["noOfBhk"] = "3";
              });
            }, threebhk),
            typeofBuildItem("4 BHK", () {
              setState(() {
                fourbhk = true;
                onebhk = false;
                twobhk = false;
                threebhk = false;
                inputs["noOfBhk"] = "4";
              });
            }, fourbhk)
          ],
        ),
      ],
    );
  }

  Widget numberofStorey() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        CustomText(text: "No of Storey :", isBold: true, size: 18),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            typeofBuildItem("   1   ", () {
              setState(() {
                one = true;
                two = false;
                three = false;
                inputs["noOfStorey"] = "1";
              });
            }, one),
            typeofBuildItem("   2   ", () {
              setState(() {
                two = true;
                three = false;
                one = false;
                inputs["noOfStorey"] = "2";
              });
            }, two),
            typeofBuildItem("   3   ", () {
              setState(() {
                three = true;
                one = false;
                two = false;
                inputs["noOfStorey"] = "3";
              });
            }, three)
          ],
        ),
      ],
    );
  }

  Widget typeofBuildItem(String text, Function onpressed, bool isBorder) {
    return InkWell(
      onTap: onpressed,
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
          border:
              Border.all(color: isBorder ? BLUE_COLOR : BLACK_COLOR, width: 1),
        ),
        child: CustomText(
          text: text,
          isBold: false,
          color: isBorder ? BLUE_COLOR : BLACK_COLOR,
        ),
      ),
    );
  }

  void getPageChange(int index) {
    _currentPageNotifier.value = index;
    setState(() {});
  }
}
// List filteredList = datas
//           .sublist(1)
//           .where((i) =>
//               i["bhk"] == int.parse(inputs["noOfBhk"]) &&
//               i["sqft"] == inputs["sizeOfLand"] &&
//               i["storey"] == int.parse(inputs["noOfStorey"]))
//           .toList();
//       planList = filteredList.map((f) => PlanDetailItem.fromJson(f)).toList();

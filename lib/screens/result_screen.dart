import 'package:civil_home_plan/constants/colors.dart';
import 'package:civil_home_plan/models/plan_detail_model.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class ResultScreen extends StatefulWidget {
  final Map inputs;

  const ResultScreen({Key key, this.inputs}) : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  List datas;
  List<PlanDetailItem> planList;
  @override
  void initState() {
    getPlans();
    super.initState();
  }

  getPlans() {
    FirebaseDatabase.instance
        .reference()
        .child("browsePlans")
        .once()
        .then((DataSnapshot snapshot) {
      datas = snapshot.value;
      print(datas);
      List filteredList = datas
          .sublist(1)
          .where((i) =>
              i["bhk"] == int.parse(widget.inputs["noOfBhk"]) &&
              i["sqft"] == widget.inputs["sizeOfLand"] &&
              i["storey"] == int.parse(widget.inputs["noOfStorey"]))
          .toList();

      print("filter" + filteredList.toString());

      planList = filteredList.map((f) => PlanDetailItem.fromJson(f)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Plans"),
      ),
      body: SafeArea(child: layout()),
    );
  }

  Widget layout() {
    if (planList == null) {
      return Container();
    }
    if (planList.length == 0) {
      return Center(
          child: Text(
        "No Plans Found !",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ));
    }

    return GridView.builder(
        itemCount: planList.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (BuildContext context, int index) {
          print("images " + planList[index].image);
          return GridTile(
            child: InkResponse(
              enableFeedback: true,
              child: Image.network(
                '${planList[index].image}',
                fit: BoxFit.cover,
              ),
              onTap: () {
                showDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      contentPadding: EdgeInsets.all(0),
                      content: Container(
                          height: 300,
                          width: 1200,
                          child: PhotoView(
                            backgroundDecoration:
                                BoxDecoration(color: WHITE_COLOR),
                            imageProvider: NetworkImage(
                              '${planList[index].image}',
                            ),
                          )),
                    );
                  },
                );
              },
            ),
          );
        });
  }
}

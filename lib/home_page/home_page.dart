import 'package:flutter/material.dart';
import 'package:orcun_math/home_page/home_page_2.dart';
import 'package:orcun_math/home_page/home_page_view_model.dart';
import 'package:orcun_math/models/target_list_model.dart';
import 'package:provider/provider.dart';

import '../widgets/home_page_chart_field.dart';
import '../widgets/home_page_information_result.dart';
import '../widgets/home_page_target_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int questionNumber = 0;
  DateTime date = DateTime.now();
  TextEditingController textController = TextEditingController();
  String errorText = "";
  bool isError = false;
  String time = "";
  bool backColor = true;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (BuildContext context) => HomePageViewModel(),
      builder: (context, child) => Scaffold(
        backgroundColor: Colors.white,
        body: Scrollbar(
          child: SingleChildScrollView(
            child: StreamBuilder<List<TargetListModel>>(
              stream: Provider.of<HomePageViewModel>(context, listen: false)
                  .getTargetList(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<TargetListModel>>? asyncSnapshot) {
                if (asyncSnapshot!.hasError) {
                  print("hata: $asyncSnapshot");
                  return const Center(
                    child: Text("Bir hata oluştu"),
                  );
                } else {
                  if (!asyncSnapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    List<TargetListModel>? targetList = asyncSnapshot.data;
                    int result = 0;
                    int target = 0;
                    int count = 0;
                    for (var i in targetList!) {
                      result = result + i.result!;
                      target = target + i.target!;
                      count = count + 1;
                    }
                    if ((result / count) < (target / count)) {
                      backColor = false;
                    } else {
                      backColor = true;
                    }
                    print(targetList[0].date);
                    return Column(
                      children: [
                        HomePageChartField(
                          targetList: targetList,
                          backColor: backColor,
                        ),
                        HomePageTargetField(
                          backColor: backColor,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Container(
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(
                                Radius.circular(20),
                              ),
                              color: Colors.white,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: const [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "TARİH",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "HEDEF",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "SONUÇ",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    height: MediaQuery.of(context).size.height *
                                        .001,
                                    color: Colors.grey,
                                  ),
                                  for (var i in targetList)
                                    HomePageInformationResult(
                                      i: i,
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    );
                  }
                }
              },
            ),
          ),
        ),
        appBar: AppBar(
          backgroundColor: backColor ? Colors.green[600] : Colors.red[600],
          title: const Center(
            child: Text("Orçun DÖNMEZ"),
          ),
        ),
        floatingActionButton: StreamBuilder<List<TargetListModel>>(
          stream: Provider.of<HomePageViewModel>(context, listen: false)
              .getTarget(),
          builder: (BuildContext context,
              AsyncSnapshot<List<TargetListModel>>? asyncSnapshot) {
            if (asyncSnapshot!.hasError) {
              print("hata: $asyncSnapshot");
              return const Center(
                child: Text("Bir hata oluştu"),
              );
            } else {
              if (!asyncSnapshot.hasData) {
                return const Center(child: CircularProgressIndicator());
              } else {
                List<TargetListModel>? target = asyncSnapshot.data;
                print(target![0].target);
                return FloatingActionButton(
                  backgroundColor: backColor ? Colors.green : Colors.red,
                  child: const Icon(
                    Icons.add,
                    size: 35,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => HomePage2(
                                  target: target[0].target,
                                  isError: false,
                                )));
                  },
                );
              }
            }
          },
        ),
      ),
    );
  }
}

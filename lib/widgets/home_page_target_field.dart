import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../home_page/home_page_view_model.dart';
import '../models/target_list_model.dart';

class HomePageTargetField extends StatelessWidget {
  HomePageTargetField({
    Key? key,
    required this.backColor,
  }) : super(key: key);

  final bool backColor;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<TargetListModel>>(
      stream:
          Provider.of<HomePageViewModel>(context, listen: false).getTarget(),
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
            return SizedBox(
              height: MediaQuery.of(context).size.height * .08,
              width: MediaQuery.of(context).size.width * 1,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.symmetric(
                    horizontal: BorderSide(
                        color: backColor ? Colors.green : Colors.red,
                        style: BorderStyle.solid,
                        width: 3),
                  ),
                  color: backColor ? Colors.green : Colors.red,
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Günlük Soru Hedefi : ",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        target.first.target.toString(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
        }
      },
    );
  }
}

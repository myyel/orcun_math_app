import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'home_page_view_model.dart';

class HomePage2 extends StatefulWidget {
  HomePage2({Key? key, required this.target, required this.isError})
      : super(key: key);
  final int? target;
  bool isError;

  @override
  State<HomePage2> createState() => _HomePage2State();
}

class _HomePage2State extends State<HomePage2> {
  int questionNumber = 0;
  DateTime date = DateTime.now();
  TextEditingController textController = TextEditingController();
  TextEditingController textController2 = TextEditingController();
  String errorText = "";
  String time = "";
  String reason = "";
  bool isReason = false;
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<HomePageViewModel>(
      create: (context) => HomePageViewModel(),
      child: Material(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 40,
              ),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "<",
                    style: TextStyle(color: Colors.black, fontSize: 40),
                  )),
              const Padding(
                padding: const EdgeInsets.only(left: 70),
                child: Text(
                  "Çözülen Soru Miktarı",
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      questionNumber = int.parse(value);
                      if (questionNumber > widget.target!) {
                        isReason = false;
                      } else {
                        isReason = true;
                      }
                    });
                  },
                  controller: textController,
                  decoration: InputDecoration(
                      errorText: widget.isError ? errorText : null,
                      hintText: "Çözülen soru miktarını giriniz",
                      hintStyle: const TextStyle(fontSize: 12)),
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(
                        onPressed: () async {
                          date = (await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2022),
                            lastDate: DateTime(2026),
                          ))!;

                          setState(() {
                            time = date.toString().substring(0, 10);
                            print("bu");
                            print(time);
                          });
                        },
                        icon: const Icon(Icons.date_range)),
                    Text(time),
                  ],
                ),
              ),
              isReason
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 40.0),
                      child: TextField(
                        onChanged: (value) {
                          setState(() {
                            reason = value;
                          });
                        },
                        controller: textController2,
                        decoration: const InputDecoration(
                            hintText:
                                "Hedef soru sayısını çözememe nedenini giriniz",
                            hintStyle:
                                TextStyle(fontSize: 11, color: Colors.red)),
                      ),
                    )
                  : const SizedBox(),
              Consumer<HomePageViewModel>(
                builder: (BuildContext context, value, Widget? child) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 250.0),
                    child: FlatButton(
                      color: Colors.green,
                      textColor: Colors.white,
                      child: const Text("Ekle"),
                      onPressed: () {
                        setState(() {
                          if (textController.text == "") {
                            widget.isError = true;
                            errorText = "Lütfen bir sayı giriniz";
                          } else {
                            questionNumber = int.parse(textController.text);
                            value.addResult(
                              result: questionNumber,
                              target: widget.target!,
                              dateTime: date,
                              reason: reason,
                            );

                            Navigator.pop(context);
                          }
                        });
                      },
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}

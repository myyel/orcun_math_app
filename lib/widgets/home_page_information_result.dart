import 'package:flutter/material.dart';

import '../models/target_list_model.dart';

class HomePageInformationResult extends StatelessWidget {
  const HomePageInformationResult({
    Key? key,
    required this.i,
  }) : super(key: key);

  final TargetListModel i;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: Center(
                child: Text(
                  i.date!.substring(8, 10) +
                      "." +
                      i.date!.substring(5, 7) +
                      "." +
                      i.date!.substring(0, 4),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  i.target.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            Expanded(
              child: Center(
                child: Text(
                  i.result.toString(),
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * .02,
        ),
        Container(
          height: MediaQuery.of(context).size.height * .001,
          color: Colors.grey,
        ),
      ],
    );
  }
}

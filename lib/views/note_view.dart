import 'package:flutter/material.dart';
import 'package:my_notes/constants/colors.dart';

class NoteView extends StatelessWidget {
  const NoteView({super.key, required this.date, required this.time, required this.note});
final String date;
final String time;
final String note;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          color: kBackgroundColor,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      date,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: kLightColor,
                      )
                    ),
                    const SizedBox(width: 15,),
                    Text(
                        'at',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[600],
                        )
                    ),
                    const SizedBox(width: 15,),
                    Text(
                        time,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: kLightColor,
                        )
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                Text(
                    note,
                style: const TextStyle(
                  fontSize: 30,
                )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../helper/capitalize.dart';
import '../shared_prefrences.dart';

class NoNotesWidget extends StatelessWidget {
  const NoNotesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'What\'s Up, ${CacheHelper.getString(key: 'firstName')?.capitalize()}!',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            const Text(
              'Your Notes',
              style: TextStyle(
                color: kLightColor,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            const Text(
              'Write Your First Note',
              style: TextStyle(
                fontSize: 30,
                color: kPrimaryColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

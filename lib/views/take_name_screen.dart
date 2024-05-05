import 'package:flutter/material.dart';
import 'package:my_notes/shared_prefrences.dart';
import 'package:my_notes/views/home_screen.dart';
import 'package:my_notes/widgets/material_button.dart';
import 'package:my_notes/widgets/text_form_field.dart';

class TakeNameScreen extends StatefulWidget {
  const TakeNameScreen({super.key});

  @override
  State<TakeNameScreen> createState() => _TakeNameScreenState();
}

class _TakeNameScreenState extends State<TakeNameScreen> {
  final firstNameController = TextEditingController();

  final secondNameController = TextEditingController();

  final imageUrlController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Welcome aboard! Your notes journey begins here.',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  'Enter Your First Name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'First Name',
                  textController: firstNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Your second Name',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'Second Name',
                  textController: secondNameController,
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Enter Your Profile Image Link',
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  hintText: 'photo URL',
                  textController: imageUrlController,
                ),
                const SizedBox(
                  height: 40,
                ),
                CustomMaterialButton(
                  onPressed: () async {
                    if (formKey.currentState!.validate()) {
                      CacheHelper.putString(key: 'firstName', value: firstNameController.text).then((value) => setState(() {}));
                      CacheHelper.putString(key: 'secondName', value: secondNameController.text).then((value) => setState(() {}));
                      CacheHelper.putString(key: 'imageUrl', value: imageUrlController.text).then((value) => setState(() {}));
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HomeScreen(),
                        ),
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}


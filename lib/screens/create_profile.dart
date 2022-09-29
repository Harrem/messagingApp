import 'package:assignment/screens/home.dart';
import 'package:assignment/controller/authentication.dart';
import 'package:assignment/screens/sign_up.dart';
import 'package:assignment/services/cloudStore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final Auth auth = Auth();
  TextEditingController firstNameText = TextEditingController();
  TextEditingController lastNameText = TextEditingController();
  bool? lightTheme;
  double? height;
  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    lightTheme = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: !lightTheme! ? Colors.white : Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: lightTheme!
              ? const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.fromARGB(255, 40, 80, 110),
                      Color.fromARGB(255, 23, 47, 73),
                    ],
                  ),
                )
              : const BoxDecoration(),
          child: Center(
            child: SizedBox(
              height: height,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: ClipOval(
                        child: Container(
                          height: 40,
                          width: 40,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    Text(
                      "Enter Your Name",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    Text(
                      "Fill in to continue",
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    const SizedBox(height: 60),
                    TextFormField(
                      controller: firstNameText,
                      decoration:
                          const InputDecoration(labelText: "FIRST NAME"),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: lastNameText,
                      decoration: const InputDecoration(labelText: "LAST NAME"),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () async {
                        var email = firstNameText.text;
                        var password = lastNameText.text;
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    CreateProfileSecondPage()));
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text("PROCEED"),
                          Icon(Icons.arrow_right_rounded),
                        ],
                      ),
                    ),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        // color: Colors.white,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () {},
                              child: const Text("Help"),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        const SignUp(),
                                  ),
                                );
                              },
                              child: const Text("Sign In"),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CreateProfileSecondPage extends StatelessWidget {
  //form key
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();

  final Auth auth = Auth();
  TextEditingController birthdateController = TextEditingController();
  TextEditingController lastNameText = TextEditingController();
  bool? lightTheme;
  @override
  Widget build(BuildContext context) {
    lightTheme = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: lightTheme!
          ? const BoxDecoration(
              gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 40, 80, 110),
                Color.fromARGB(255, 23, 47, 73),
              ],
            ))
          : const BoxDecoration(),
      child: Scaffold(
        backgroundColor: !lightTheme! ? Colors.white : Colors.transparent,
        body: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 700),
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    height: 40,
                    width: 40,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  "Birthdate and Gender",
                  style: Theme.of(context).textTheme.headline4,
                ),
                Text(
                  "Fill in to continue",
                  style: Theme.of(context).textTheme.subtitle2,
                ),
                const SizedBox(height: 60),
                GestureDetector(
                  onTap: () async {
                    //TODO: use Cupertino Date Picker
                    DateTime? date = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        initialEntryMode: DatePickerEntryMode.input,
                        firstDate: DateTime(1999),
                        lastDate: DateTime.now());
                    if (date != null) {
                      birthdateController.text =
                          DateFormat.yMMMd('en_US').format(date);
                    }
                  },
                  child: TextFormField(
                    enabled: false,
                    controller: birthdateController,
                    decoration: const InputDecoration(
                      labelText: "FIRST NAME",
                      suffixIcon: Icon(Icons.calendar_month_rounded),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                ButtonTheme(
                  alignedDropdown: true,
                  child: DropdownButtonFormField<String>(
                      isExpanded: true,
                      value: "male",
                      decoration: const InputDecoration(
                        isCollapsed: true,
                        labelText: "GENDER",
                      ),
                      items: const [
                        DropdownMenuItem(value: "male", child: Text("Male")),
                        DropdownMenuItem(
                            value: "female", child: Text("FEMALE")),
                        DropdownMenuItem(value: "other", child: Text("OTHER")),
                      ],
                      onChanged: (value) {}),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    var firstName = birthdateController.text;
                    var lastName = lastNameText.text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                CreateProfileSecondPage()));
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("CONTINUE"),
                      Icon(Icons.arrow_right_rounded),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomCenter,
                    // color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextButton(
                          onPressed: () {},
                          child: const Text("Help"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (BuildContext context) =>
                                    const SignUp(),
                              ),
                            );
                          },
                          child: const Text("Sign In"),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
// showCupertinoDialog(
//     context: context,
//     builder: (context) => Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Center(
//               child: Container(
//                 height: 300,
//                 width: 400,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(5),
//                 ),
//                 child: CupertinoDatePicker(
//                   mode: CupertinoDatePickerMode.date,
//                   onDateTimeChanged: (value) {
//                     birthdateController.text =
//                         DateFormat.yMEd().format(value);
//                   },
//                 ),
//               ),
//             ),
//             const Divider(),
//             SizedBox(
//               width: 400,
//               child: ElevatedButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: Text("OK"),
//               ),
//             ),
//           ],
//         ));

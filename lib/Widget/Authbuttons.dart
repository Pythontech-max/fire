import 'package:flutter/material.dart';
class AuthBotton extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function()? ontap;


  AuthBotton({Key? key, required this.title, required this.iconData, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: InkWell(
        onTap: ontap,
        child: Container(
          height: 50,
          decoration: BoxDecoration(
              border: Border.all(color: Colors.grey ),
              borderRadius: BorderRadius.circular(20)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [Icon(iconData) ,SizedBox(width: 10,), Text(title)],
          ),
        ),
      ),
    );
  }
}

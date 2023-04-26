import 'package:flutter/material.dart';
import 'package:fyp/repository/PackageRepository.dart';
import 'package:fyp/widgets/tealButton.dart';

class DeletePackage extends StatefulWidget {
  const DeletePackage({Key? key}) : super(key: key);

  @override
  State<DeletePackage> createState() => _DeletePackageState();
}

class _DeletePackageState extends State<DeletePackage> {
  TextEditingController packageId = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          TextField(
            controller: packageId,
            decoration: InputDecoration(hintText: 'Package Id'),
          ),
          TealButton(
              text: 'Delete',
              onPressed: () {
                PackageRepository p = PackageRepository();
                p.deletePackage(packageId: packageId.text);
              }, bgColor: Colors.red, txtColor: Colors.white,)
        ],
      ),
    ));
  }
}

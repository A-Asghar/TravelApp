import 'package:flutter/material.dart';
import 'package:fyp/repository/PackageRepository.dart';

import '../models/Package.dart';
import 'EditPackage.dart';

class AllPackages extends StatefulWidget {
  const AllPackages({Key? key}) : super(key: key);

  @override
  State<AllPackages> createState() => _AllPackagesState();
}

class _AllPackagesState extends State<AllPackages> {
  Future<List<Package>> getAllPackages() async {
    PackageRepository p = PackageRepository();
    List<Package> packages = await p.getAllPackages();
    return packages;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: FutureBuilder<List<Package>>(
          future: getAllPackages(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: Text(snapshot.data![index].packageName),
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => EditPackage(package: snapshot.data![index],),
                        ));
                      },
                    );
                  });
            } else {
              return CircularProgressIndicator();
            }
          },
        ),
      ),
    );
  }
}

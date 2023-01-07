import '../models/Package.dart';
import '../network/PackageNetwork.dart';

class PackageRepository {
  PackageNetwork network = PackageNetwork();
  addPackage({required Package package}) async {
    network.addPackage(package: package);
  }

  deletePackage({required String packageId}) async {
    network.deletePackage(packageId: packageId);
  }

  getAllPackages() async {
    List<Package> packages = [];
    var response = await network.getAllPackages();
    response.docs.forEach((snapshot) {
      packages.add(Package.fromJson(snapshot.data()));
    });

    return packages;
  }

  updatePackage({required Package package})async{
    await network.updatePackage(package: package);
  }
}

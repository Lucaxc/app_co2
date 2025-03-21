import 'package:firebase_storage/firebase_storage.dart';
import 'package:PtCO2/models/firebase_file.dart';

class FirebaseApi_download {
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) =>
      Future.wait(refs.map((ref) => ref.getDownloadURL()).toList());

  static Future<List<FirebaseFile>> listAll(String path) async {
    try {
      final ref = FirebaseStorage.instance.ref('path');
      final result = await ref.listAll();

      final urls = await _getDownloadLinks(result.items);

      return urls
          .asMap()
          .map((index, url) {
            final ref = result.items[index];
            final name = ref.name;
            final file = FirebaseFile(ref: ref, name: name, url: url);
            return MapEntry(index, file);
          })
          .values
          .toList();
    } on FirebaseException catch (e) {
      return null!;
    }
  }
}

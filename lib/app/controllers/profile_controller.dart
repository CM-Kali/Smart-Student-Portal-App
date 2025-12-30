import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  RxMap<String, dynamic> student = <String, dynamic>{}.obs;
  RxBool loading = false.obs;

  @override
  void onInit() {
    super.onInit();
    fetchProfile();
  }

  /// Fetch profile data
  Future<void> fetchProfile() async {
    String uid = auth.currentUser!.uid;
    DocumentSnapshot doc =
    await firestore.collection('students').doc(uid).get();

    if (doc.exists) {
      student.value = doc.data() as Map<String, dynamic>;
    }
  }

  /// Pick image & upload as Base64
  Future<void> pickAndUploadImage() async {
    final picker = ImagePicker();
    final XFile? image =
    await picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image == null) return;

    loading.value = true;

    File file = File(image.path);
    List<int> bytes = await file.readAsBytes();
    String base64Image = base64Encode(bytes);

    await firestore
        .collection('students')
        .doc(auth.currentUser!.uid)
        .update({
      "profile_pic": base64Image,
    });

    await fetchProfile();
    loading.value = false;
  }
}

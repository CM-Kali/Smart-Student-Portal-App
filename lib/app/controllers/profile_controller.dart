import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
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
    try {
      String uid = auth.currentUser!.uid;
      DocumentSnapshot doc =
      await firestore.collection('students').doc(uid).get();

      if (doc.exists) {
        student.value = doc.data() as Map<String, dynamic>;
      }
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to load profile",
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  /// Pick image & upload as Base64
  Future<void> pickAndUploadImage() async {
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
        source: ImageSource.gallery,
        imageQuality: 50,
      );

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

      Get.snackbar(
        "Success",
        "Profile picture updated successfully!",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to update profile picture",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      loading.value = false;
    }
  }

  /// Logout function
  Future<void> logout() async {
    try {
      await auth.signOut();
      Get.offAllNamed('/login'); // Adjust route based on your app
      Get.snackbar(
        "Logged Out",
        "You have been logged out successfully",
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar(
        "Error",
        "Failed to logout",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
import 'dart:io';

class Contact {
  String? firstName;
  String? phone;
  String? chat;
  File? image;
  File? profileImage;
  String? bio;
  String? profileName;

  Contact({
    required this.firstName,
    required this.phone,
    required this.chat,
    this.image,
    this.bio,
    this.profileImage,
    this.profileName,
  });
}

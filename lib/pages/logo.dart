import 'dart:io';

import 'package:admin_shoe_kart/functions/upload.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Logo extends StatelessWidget {
  const Logo({super.key});

  @override
  Widget build(BuildContext context) {
     UploadFunctions uploadFunctions =UploadFunctions();
    TextEditingController logoNameController = TextEditingController();
    return Container(
      height: 100,
      color: Colors.white,
      width: double.infinity ,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text('Logo'),
          SizedBox(height: 10,),
            Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                     Container(width: 200 ,height: 45   ,
                  child: TextField(
                    controller: logoNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      hintText: 'Enter Logo Name',
                    ),
                  ),
                ),
                OutlinedButton(
                    onPressed: () async {
                      //pick image form firebase
                      ImagePicker imagePicker = ImagePicker();
                      XFile? adsFile = await imagePicker.pickImage(
                          source: ImageSource.gallery);
                      print('${adsFile?.path}');
                      //add selected image to firebase
                      if (adsFile == null) return;
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceAds = referenceRoot.child('logoImges');
                      //reference to store the image
                      String uniqeName =
                          DateTime.now().microsecondsSinceEpoch.toString();
                      Reference uploadImage = referenceAds.child(uniqeName);
                      //store the file
                      try {
                        String id = uniqeName;
                        String logoName = logoNameController.text;
                        await uploadImage.putFile(File(adsFile!.path));
                        String logoImageUrl = await uploadImage.getDownloadURL();
                        print('get Logo ulr');
                        await uploadFunctions.uploadLogoToCloud(
                            logoId: id, logUrl: logoImageUrl, logoName: logoName);
                        print('call upload logo');
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Add Logo')),
                

                  ],
                ),
              
        ],
      ),
    );
  }
}
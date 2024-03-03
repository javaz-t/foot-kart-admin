import 'dart:io';

import 'package:admin_shoe_kart/functions/upload.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Advetaisments extends StatelessWidget {
  const Advetaisments({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> adsImageUrls = [];
    UploadFunctions uploadFunctions =UploadFunctions();
    return Container(
      width: double.infinity,
      height: 100 ,
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Text('Advetaisments'),
            OutlinedButton(
                    onPressed: () async {
                      //pick image form phone
                      ImagePicker imagePicker = ImagePicker();
                    List<XFile?> adsFile = await imagePicker.pickMultiImage();
                      print('${adsFile[0]?.path}');
                      //add selected image to firebase
                      if (adsFile == null) return;
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceAds = referenceRoot.child('adsImges');
                      //reference to store the image
                      String uniqeName =
                          DateTime.now().microsecondsSinceEpoch.toString();
                     // Reference uploadImage = referenceAds.child(uniqeName);
                      //store the file
                      try {
                        for(int x =0;x<adsFile.length;x++){
                          String imagesPath = adsFile[x]!.path.replaceAll('/', '_');
                          Reference uploadImage =referenceAds.child(imagesPath);
                           await uploadImage.putFile(File(adsFile[x]!.path)); 
                           String indivigualAdsImageUrl = await uploadImage.getDownloadURL();
                            adsImageUrls.add(indivigualAdsImageUrl);
                         }
                        await uploadFunctions.uploadAdsToCloud(
                            id: uniqeName, adsUrl: adsImageUrls);
                      } catch (e) {
                        print(e);
                      }
                    },
                    child: const Text('Upload')),
                
        ],
      ),
    );
  }
}
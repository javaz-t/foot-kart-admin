import 'dart:io';
import 'package:admin_shoe_kart/const.dart';
import 'package:admin_shoe_kart/functions/upload.dart';
import 'package:admin_shoe_kart/pages/ads.dart';
import 'package:admin_shoe_kart/pages/logo.dart';
import 'package:admin_shoe_kart/widget/multi_select.dart';
import 'package:admin_shoe_kart/widget/text_fiel.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UploadFunctions uploadFunctions =UploadFunctions();


  //====================================
  late String productDetailsId;
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController discoundController = TextEditingController();
  TextEditingController deliveryChargeController = TextEditingController();
  //=====================list========
  List<String> productImageUrls = [];
  List<String> productcolors = [];
  List<String> proudctSizes = [];
  List<String> proudctCatergory = [];
    
  //==============
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400], 
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [ 
               Advetaisments(), 
               const SizedBox(
                  height: 10,
                ), 
               
                const SizedBox(
                  height: 10,
                ), 
              const Logo(),
               const  SizedBox(height: 10,),
              const Divider(),
                const SizedBox(height: 10,), 
                  CustomTextField(controller: nameController, hintText: 'Enter Product Name',),
                   const SizedBox(height: 20,),
                    CustomTextField(controller: descriptionController, hintText: 'Enter Product Desciption',),                
                   const SizedBox(height: 20,),
                       CustomTextField(controller: priceController, hintText: 'Enter Product Price',),               
                   const SizedBox(height: 20,),
                     CustomTextField(controller: discoundController, hintText: 'Enter Product Discoud',),
                   const SizedBox(height: 20,),
                   CustomTextField(controller: deliveryChargeController, hintText: 'Enter Product Delivary charge',),
                   const SizedBox(height: 20,),
                OutlinedButton(
                    onPressed: () async {
                      ImagePicker imagePicker = ImagePicker();
                      //productFile contains list of selected images from gallery
                      List<XFile?> productFile =
                          await imagePicker.pickMultiImage();
                      //add selected image to firebase
                      if (productFile == null) return;
                      Reference referenceRoot = FirebaseStorage.instance.ref();
                      Reference referenceImg =
                          referenceRoot.child('product_images');
                           productDetailsId = DateTime.now().microsecondsSinceEpoch.toString();
                      Reference listRef = referenceImg.child(productDetailsId);
                      // ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('image selected')));
                      //store the file
                      try {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('indide try')));
                        print('inside try');
                        for (int x = 0; x < productFile.length; x++) {
                          //reference to store the image
                          String imagesPath = productFile[x]!.path.replaceAll('/', '_');
                          Reference uploadImage = listRef.child(imagesPath);
                          await uploadImage.putFile(File(productFile[x]!.path));
                          String indivigualImagesUrl =
                              await uploadImage.getDownloadURL();
                          productImageUrls.add(indivigualImagesUrl);
                          print(productImageUrls);
                        }
                      } catch (e) {
                        print('errror in uplosd fiel');
                      }
                    },
                    child: const Text('Pick Product Images')),
                       const SizedBox(height: 20,), 
                  MultiSelect(optionList: colors, listType: 'Colors',productcolors ),
                  const SizedBox(height: 20,),
                  MultiSelect(optionList: sizes, listType: 'Size',proudctSizes ),
                     const SizedBox(height: 20,),
                  MultiSelect(optionList: category, listType: 'Category',proudctCatergory ),
                     const SizedBox(height: 20,),
                     GestureDetector(
                      onTap:  () async {
                      String productId = productDetailsId;
                      String name = nameController.text;
                      String description = descriptionController.text;
                      double price =double.parse(priceController.text);
                      double discountDouble =double.parse(discoundController.text); 
                      double deliveryCharge =double.parse( deliveryChargeController.text);                       
                      List<String> imageUrl = productImageUrls;
                      List<String> colors = productcolors;
                      List<String> sizes = proudctSizes;
                      List<String> catergory = proudctCatergory;
                      await uploadFunctions.uploadProductDetailsToCloud( 
                          productId: productId,
                          name: name,
                          description: description,
                          price: price,
                          discount: discountDouble ,
                          deliveryCharge: deliveryCharge,
                          imageUrl: imageUrl,
                          colors: colors,
                          sizes: sizes,
                          catergory: catergory);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Uploaded')));
                    },
                       child: Container(
                        height: 60,width: double.infinity,color:Colors.deepPurple ,
                        child: Center(child: Text('Submit',style: TextStyle(color: Colors.white,fontSize: 20 ,fontWeight: FontWeight.bold),)),
                       ),
                     ),
               
              ],
            ),
          ),
        ),
      ),
    );
  }

 



}

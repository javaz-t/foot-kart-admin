import 'package:admin_shoe_kart/model/ads_model.dart';
import 'package:admin_shoe_kart/model/logo_model.dart';
import 'package:admin_shoe_kart/model/shoe_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UploadFunctions {
  uploadProductDetailsToCloud(
      {required String productId,
      required String name,
      required String description,
      required double price,
      required double discount,
      required double deliveryCharge,
      required List<String> imageUrl,
      required List<String> colors,
      required List<String> catergory,
      required List<String> sizes}) async {
    //Reference to document
    final docProductDetails =
        FirebaseFirestore.instance.collection('product_data').doc(productId);
    final productData = ShoeDetailsModel(
        id: productId,
        name: name,
        description: description,
        price: price,
        deliveryCharge: deliveryCharge,
        discount: discount,
        images: imageUrl,
        colors: colors,
        sizes: sizes,
        catergory: ['empty , need to add']);
    final json = productData.toJson();
    await docProductDetails.set(json);
    colors.clear();
    sizes.clear();
    imageUrl.clear();
  }

  uploadLogoToCloud(
      {required String logoId,
      required String logUrl,
      required String logoName}) async {
    //Reference to document
    final docLogo =
        FirebaseFirestore.instance.collection('logoData').doc(logoId);
    print('Uplsd to cloud ');
    final logoData = LogoModel(logoName: logoName, logoUrl: logUrl, id: logoId);
    final json = logoData.toJson();
    await docLogo.set(json);
  }
   uploadAdsToCloud({
    required String id,
    required List<String> adsUrl,
  }) async {
    //Reference to document
    final docAds = FirebaseFirestore.instance.collection('adsImages').doc(id);

    final adsData = AdsModel(
      id: id,
      adUrl: adsUrl,
    );
    final json = adsData.toJson();
    await docAds.set(json);
  }

}

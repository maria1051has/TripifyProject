void _submitPackage() async {
  if (_formKey.currentState!.validate()) {
    if (_packageImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a package image')),
      );
      return;
    }

    try {
      // 🔥 1. UNIQUE IMAGE NAME
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() +
              Random().nextInt(1000).toString();

      // 🔥 2. STORAGE REFERENCE
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('package_images')
          .child('$fileName.jpg');

      // 🔥 3. UPLOAD IMAGE
      await ref.putFile(_packageImage!);

      // 🔥 4. GET IMAGE URL
      String imageUrl = await ref.getDownloadURL();

      // 🔥 5. SAVE DATA IN FIRESTORE
      await FirebaseFirestore.instance.collection('packages').add({
        "name": packageNameController.text,
        "price": priceController.text,
        "day": durationController.text,
        "type": packageType,
        "travelDetails": travelDetailsController.text,
        "foodDetails": foodDetailsController.text,
        "hotelDetails": hotelDetailsController.text,
        "places": placesController.text,
        "itinerary": itineraryController.text,
        "notes": notesController.text,
        "image": imageUrl, // 🔥 IMPORTANT (URL save)
        "createdAt": Timestamp.now(),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Package added successfully!')),
      );

      Navigator.pop(context);

      // 🔄 CLEAR FORM
      packageNameController.clear();
      priceController.clear();
      durationController.clear();
      travelDetailsController.clear();
      foodDetailsController.clear();
      hotelDetailsController.clear();
      placesController.clear();
      itineraryController.clear();
      notesController.clear();

      setState(() {
        _packageImage = null;
        packageType = 'Local';
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
part of 'EditProfileVC.dart';

extension extProfilePic on _EditProfileVC {
  Widget profilePicView() {
    return 
    SizedBox(
      height: 150,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          ((userData?.ProfilePic ?? "").isEmpty) ?
          Center(child: defaultProfilePhoto(height: 120, width: 120)) : 
          Center(
            child: Container(
              height: 120, width: 120,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60)
              ),
              child: Image.network(userData?.ProfilePic ?? "", fit: BoxFit.fill,),
            ),
          ),
      
          MaterialButton(
            elevation: 3,
            padding: const EdgeInsets.all(10),
            shape: const CircleBorder(),
            color: Colors.white,
            onPressed: () async {
              final image = await showSelectPhotoCameraModalView(context);
              if ((image?.path ?? ".") != "."){
                final finalName = "${userData?.FirstName ?? ""}-ValidID-${getDateFromNOW("hhmmssddyyyyMM")}";
                uploadPhoto(finalName, image!);
              }
            },
            child: const Icon(Icons.camera_alt_rounded),
          )
        ],
      ),
    );
  }

  void uploadPhoto(String fileName, XFile xfileImg) async {
    final storageRef = FirebaseStorage.instance.ref("profilepic/$fileName.jpg");
    final metadata = SettableMetadata(
      contentType: 'image/jpeg',
      customMetadata: {'picked-file-path': xfileImg.path},
    );
    try {
      final firebaseUpld = await storageRef.putFile(io.File(xfileImg.path),metadata);
      final imageURL = await firebaseUpld.ref.getDownloadURL();
      updateProfilePic(imageURL);
  
    } on firebase_core.FirebaseException catch (e) {
      return;
    }
  }
}
part of 'AccountVC.dart';

extension extHomeHeaderView on _AccountVC {
  Widget headerTitleView(){
    const style1 = TextStyle(fontSize: 45, color: Colors.white, fontWeight: FontWeight.w700);

    return
    Container(
      height: 130,
      color: gkGetColor(PickClr.tsuperTheme),
      child: 
      const Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: 35),
          Text("Account", style: style1)
        ],
      ),
    );
  }

  Widget accountInfoHeaderView(){
    const style1 = TextStyle(fontSize: 20, fontWeight: FontWeight.w500);
    const style2= TextStyle(fontSize: 15.5, fontWeight: FontWeight.w400, height: 1);
    final fname = userData?.FirstName;
    final lname = userData?.LastName;
    final email = userData?.Email ?? "";
    final phoneNum = userData?.PhoneNumber ?? "";

    return
    GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          createRoute(EditProfileVC())
        ).then((value) {
          setState(() {});
        });
      },
      child: Column(
        children: [
          spacer(10),
          Row(
            children: [
              const SizedBox(width: 25),
              profilePhotoVIEW(),
      
              const SizedBox(width: 15),
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("$fname $lname", style: style1, maxLines: 2, overflow: TextOverflow.ellipsis,),
                  Text(email, style: style2, maxLines: 2, overflow: TextOverflow.ellipsis, ),
                  Text(phoneNum, style: style2, maxLines: 2, overflow: TextOverflow.ellipsis,)
                ],
              ),
              const SizedBox(width: 15),
            ],
          ),
          spacer(10),
          const Divider(),
        ],
      ),
    );
    // Container(
    //   height: 130,
    //   color: gkGetColor(PickClr.tsuperTheme),
    //   child: 
    //   const Row(
    //     mainAxisAlignment: MainAxisAlignment.start,
    //     children: [
    //       SizedBox(width: 35),
    //       Text("Account", style: style1)
    //     ],
    //   ),
    // );
  }

  Widget profilePhotoVIEW() {
    return
    ((userData?.ProfilePic ?? "").isEmpty) ?
    Center(child: defaultProfilePhoto()) : 
    Center(
      child: Container(
        height: 70, width: 70,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60)
        ),
        
        child: 
        Image.network(userData?.ProfilePic ?? "", fit: BoxFit.fill,),
      ),
    );
  }
}
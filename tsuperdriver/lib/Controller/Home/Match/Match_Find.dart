part of 'MatchVC.dart';

extension extFindMatch on _MatchVC {
  Widget findMatchVIEW() {
    const style1 = TextStyle(fontSize: 25, fontWeight: FontWeight.w700, color: Colors.orange);
    const style2 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500);
    const style3 = TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: Colors.orange);

    final fullName = "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}";

    bool isDriver = userData?.MemberType == "Driver" ? true : false;
    return
    Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: gkGetColor(PickClr.gkBGStyle1),
      child: 
      CustomScrollView(
        slivers: <Widget>[
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                spacer(15),
                const Center(child: Text("Find Match", style: style1)),
            
                spacer(25),
                profilePhotoVIEW(),
            
                spacer(2.5),
                Center(child: Text(fullName, style: style2)),
            
                spacer(15),
                Text(isDriver ? "Driver Information" : "Car Information :", style: style3),
                (!isDriver) ?
                carModelVIEW() :
                driverPicturesView(),
            
                spacer(15),
                (isDriver) ? 
                matchDriverFilterVIEW() :
                matchFilterVIEW(),
              ],
            ),
          ),
          
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                spacer(115),
                matchNowBtn(),
                spacer(15)
              ],
            ),
          ),
        ]
      ),
    );
  }

  Widget profilePhotoVIEW() {
    return
    ((userData?.ProfilePic ?? "").isEmpty) ?
    Center(child: defaultProfilePhoto(height: 100, width: 100)) : 
    Center(
      child: Container(
        height: 100, width: 100,
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
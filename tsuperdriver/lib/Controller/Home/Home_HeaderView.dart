part of 'HomeVC.dart';

extension extHomeHeaderView on _HomeVC {
  Widget headerTitleView() {
    const style1 = TextStyle(
        fontSize: 45, color: Colors.white, fontWeight: FontWeight.w700);
    const style2 = TextStyle(
        fontSize: 19, color: Colors.white, fontWeight: FontWeight.w700);

    return Container(
      height: 130,
      color: gkGetColor(PickClr.tsuperTheme),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.5),
            child: Image.asset(AssetStoreImage.tsuperRiderLogo),
          ),
          const SizedBox(width: 15),
          userData?.Status == "ACTIVE" // condition
              ? const Text("Account Confirmation TSUPER", style: style2)
              : const Text("TSUPER", style: style1)
        ],
      ),
    );
  }
}

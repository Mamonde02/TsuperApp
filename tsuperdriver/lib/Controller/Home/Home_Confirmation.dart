part of 'HomeVC.dart';

// 03/09/2025 by monde

extension extHomeConfirmation on _HomeVC {
  Widget homeConfirmation() {
    return Center(
      child: Container(
        // height: 130,
        margin: const EdgeInsetsDirectional.only(bottom: 10),
        padding: const EdgeInsets.all(24),
        color: gkGetColor(PickClr.tsuperTheme),
        child: const Center(
          child: Row(
            children: [
              Icon(
                Icons.warning_amber,
                color: Colors.white,
              ),
              SizedBox(width: 4),
              Text(
                "Please wait for admin to confirm your Account",
                style: TextStyle(
                  fontSize: 19,
                  color: Colors.white,
                  fontWeight: FontWeight.w400,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

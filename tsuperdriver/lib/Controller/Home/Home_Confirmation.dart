part of 'HomeVC.dart';

// 03/09/2025 by monde

extension extHomeConfirmation on _HomeVC {
  Widget homeConfirmationView() {
    return Container(
      padding: const EdgeInsets.all(4),
      height: 200,
      width: 400,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            offset: const Offset(0, -3),
            blurRadius: 3,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Good Day! ${userData?.FirstName} ${userData?.LastName}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 2),
              Icon(
                Icons.person_2_outlined,
                size: 42,
                color: gkGetColor(PickClr.tsuperTheme),
              ),
            ],
          ),
          spacer(12),
          ElevatedButton(
            onPressed: () {
              appLogout(context, mounted);
            },
            style: ElevatedButton.styleFrom(
              padding:
                  const EdgeInsets.symmetric(horizontal: 160, vertical: 20),
              backgroundColor: Colors.orange[400],
              textStyle: const TextStyle(
                fontSize: 16,
                letterSpacing: 0.2,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            child: const Text(
              "Log Out",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  Widget homeConfirmation() {
    return Center(
      child: Column(
        children: [
          spacer(24),
          homeConfirmationView(),
          spacer(24),
          Container(
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
        ],
      ),
    );
  }
}

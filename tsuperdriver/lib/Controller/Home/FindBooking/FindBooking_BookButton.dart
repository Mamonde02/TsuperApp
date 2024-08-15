part of 'FindBooking.dart';

extension extFindBookButton on _FindBooking {
  Widget bookNowButton(int i){
    const style1 = TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500);

    return
    Center(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MaterialButton(
            shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
            color: Colors.red,
            elevation: 2.5,
            onPressed: () {
              cancelSpecialBooking(i);  
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 12),
              child: Text("Decline", style: style1),
            ),
          ),
          
          const SizedBox(width: 20),
          MaterialButton(
            shape:  RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)
                    ),
            color: gkGetColor(PickClr.tsuperTheme),
            elevation: 2.5,
            onPressed: () {
              acceptSpecialBooking(i);
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.5, horizontal: 12),
              child: Text("Accept Now", style: style1),
            ),
          )
        ],
      ),
    );
  }
}
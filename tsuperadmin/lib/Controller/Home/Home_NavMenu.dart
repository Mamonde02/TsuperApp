part of 'HomeVC.dart';

extension extHomeMenuNav on _HomeVC {
  Widget HomeNavigationBar() {
    const style1 = TextStyle(fontSize: 15.5, color: Colors.white);

    return
    Container(
      color: Colors.black87,
      child: 
      Column(
        children: [
          spacer(10),
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 15),
            child: Text("Admin Menu", style: style1),
          ),
          navMenu("Users", (){
            mainGlobal.subDisplayType = "";
            mainGlobal.displayType = "Users";
            refreshState();
          }),
          const Divider(height: 1, color: Colors.white),

          navMenu("Booking", (){
            mainGlobal.subDisplayType = "";
            mainGlobal.displayType = "Booking";
            refreshState();
          }),
          const Divider(height: 1, color: Colors.white),
          
          navMenu("Chat Support", (){
            mainGlobal.subDisplayType = "";
            mainGlobal.displayType = "Chat Support";
            refreshState();
          }),
          const Divider(height: 1, color: Colors.white),
        ],
      ),
    );
  }

  Widget navMenu(String title, void Function() func){
    const style1 = TextStyle(fontSize: 18, color: Colors.white);

    return
    TextButton(
      style:  ButtonStyle(
                shape: MaterialStateProperty.all(const RoundedRectangleBorder( borderRadius: BorderRadius.zero)),
                fixedSize: MaterialStateProperty.all(const Size(200, 50)),
                backgroundColor: MaterialStateProperty.resolveWith<Color>(
                  (Set<MaterialState> states) {
                    if (title == mainGlobal.displayType) {return Colors.blue;}
                    if (states.contains(MaterialState.hovered))  {return Colors.blue;}
                    return Colors.black87;
                  }
                ),
              ),
      onPressed: func, 
      child: Text(title, style: style1)
    );
  }
}
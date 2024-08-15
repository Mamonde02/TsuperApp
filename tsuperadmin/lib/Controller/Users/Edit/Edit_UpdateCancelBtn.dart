part of 'Edit.dart';

extension extUpdateCancelBtn on _EditVC {
  Widget updateCancelRowButton(){
    return
    SizedBox(
      height: 50,
      child: Row(
        children: [
          const SizedBox(width: 15),
          Expanded(
            child: MaterialButton(
              color: gkGetColor(PickClr.gkBtnColor),
              onPressed: (){
                updateUser(widget.acc);
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Update", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            )
          ),

          const SizedBox(width: 10),
          Expanded(
            child: MaterialButton(
              color: Colors.red,
              onPressed: (){
                selectedMemberType = "";
                Navigator.of(context).pop("NO");
              },
              child: const Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: Text("Cancel", style: TextStyle(fontSize: 17, color: Colors.white, fontWeight: FontWeight.w500)),
              ),
            )
          ),
          const SizedBox(width: 15),
        ],
      ),
    );
  }
}
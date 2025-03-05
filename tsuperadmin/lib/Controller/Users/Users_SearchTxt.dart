part of 'UsersVC.dart';

extension extSearchTxt on _UsersVC {
  Widget searchTxtView() {
    return SizedBox(
      width: 300,
      child: TextField(
        cursorColor: Colors.black,
        textAlign: TextAlign.start,
        controller: searchTxtController, // based
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.only(top: 12, bottom: 11, left: 25, right: 10),
          filled: true,
          fillColor: Colors.white,
          hintStyle: TextStyle(fontSize: 15, color: Colors.grey[400]),
          hintText: "Search eg: Name, Member Type",
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent),
          ),
        ),
        // onChanged: (value){
        //   if (value.isEmpty){
        //     displayedUsersData = allUsersData;
        //   }else{
        //     displayedUsersData =  allUsersData.where((e) {
        //                             final fullName = "${e.FirstName.toLowerCase()} ${e.LastName.toLowerCase()}";
        //                             final memberType = e.MemberType.toLowerCase() == "carowner" ? "Car Owner" : e.MemberType;
        //                             return
        //                             fullName.contains(value.toLowerCase()) ||
        //                             memberType.toLowerCase().contains(value.toLowerCase());
        //                           }).toList();
        //   }

        //   refreshState();
        // },
        onChanged: (value) => {
          if (value.isEmpty)
            {
              // Display the all data when search text is empty
              print("Data is empty SearchText"),
              filteredUsers = allUsersData
            }
          else
            {
              filterUsers(),
            }
        },
      ),
    );
  }
}

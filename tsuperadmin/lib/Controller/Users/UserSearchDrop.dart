part of 'UsersVC.dart';

extension extSearchDrop on _UsersVC {
  // User STATUS Dropdown
  Widget searchDropStatusUI() {
    return Container(
      padding: const EdgeInsets.only(left: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(2.5),
      ),
      child: DropdownButton(
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(3),
        underline: const SizedBox.shrink(),
        // isExpanded: true,
        hint: Text(
          "Choose User Status",
          style: TextStyle(
              fontWeight: FontWeight.w500,
              color: Colors.grey[400],
              fontSize: 15),
        ),
        elevation: 2,
        value: selectedMemberStatus == "" ? null : selectedMemberStatus,

        // value: selectedMemberType == "" ? null : selectedMemberType,

        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),

        // Array list of items
        items: listOfMemberStatus.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(
              items,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
              ),
            ),
          );
        }).toList(),

        // onChanged: (value) {
        //   selectedMemberStatus = value!;
        //   if (value.isEmpty) {
        //     displayedUsersData = allUsersData;
        //   } else {
        //     displayedUsersData = allUsersData.where((e) {
        //       final fullName =
        //           "${e.FirstName.toLowerCase()} ${e.LastName.toLowerCase()}";
        //       final memberType = e.MemberType.toLowerCase() == "carowner"
        //           ? "Car Owner"
        //           : e.MemberType;
        //       final memberStatus = e.Status.toLowerCase();

        //       return fullName.contains(value.toLowerCase()) ||
        //           memberType.toLowerCase().contains(value.toLowerCase()) ||
        //           memberStatus.toLowerCase().contains(value.toLowerCase());
        //     }).toList();
        //   }

        //   refreshState();
        // },
        onChanged: (String? newValue) {
          setState(() {
            selectedMemberStatus = newValue ?? "";
            filterUsers();
          });
        },
      ),
    );
  }
}

          // setState(() {
          //   selectedMemberStatus = value!;
          //   // amountListOfRegular();

          //   displayedUsersData = allUsersData.where(
          //     (e) {
          //       // final fullName =
          //       //     "${e.FirstName.toLowerCase()} ${e.LastName.toLowerCase()}";
          //       final memberType = e.Status.contains(value);
                
          //       return memberType;
          //     },
          //   ).toList();
          // });
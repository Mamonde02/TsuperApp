part of 'UsersVC.dart';

extension extSearchDrop on _UsersVC {
  Widget searchDropStatusUI() {
    return Container(
      // padding: const EdgeInsets.only(left: 15),
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
          "Choose user Status...",
          style:
              TextStyle(fontWeight: FontWeight.w500, color: Colors.grey[400]),
        ),
        elevation: 2,
        value: selectedMemberStatus == "" ? null : selectedMemberStatus,

        // Down Arrow Icon
        icon: Icon(Icons.arrow_drop_down, size: 35, color: Colors.grey[600]!),

        // Array list of items
        items: listOfMemberStatus.map((String items) {
          return DropdownMenuItem(
            value: items,
            child: Text(items,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          );
        }).toList(),

        onChanged: (value) {
          setState(() {
            selectedMemberStatus = value!;
            // amountListOfRegular();

            displayedUsersData = allUsersData.where(
              (e) {
                // final fullName =
                //     "${e.FirstName.toLowerCase()} ${e.LastName.toLowerCase()}";
                final memberType = e.Status.contains(value);
                
                return memberType;
              },
            ).toList();
          });
        },
      ),
    );
  }
}

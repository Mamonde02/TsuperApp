part of 'UsersVC.dart';

extension extUsersListView on _UsersVC {
  Widget usersListVIEW() {
    return Expanded(
      child: columnHeaderView(),
    );
  }

  Widget columnHeaderView() {
    const style1 = TextStyle(
        fontSize: 15, color: Colors.black87, fontWeight: FontWeight.w700);
    final style2 = TextStyle(
        fontSize: 15,
        color: gkGetColor(PickClr.tsuperTheme),
        fontWeight: FontWeight.w700);

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: DataTable(
          columns: [
            const DataColumn(label: Text('ID', style: style1)),
            const DataColumn(label: Text('First Name', style: style1)),
            const DataColumn(label: Text('Last Name', style: style1)),
            const DataColumn(label: Text('Email', style: style1)),
            // const DataColumn(label: Text('Current Address', style: style1)),
            const DataColumn(label: Text('Member Type', style: style1)),
            const DataColumn(label: Text('Status', style: style1)),
            DataColumn(label: Text('Action', style: style2)),
          ],
          rows: List.generate(displayedUsersData.length, (i) {
            return DataRow(cells: [
              DataCell(Text(displayedUsersData[i].ID.toString())),
              DataCell(Text(displayedUsersData[i].FirstName.toString())),
              DataCell(Text(displayedUsersData[i].LastName.toString())),
              DataCell(Text(displayedUsersData[i].Email.toString())),
              // DataCell(Text(displayedUsersData[i].CurrentAddress.toString())),
              DataCell(Text(displayedUsersData[i].MemberType.toString())),
              DataCell(formatStatusVIEW(displayedUsersData[i].Status.toString())),
              DataCell(Row(
                children: [
                  InkWell(
                    onTap: () {
                      showEditConfirm(displayedUsersData[i]);
                    },
                    child: Icon(
                      Icons.person,
                      color: gkGetColor(PickClr.tsuperTheme),
                    ),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {
                      showEditProfileModal(displayedUsersData[i]);
                    },
                    child: const Icon(Icons.edit, color: Colors.blue),
                  ),
                  const SizedBox(width: 7),
                  InkWell(
                    onTap: () {
                      showConfirmationPromptModal(
                          "Are you sure you want to delete this user?",
                          displayedUsersData[i]);
                    },
                    child: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  )
                ],
              )),
            ]);
          }).toList(),
        ),
      ),
    );
  }

  Future<Object?> showEditProfileModal(UserAccountDataModel acc) {
    return showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return EditVC(acc: acc);
        }).then(
      (value) => {
        if (value == "YES") {fetchAllUsers()}
      },
    );
  }

 
  Widget formatStatusVIEW(String status){
    switch (status) {
      case "PENDING":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: gkGetColor(PickClr.gkBtnColor),
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      case "Confirm":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Colors.green,
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      case "ACTIVE":
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: Colors.red,
          child: Text(status, style: const TextStyle(color: Colors.white))
        );
      default:
        return
        Container(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          color: gkGetColor(PickClr.gkBtnColor),
          child: Text(status, style: TextStyle(color: Colors.white))
        );
    }
  }
}

part of 'FindingMatchLoading.dart';

extension extAPIRelateMatch on ShowFindMatchLoading { 
  void stopFindMatch(BuildContext context, String transmission, String carModel) async {
    final params = {
      "userID": userData?.ID.toString(),
      "transmission": transmission,
      "currentLocation": currentAddress,
      "carModel": carModel
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/stopFindMatch", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"];

    if (status == "000"){
      
      if (!context.mounted) return;
      Navigator.of(context).pop(null);
    }else{
      if (!context.mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void getMatchUser(BuildContext context) async {
    final params = {
      "userID": userData?.ID.toString(),
      "type": userData?.MemberType
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/getMatchUser", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"];

    if (status == "000"){
      final jsonData = (data as List).map((e) => GetMatchDataModel.fromMap(e)).toList();
      if (jsonData.isEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        if (!context.mounted) return;
        getMatchUser(context);
        return;
      }
      matchedDetail = jsonData[0];

      if (!context.mounted) return;
      Navigator.of(context).pop(matchedDetail);
    }else{
      if (!context.mounted) return;
      showPromptModal(context, "error", message);
    }
  }
  
  void startDriverFindMatch(BuildContext context) async {
    final params = {
      "carModel": carModel,
      "transmission": transmission
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/startDriverFindMatch", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();
    final data = jsonDecoded["data"];

    if (status == "000"){
      final jsonData = (data as List).map((e) => GetMatchQueueDataModel.fromMap(e)).toList();
      if (jsonData.isEmpty) {
        await Future.delayed(const Duration(seconds: 3));
        if (!context.mounted) return;
        startDriverFindMatch(context);
        return;
      }

      final newMap = jsonData.map((e) {
        final loc = e.CurrentLocation.split(":::");
        final lat1 = double.parse(loc[1]);
        final long1 = double.parse(loc[2]);

        final loc2 = currentAddress.split(":::");
        final lat2 = double.parse(loc2[1]);
        final long2 = double.parse(loc2[2]);

        final getDistance = Geolocator.distanceBetween(lat1, long1, lat2, long2);
        var item = e;
        item.distance = getDistance;
        return item;
      }).toList();
      newMap.sort((a, b) {
        var adistance = a.distance;
        var bdistance = b.distance;
        return adistance.compareTo(bdistance);
      });

      if (newMap.isNotEmpty) {
        if (newMap[0].distance <= 1000) {
          if (!context.mounted) return;
          matchFound(context, newMap[0]);
        } else {
          await Future.delayed(const Duration(seconds: 3));
          if (!context.mounted) return;
          startDriverFindMatch(context);
          return;
        }
      }

    }else{
      if (!context.mounted) return;
      showPromptModal(context, "error", message);
    }
  }

  void matchFound(BuildContext context, GetMatchQueueDataModel client) async {
    final fullName = "${userData?.FirstName ?? ""} ${userData?.LastName ?? ""}";
    final params = {
      "driverID": userData?.ID.toString(),
      "driverName": fullName,
      "userID": client.ClientID,
      "userName": client.ClientName,
      "carModel": client.CarModel,
      "transmission": client.Transmission,
      "currentLocation": client.CurrentLocation
    };

    RepoClass repoClass = RepoClass();
    Map<String,dynamic> jsonDecoded = await repoClass.didStart_CallAPI("api/matchFound", {}, params);

    final status = jsonDecoded["status"].toString();
    final message = jsonDecoded["message"].toString();

    if (status == "000"){
      final match = GetMatchDataModel(
        1, userData?.ID ?? 0, fullName, client.ClientID, 
        client.ClientName, "PENDING"
      );

      if (!context.mounted) return;
      showPromptModal(context, "success", "Found Match Successfully!")
      .then((value) => {
        Navigator.of(context).pop(match)
      });
    }else{
      if (!context.mounted) return;
      showPromptModal(context, "error", message);
    }
  }
}
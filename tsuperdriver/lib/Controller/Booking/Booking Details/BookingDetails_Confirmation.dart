part of 'BookingDetails.dart';

extension extBookingConfirmation on _BookingDetails {
  Widget bookingConfirmationVIEW(){
    return
    Container(
      decoration: BoxDecoration(
                    color: Colors.white,
                    boxShadow: bothBoxShadowV1
                  ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          spacer(5),
          widget.isRequestingBook ?
          paymentAmountMethod() :
          bookingInfoVIEW(),

          spacer(10),
          confirmBtn(),
          spacer(20),
        ]
      ),
    );
  }

  Widget bookingInfoVIEW(){
    const style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
    const style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    const style3 = TextStyle(fontSize: 12, fontWeight: FontWeight.w300, height: 1);

    final serviceType = widget.confirmationData["TypeService"];
    final multiPlier = serviceType == "RoundTrip" ? 2 : 1;
    totalAmount = (10 + ((distance/300) * 10))* multiPlier;

    return
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text("Total Amount", style: style1),

                Text("Php ${convertCurrencyNoSymbol(totalAmount)}", 
                style: style2),

                spacer(10),
                Column(
                  children: [
                    const Text("Total Distance : "),
                    Text("${((distance / 1000) * multiPlier).toStringAsFixed(2)} km")
                  ],
                ),
              ],
            ),
          ),

          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey[300]!))
              ),
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Service Type", style: style1),
                  spacer(5),
                  Text(serviceType, style: style2)
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget paymentAmountMethod(){
    const style1 = TextStyle(fontSize: 15, fontWeight: FontWeight.w400);
    const style2 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    return
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Total Amount", style: style1),
                  spacer(5),
                  Text("Php ${convertCurrencyNoSymbol(totalAmount)}", 
                  style: style2)
                ],
              ),
            ),
          ),
    
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(left: BorderSide(color: Colors.grey[300]!))
              ),
              padding: const EdgeInsets.symmetric(vertical: 25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text("Payment Method", style: style1),
                  spacer(5),
                  paymentMethodVIEW()
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget confirmBtn(){
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700, color: Colors.white);

    return
    Container(
      margin: const EdgeInsets.only(left: 32, right: 32),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    color: gkGetColor(PickClr.tsuperTheme),
                    boxShadow: bothBoxShadowV1
                  ),
      child: MaterialButton(
        color: gkGetColor(PickClr.tsuperTheme),
        elevation: 0,
        onPressed: (){
          if (!widget.isRequestingBook){
            startShowLoadingView();
            if (specialDriverBook == null) { 
              insertBooking();
            }else {
              specialBooking();
            }
          }else{

          }
        },
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 12.5),
          child: Text("Confirm Booking", style: style1),
        ),
      ),
    );
  }

  Widget paymentMethodVIEW(){
    const style1 = TextStyle(fontSize: 17, fontWeight: FontWeight.w700);
    if (paymentMethod == "Cash"){
      return 
      GestureDetector(
        onTap: (){
          showPaymentMethodModal();
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              pesoPaymentIcon(),
              const SizedBox(width: 5),
              const Text("Cash", style: style1),
        
              const Icon(Icons.arrow_drop_down, size: 25,)
            ],
          ),
        ),
      );
    }else{
      return
      GestureDetector(
        onTap: (){
          showPaymentMethodModal();
        },
        child: Container(
          color: Colors.transparent,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              eCashPaymentIcon(),
              const SizedBox(width: 5),
              const Text("eCash", style: style1),
        
              const Icon(Icons.arrow_drop_down, size: 25,)
            ],
          ),
        ),
      );
    }
  }
}
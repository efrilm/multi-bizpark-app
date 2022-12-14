import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multibizpark/models/lead_model.dart';
import 'package:multibizpark/pages/utilities/tracking_page.dart';
import 'package:multibizpark/services/api.dart';
import 'package:multibizpark/thema.dart';
import 'package:multibizpark/widgets/button_custom.dart';
import 'package:multibizpark/widgets/information_date_card.dart';
import 'package:multibizpark/widgets/information_fee_card.dart';
import 'package:multibizpark/widgets/information_home_card.dart';
import 'package:multibizpark/widgets/information_lead_card.dart';
import 'package:multibizpark/widgets/information_payment_card.dart';
import 'package:multibizpark/widgets/information_user_card.dart';
import 'package:multibizpark/widgets/loading.dart';
import 'package:multibizpark/widgets/note_card.dart';
import 'package:http/http.dart' as http;

class MDetailSoldPage extends StatefulWidget {
  final Lead model;
  MDetailSoldPage(this.model);
  @override
  _MDetailSoldPageState createState() => _MDetailSoldPageState();
}

class _MDetailSoldPageState extends State<MDetailSoldPage> {
  var isLoading = false;
  String? salesName;
  String? markomName;
  getSales() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getUser + widget.model.salesId));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        salesName = data['data']['user_name'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  getMarkom() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getUser + widget.model.markomId));
    final data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
        markomName = data['data']['user_name'];
        print(data);
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String? dateAdd;
  String? dateFollowUp;
  String? dateWillVisit;
  String? dateAlreadyVisit;
  String? dateReservation;
  String? dateBooking;
  String? dateSold;

  final price = NumberFormat("#,##0", "en_us");

  getDate() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getDate + widget.model.leadId));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        dateAdd = data[0]['date_add'];
        dateFollowUp = data[0]['date_follow_up'];
        dateWillVisit = data[0]['date_will_visit'];
        dateAlreadyVisit = data[0]['date_already_visit'];
        dateReservation = data[0]['date_reservation'];
        dateBooking = data[0]['date_booking'];
        dateSold = data[0]['date_sold'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String? feeReservation;
  String? feeBooking;
  String? total;

  getFee() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getFee + widget.model.leadId));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        feeReservation = data['fee_reservation'];
        feeBooking = data['fee_booking'];
        total = data['total'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  String? discountPrice;
  String? downpayment;
  String? discountDownpayment;
  String? downpaymentPaid;
  String? subtotal;

  getPayment() async {
    setState(() {
      isLoading = true;
    });
    final response =
        await http.get(Uri.parse(AppUrl.getPayment + widget.model.leadId));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        isLoading = false;
        discountPrice = data[0]['discount_price'];
        downpayment = data[0]['downpayment'];
        discountDownpayment = data[0]['discount_downpayment'];
        downpaymentPaid = data[0]['downpayment_paid'];
        subtotal = data[0]['subtotal'];
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSales();
    getMarkom();
    getDate();
    getFee();
    getPayment();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          widget.model.fullName,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
      );
    }

    Widget button() {
      return Container(
        margin: EdgeInsets.only(
          top: 40,
          left: hMargin,
          right: hMargin,
        ),
        child: CustomButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => TrackingPage(widget.model.leadId)));
          },
          text: "Tracking",
        ),
      );
    }

    return Scaffold(
      appBar: header(),
      body: isLoading
          ? Loading()
          : ListView(
              children: [
                InformationLeadCard(
                  name: widget.model.fullName,
                  noWhatsapp: widget.model.noWhatsapp,
                  source: widget.model.source,
                  date: widget.model.updateDate,
                ),
                NoteCard(
                  text: widget.model.note,
                ),
                InformationHomeCard(
                  noHome: widget.model.noHome!,
                  typeHome: widget.model.typeHome!,
                  typePayment: widget.model.paymentMethod!,
                ),
                InformationFeeCard(
                  feeReservation: feeReservation == null
                      ? 'N/A'
                      : price.format(int.parse(feeReservation!)),
                  feeBooking: feeBooking == null
                      ? 'N/A'
                      : price.format(int.parse(feeBooking!)),
                  total:
                      total == null ? 'N/A' : price.format(int.parse(total!)),
                ),
                InformationPaymentCard(
                  price: price.format(int.parse(widget.model.priceHome!)),
                  discountPrice: discountPrice == null
                      ? 'N/A'
                      : price.format(int.parse(discountPrice!)),
                  downpayment: downpayment == null
                      ? 'N/A'
                      : price.format(int.parse(downpayment!)),
                  discountDownpayment: discountDownpayment == null
                      ? 'N/A'
                      : price.format(int.parse(discountDownpayment!)),
                  downpaymentPaid: downpaymentPaid == null
                      ? 'N/A'
                      : price.format(int.parse(downpaymentPaid!)),
                  subtotal: subtotal == null
                      ? 'N/A'
                      : price.format(int.parse(subtotal!)),
                ),
                InformationUserCard(
                  salesName: salesName == null ? 'N/A' : salesName!,
                  markomName: markomName == null ? 'N/A' : markomName!,
                ),
                InformationDateCard(
                  dateAdd: dateAdd == null ? 'N/A' : dateAdd!,
                  dateFollowUp: dateFollowUp == null ? 'N/A' : dateFollowUp!,
                  dateWillVisited:
                      dateWillVisit == null ? 'N/A' : dateWillVisit!,
                  dateAlreadyVisited:
                      dateAlreadyVisit == null ? 'N/A' : dateAlreadyVisit!,
                  dateReservation:
                      dateReservation == null ? 'N/A' : dateReservation!,
                  dateBooking: dateBooking == null ? 'N/A' : dateBooking!,
                  dateSold: dateSold == null ? 'N/A' : dateSold!,
                ),
                button(),
                SizedBox(height: 100),
              ],
            ),
    );
  }
}

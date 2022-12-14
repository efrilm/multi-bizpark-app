import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multibizpark/models/lead_model.dart';
import 'package:multibizpark/pages/utilities/tracking_page.dart';
import 'package:multibizpark/services/api.dart';
import 'package:multibizpark/thema.dart';
import 'package:multibizpark/widgets/button_custom.dart';
import 'package:multibizpark/widgets/information_lead_card.dart';
import 'package:multibizpark/widgets/information_user_card.dart';
import 'package:multibizpark/widgets/loading.dart';
import 'package:multibizpark/widgets/note_card.dart';

class ODetailNewLeadPage extends StatefulWidget {
  final Lead model;
  ODetailNewLeadPage(this.model);
  @override
  _ODetailNewLeadPageState createState() => _ODetailNewLeadPageState();
}

class _ODetailNewLeadPageState extends State<ODetailNewLeadPage> {
  var salesSelection;
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getSales();
    getMarkom();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        backgroundColor: kWhiteColor,
        elevation: 1,
        title: Text(
          widget.model.fullName,
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
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
        child: Column(
          children: [
            CustomButton(
              onPressed: () {
                Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TrackingPage(widget.model.leadId)));
              },
              text: "Tracking",
            ),
          ],
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
                  date: widget.model.salesId,
                ),
                NoteCard(
                  text: widget.model.note,
                ),
                InformationUserCard(
                  salesName: salesName == null ? 'N/A' : salesName!,
                  markomName: markomName == null ? 'N/A' : markomName!,
                ),
                button(),
                SizedBox(
                  height: 100,
                ),
              ],
            ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:multibizpark/const.dart';
import 'package:multibizpark/models/lead_model.dart';
import 'package:multibizpark/pages/owner/utils_lead/detail_new_lead_page.dart';
import 'package:multibizpark/services/api.dart';
import 'package:multibizpark/thema.dart';
import 'package:multibizpark/widgets/data_not_found.dart';
import 'package:multibizpark/widgets/lead_card.dart';
import 'package:multibizpark/widgets/loading.dart';

class OFollowUpPage extends StatefulWidget {
  const OFollowUpPage({Key? key}) : super(key: key);

  @override
  _OFollowUpPageState createState() => _OFollowUpPageState();
}

class _OFollowUpPageState extends State<OFollowUpPage> {
  var isLoading = false;
  var isData = false;
  String status = '2';
  List<Lead> list = [];

  Future<void> getLead() async {
    setState(() {
      isLoading = true;
    });
    list.clear();
    final response = await http.get(
      Uri.parse(AppUrl.leadO +
          '?status=' +
          status +
          '&project_code=' +
          AppCode.project),
    );
    if (response.statusCode == 200) {
      if (response.contentLength == 2) {
        setState(() {
          isLoading = false;
          isData = false;
        });
      } else {
        final data = jsonDecode(response.body);
        setState(() {
          for (Map i in data) {
            list.add(Lead.fromJson(i));
          }
          isLoading = false;
          isData = true;
        });
      }
    } else {
      setState(() {
        isLoading = false;
        isData = false;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getLead();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: getLead,
        child: isLoading
            ? Loading()
            : isData
                ? ListView.builder(
                    padding: EdgeInsets.only(
                      left: hMargin,
                      right: hMargin,
                      bottom: 80,
                    ),
                    itemCount: list.length,
                    itemBuilder: (context, i) {
                      final l = list[i];
                      return LeadCard(
                        name: l.fullName,
                        date: l.updateDate,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  ODetailNewLeadPage(l),
                            ),
                          );
                        },
                      );
                    },
                  )
                : DataNotFound(),
      ),
    );
  }
}
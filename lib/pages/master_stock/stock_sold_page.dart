import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:multibizpark/const.dart';
import 'package:multibizpark/models/home_mode.dart';
import 'package:multibizpark/services/api.dart';
import 'package:multibizpark/thema.dart';
import 'package:multibizpark/widgets/data_not_found.dart';
import 'package:multibizpark/widgets/loading.dart';
import 'package:multibizpark/widgets/unit_card.dart';
import 'package:http/http.dart' as http;

class StockSoldPage extends StatefulWidget {
  const StockSoldPage({Key? key}) : super(key: key);

  @override
  _StockSoldPageState createState() => _StockSoldPageState();
}

class _StockSoldPageState extends State<StockSoldPage> {
  bool isLoading = false;
  bool isData = false;

  List<Home> list = [];

  String status = '4';

  getSold() async {
    setState(() {
      isLoading = true;
    });
    final response = await http.get(Uri.parse(AppUrl.home +
        '?status=' +
        status +
        '&project_code=' +
        AppCode.project));

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
            list.add(Home.fromJson(i));
          }
          isLoading = false;
          isData = true;
          print(data);
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
    getSold();
  }

  @override
  Widget build(BuildContext context) {
    AppBar header() {
      return AppBar(
        centerTitle: true,
        title: Text(
          "Tersedia",
          style: primaryTextStyle.copyWith(
            fontSize: 16,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.chevron_left,
            color: kPrimaryColor,
          ),
        ),
        backgroundColor: kWhiteColor,
        elevation: 1,
      );
    }

    return Scaffold(
      appBar: header(),
      body: isLoading
          ? Loading()
          : isData
              ? ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: hMargin,
                  ),
                  shrinkWrap: true,
                  physics: ClampingScrollPhysics(),
                  itemCount: list.length,
                  itemBuilder: (context, i) {
                    final l = list[i];
                    return UnitCard(
                      unit: l.noHome,
                      typeUnit: l.typeHome,
                      onName: false,
                    );
                  })
              : DataNotFound(),
    );
  }
}

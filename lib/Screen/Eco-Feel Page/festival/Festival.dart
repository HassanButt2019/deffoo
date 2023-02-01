import 'package:deffo/Screen/Payment/festivals_book_now.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:flutter/material.dart';

class FestivalDetailPage extends StatefulWidget {
  final fes;
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final imagePath;
  const FestivalDetailPage(
      {Key? key,
      this.fes,
      this.type,
      this.startDate,
      this.endDate,
      this.memberNumber,this.imagePath})
      : super(key: key);

  @override
  _FestivalDetailPageState createState() => _FestivalDetailPageState();
}

class _FestivalDetailPageState extends State<FestivalDetailPage> {
  var demo = "";

  var titleFont = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => FestivalBooking(
                          bookData: widget.fes,
                          type: widget.type,
                          startDate: widget.startDate,
                          endDate: widget.endDate,
                          memberNumber: widget.memberNumber,
                        )));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Book Now"),
            ],
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
                title: Text("Festivals"),
                background: Image.network(
                  widget.imagePath,
                  fit: BoxFit.cover,
                )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            ListTile(
              title: Text(
                "${widget.fes.activityName}",
                maxLines: 1,
              ),
              subtitle: Text("${widget.fes.contactNo}\n${widget.fes.emailId}"),
              trailing: Text("₹ ${widget.fes.rentPerPerson}/person"),
            ),
            ListTile(
                title: Text("Address"),
                subtitle: Text("${widget.fes.address}")),
            FutureBuilder(
                future: getFestivalDays(widget.fes.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data.data;
                    return data.isNotEmpty
                        ? Column(
                            children: [
                              ListTile(
                                title: Text(
                                  "Days",
                                  style: titleFont,
                                ),
                              ),
                              Wrap(
                                spacing: 5,
                                children: data
                                    .asMap()
                                    .entries
                                    .map<Widget>((e) => InkWell(
                                        onTap: () {
                                          setState(() {
                                            demo = e.value.dayDetail;
                                          });
                                        },
                                        child: Chip(
                                            label: Text("Day ${e.key + 1}"
                                                .toUpperCase()))))
                                    .toList(),
                              ),
                              demo.isNotEmpty
                                  ? ListTile(
                                      title: Text("Details", style: titleFont),
                                      subtitle: Text(
                                        "$demo",
                                        style: TextStyle(fontSize: 16),
                                        textAlign: TextAlign.justify,
                                      ),
                                    )
                                  : Container(),
                            ],
                          )
                        : Container();
                  } else if (snapshot.hasError) {
                    return Icon(Icons.error_outline);
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Brief Overview",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.fes.briefOverview}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Things Carry",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.fes.thingsCarry}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Inclusions",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.fes.inclusion}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Exclusion",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.fes.exclusion}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Terms And Conditions",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.fes.termCondition}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
          ])),
        ],
      ),
    );
  }
}

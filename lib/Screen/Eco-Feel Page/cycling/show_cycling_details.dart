import 'package:deffo/Screen/Payment/cycles_book_now.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:flutter/material.dart';

class ShowCyclingDetails extends StatefulWidget {
  final cycle;
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final imagePath;

  const ShowCyclingDetails({Key? key, this.cycle, this.type, this.startDate, this.endDate, this.memberNumber,this.imagePath}) : super(key: key);

  @override
  _ShowCyclingDetailsState createState() => _ShowCyclingDetailsState();
}

class _ShowCyclingDetailsState extends State<ShowCyclingDetails> {
  List brand = ["yamaha", "suzuki", "harley", "hero"];
  var demo =
      "";

  var titleFont = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  var selectBrand;

  var price;
  var bikeId;
  var bikeName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet:
      selectBrand!=null?
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=> CycleBooking(
              bookData: widget.cycle,
              price: price,
              bikeId: bikeId,
              bikeName: bikeName,
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
      ):Text(""),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 250,
            flexibleSpace: FlexibleSpaceBar(
                title: Text("Cycling"),
                background: Image.network(
                 widget.imagePath.toString(),
                  fit: BoxFit.cover,
                )),
          ),
          SliverList(
              delegate: SliverChildListDelegate([
            ListTile(
              title: Text("${widget.cycle.activityName}"),
              subtitle:
                  Text("${widget.cycle.contactNo}\n${widget.cycle.emailId}"),
            ),
            ListTile(
                title: Text("Address"),
                subtitle: Text("${widget.cycle.address}")),
            FutureBuilder(
                future: getCycleBrands(widget.cycle.id),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    List data = snapshot.data.data;
                    return Column(
                      children: [
                        ListTile(
                          title: Text(
                            "Brands Available",
                            style: titleFont,
                          ),
                        ),
                        Column(
                          children: data
                              .asMap()
                              .entries
                              .map<Widget>((e) => Card(
                                      child: Column(
                                    children: [
                                      ListTile(
                                        onTap: (){
                                        setState(() {
                                          demo = e.value.details;
                                          selectBrand = e.key;
                                          bikeId = e.value.id;
                                          bikeName = e.value.brandName;
                                          price = e.value.rate;
                                          print(price);
                                        });
                                        },
                                        title: Text(
                                          "${e.value.brandName}".toUpperCase(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                          ),
                                        ),
                                        subtitle: Text(
                                            "₹${e.value.rate} / ${e.value.type}"),
                                        trailing: Radio(value: e.key, groupValue: selectBrand, onChanged: (value){
                                          setState(() {
                                              selectBrand = value!;
                                              demo = e.value.details;
                                          });
                                        }),
                                      ),
                                    ],
                                  )))
                              .toList(),
                        ),
                        demo.isNotEmpty?
                        ListTile(
                          title: Text("Bike Details", style: titleFont),
                          subtitle: Text(
                            "$demo",
                            style: TextStyle(fontSize: 16),
                            textAlign: TextAlign.justify,
                          ),
                        ):Container(),
                      ],
                    );
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
                "${widget.cycle.briefOverview}",
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
                "${widget.cycle.inclusion}",
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            ),
            Divider(
              height: 25,
            ),
            ListTile(
              title: Text(
                "Exclusions",
                style: titleFont,
              ),
              subtitle: Text(
                "${widget.cycle.exclusion}",
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
                "${widget.cycle.termCondition}",
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

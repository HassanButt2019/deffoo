import 'package:deffo/Screen/Payment/tour_book_now.dart';
import 'package:flutter/material.dart';

class TourDetailsPage extends StatefulWidget {
  final fes;
  final type;
  final startDate;
  final endDate;
  final memberNumber;
  final imagePath;
  const TourDetailsPage(
      {Key? key,
      this.fes,
      this.type,
      this.startDate,
      this.endDate,
      this.memberNumber,this.imagePath})
      : super(key: key);

  @override
  _TourDetailsPageState createState() => _TourDetailsPageState();
}

class _TourDetailsPageState extends State<TourDetailsPage> {
  var titleFont = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: () {
            if (widget.type != null &&
                widget.startDate.toString().isNotEmpty &&
                widget.endDate.toString().isNotEmpty &&
                widget.memberNumber.isNotEmpty) {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => TourBooking(
                            bookData: widget.fes,
                            type: widget.type,
                            startDate: widget.startDate,
                            endDate: widget.endDate,
                            memberNumber: widget.memberNumber,
                          )));
            }
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
                title: Text("Tours"),
                background: Image.network(
                  widget.imagePath.toString(),
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
              trailing: Text("₹ ${widget.fes.ratePerPerson}/person"),
            ),
            ListTile(
                title: Text("Address"),
                subtitle: Text("${widget.fes.address}")),
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
            // ListTile(title: Text("Inclusions" , style:  titleFont,), subtitle: Text("${widget.fes.inclusion}" , style: TextStyle(fontSize: 16 ), textAlign: TextAlign.justify,),),
            // Divider(height: 25,),
            // ListTile(title: Text("Exclusion" , style:  titleFont,), subtitle: Text("${widget.fes.exclusion}" , style: TextStyle(fontSize: 16 ), textAlign: TextAlign.justify,),),
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

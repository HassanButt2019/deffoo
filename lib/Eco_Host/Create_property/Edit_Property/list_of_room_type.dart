import 'package:deffo/Eco_Host/Auth/config.dart';
import 'package:deffo/Eco_Host/Create_property/Edit_Property/edit_room_type.dart';
import 'package:deffo/Eco_Host/main_list_propertis.dart';
import 'package:deffo/api/multipart/update_profile.dart';
import 'package:flutter/material.dart';

class ListOfRoomTypePage extends StatefulWidget {
  final propertyData;
  final index;
  final checkEdit;

  const ListOfRoomTypePage({Key? key, this.propertyData, this.index, this.checkEdit})
      : super(key: key);

  @override
  _ListOfRoomTypePageState createState() => _ListOfRoomTypePageState();
}

enum Option { edit, delete }

class _ListOfRoomTypePageState extends State<ListOfRoomTypePage> {

  final snackBar = SnackBar(
    content: const Text('Room will be lost ?'),
    action: SnackBarAction(
      label: 'Sure',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );
  bool room = false;
  @override
  Widget build(BuildContext context) {

    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        widget.propertyData!=null?Container(
          height: MediaQuery.of(context).size.height * .82,
          child: FutureBuilder(
              future: getRoomByPropertyId(widget.propertyData.id),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  return
                    snapshot.data.data.isNotEmpty?
                    ListView.builder(
                      itemCount: snapshot.data.data.length,
                      itemBuilder: (BuildContext context, int index) {
                        var data = snapshot.data.data[index];
                        var path = snapshot.data.path;
                        room = true;
                        return
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: ListTile(
                                      title: Text(
                                        "${data.roomTypeName}",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                          "No of Rooms : ${data.noOfRoom}"),
                                      trailing: Text(
                                          "₹ ${data.rentRoom}\nper person"),
                                    ),
                                  ),
                                  popMenu(data, path)
                                ],
                              ),
                              Divider()
                            ],
                          );
                      },
                    ): Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/not_available/no_property.png" , scale: 2,),
                            Text("No Room Available")
                          ],
                        ),
                      ],
                    );
                } else if (snapshot.hasError) {
                  return Icon(Icons.error_outline);
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }),
        ):SizedBox(),
        Column(
          children: [
            IconButton(
              onPressed: () async {
                var data = await Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditRoomTypePage(
                          edit: false,
                          propertiesDetails: widget.propertyData != null
                              ? widget.propertyData
                              : null,
                          index: widget.index,
                        )));
                print(data);
                if(data == true){
                  setState(() {

                  });
                }
              },
              icon: Icon(Icons.add),
            ),
            IconButton(
              onPressed: () async {
                if(!room){
                  setSnackbar("Please Add Room", context);
                  return;
                }
                Navigator.pop(context);

              },
              icon: Icon(Icons.arrow_forward_ios_rounded),
            ),
          ],
        )
      ],
    );
  }

  Widget popMenu(roomDetails, imagePath) {
    return PopupMenuButton<Option>(
      onSelected: (Option result) async {
        if (result == Option.edit) {
         var data = await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => EditRoomTypePage(
                        propertiesDetails: roomDetails,
                        imagePath: imagePath,
                        edit: true,
                      )));
         if(data == true){
           setState(() {

           });
         }
        } else if (result == Option.delete) {
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<Option>>[
        const PopupMenuItem<Option>(
          value: Option.edit,
          child: Text('Edit'),
        ),
        const PopupMenuItem<Option>(
          value: Option.delete,
          child: Text('Delete'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:test_flutter_aos/Model/Member.dart';

class EntryForm extends StatefulWidget {
  Member member;
  bool edit;

  EntryForm({this.member, this.edit});

  @override
  _EntryFormState createState() => _EntryFormState();
}

class _EntryFormState extends State<EntryForm> {
  TextEditingController nameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  var image, imageProfile;
  final picker = ImagePicker();

  DateTime selectedDate = DateTime.now();
  Position position;
  String alamat;

  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) selectedDate = picked;
    dateController.text = DateFormat.yMMMd().format(selectedDate).toString();
  }

  Future getImage() async {
    image = await ImagePicker.pickImage(source: ImageSource.gallery);
    print("file Image : $image");
    setState(() {
      imageProfile = image.path;
      if (image.path != null) {
        Navigator.pop(context);
      }
    });
  }

  Future getImageCamera() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      imageProfile = image.path;
      if (image.path != null) {
        Navigator.pop(context);
      }
    });
  }

  _getAddressFromLatLng() async {
    try {
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);

      Placemark place = p[0];

      setState(() {
        alamat =
        "${place.locality}, ${place.postalCode}, ${place.country}";
      });
    } catch (e) {
      print(e);
    }
  }


  @override
  void initState() {
    super.initState();
    if (widget.member != null) {
      nameController.text = widget.member.name;
      phoneController.text = widget.member.phone;
      dateController.text = widget.member.birthDate;
      alamat = widget.member.address;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.member == null ? Text('Tambah') : Text('Rubah'),
        ),
        body: Padding(
          padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
          child: ListView(
            children: <Widget>[
              Stack(children: <Widget>[
                Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                        radius: 50,
                        backgroundImage: imageProfile == null
                            ? AssetImage(
                                widget.member == null || widget.member.image == null
                                    ? 'assets/foto_profil.png'
                                    : widget.member.image,
                              )
                            : AssetImage(imageProfile))),
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 70, top: 70),
                    child: InkWell(
                        onTap: () {
                          selectImageDialog(context);
                        },
                        child: Icon(Icons.camera_alt)),
                  ),
                ),
              ]),
              // nama
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: nameController,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: 'Nama Lengkap',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: InputDecoration(
                    labelText: 'Telepon',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: TextField(
                  onTap: () {
                    _selectDate(context);
                  },
                  controller: dateController,
                  keyboardType: TextInputType.datetime,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Lahir',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              RaisedButton(
                padding: EdgeInsets.only(top: 20, bottom: 20),
                onPressed: () async {
                  Position getPos = await geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
                  print(getPos);
                  setState(() {
                    position = getPos;
                  });
                  _getAddressFromLatLng();
                },
                child: Center(
                  child: Text("Get Lokasi"),
                ),
              ),
              Center(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    position == null && alamat == null ? "" : alamat
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Save',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          if (widget.member == null) {
                            widget.member = Member(
                                nameController.text,
                                phoneController.text,
                                dateController.text,
                                imageProfile,
                                alamat);
                          } else {
                            widget.member.name = nameController.text;
                            widget.member.phone = phoneController.text;
                            widget.member.birthDate = dateController.text;
                            widget.member.image = imageProfile == null ? widget.member.image : imageProfile;
                            widget.member.address = alamat == null ? widget.member.address : alamat;
                          }
                          Navigator.pop(context, widget.member);
                        },
                      ),
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      child: RaisedButton(
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          'Cancel',
                          textScaleFactor: 1.5,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  void selectImageDialog(BuildContext cntx) {
    showDialog(
        context: cntx,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              // width: 300.0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text("Pilih Foto Profil"),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 16, right: 16, bottom: 10),
                    child: InkWell(
                      onTap: (){
                        getImageCamera();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text(
                                "Camera",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 16, right: 16, bottom: 10),
                    child: InkWell(
                      onTap: (){
                        getImage();
                      },
                      child: Container(
                        margin: EdgeInsets.only(left: 10, right: 10),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10)),
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                              child: Text(
                                "Gallery",
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 5, left: 10, right: 10, bottom: 10),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(10)),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Text(
                              "Batal",
                              textAlign: TextAlign.center,
                              style: TextStyle(color: Colors.red),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

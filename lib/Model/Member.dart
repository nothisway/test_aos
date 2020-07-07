class Member {
  int _id;
  String _name;
  String _phone;
  String _birthDate;
  String _image;
  String _address;
  Member(this._name, this._phone, this._birthDate, this._image, this._address);
  Member.fromMap(Map<String, dynamic> map) {
    this._id = map['id'];
    this._name = map['name'];
    this._phone = map['phone'];
    this._birthDate = map['birthDate'];
    this._image = map['image'];
    this._address = map['address'];
  }

  int get id => _id;
  String get name => _name;
  String get phone => _phone;
  String get birthDate => _birthDate;
  String get image => _image;
  String get address => _address;

  set name(String value) {
    _name = value;
  }
  set phone(String value) {
    _phone = value;
  }
  set birthDate(String value) {
    _birthDate = value;
  }
  set image(String value) {
    _image = value;
  }
  set address(String value) {
    _address = value;
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['id'] = this._id;
    map['name'] = name;
    map['phone'] = phone;
    map['birthDate'] = birthDate;
    map['image'] = image;
    map['address'] = address;
    return map;
  }
}
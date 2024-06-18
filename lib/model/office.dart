class Office {
  String? id;
  int? createdAt;
  String? ofcName;
  int? pinCode;
  String? taluka;
  String? district;
  String? state;
  int? teleNo;
  String? ofcType;
  String? delivStat;
  String? headOfc;
  String? division;
  String? region;
  String? circle;
  bool isLike;

  Office(
      {this.id,
      this.createdAt,
      this.ofcName,
      this.pinCode,
      this.taluka,
      this.district,
      this.state,
      this.teleNo,
      this.ofcType,
      this.delivStat,
      this.headOfc,
      this.division,
      this.region,
      this.circle,
      required this.isLike});

  Map<String, dynamic> toMap() {
    return {
      'id': this.id,
      'createdAt': this.createdAt,
      'ofcName': this.ofcName,
      'pinCode': this.pinCode,
      'taluk': this.taluka,
      'destrict': this.district,
      'state': this.state,
      'teleNo': this.teleNo,
      'ofcType': this.ofcType,
      'delivStat': this.delivStat,
      'headOfc': this.headOfc,
      'division': this.division,
      'region': this.region,
      'circle': this.circle,
      'isLike': this.isLike,
    };
  }

  factory Office.fromMap(Map<dynamic, dynamic> map) {
    return Office(
      id: map['id'] as String,
      createdAt: map['createdAt'] as int,
      ofcName: map['ofcName'] as String,
      pinCode: map['pinCode'] as int,
      taluka: map['taluk'] as String,
      district: map['destrict'] as String,
      state: map['state'] as String,
      teleNo: map['teleNo'] as int,
      ofcType: map['ofcType'] as String,
      delivStat: map['delivStat'] as String,
      headOfc: map['headOfc'] as String,
      division: map['division'] as String,
      region: map['region'] as String,
      circle: map['circle'] as String,
      isLike: map['isLike'] as bool,
    );
  }
}

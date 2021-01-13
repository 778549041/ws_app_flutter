class ThirdLoginModel {
  ThirdLoginData data;
  ThirdLoginModel() : data = ThirdLoginData();

  ThirdLoginModel.fromJson(Map<String, dynamic> json) {
    data = json['data'] != null
        ? new ThirdLoginData.fromJson(json['data'])
        : ThirdLoginData();
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class ThirdLoginData {
  String binding;
  bool wxUsed;
  bool isVehicle;
  String memberId;
  String msg;

  ThirdLoginData(
      {this.binding = '',
      this.wxUsed = false,
      this.isVehicle = false,
      this.memberId = '',
      this.msg = ''});

  ThirdLoginData.fromJson(Map<String, dynamic> json) {
    binding = json['binding'] ?? '';
    wxUsed = json['wx_used'] ?? false;
    isVehicle = json['is_vehicle'] ?? false;
    memberId = json['member_id'] ?? '';
    msg = json['msg'] ?? '';
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['binding'] = this.binding;
    data['wx_used'] = this.wxUsed;
    data['is_vehicle'] = this.isVehicle;
    data['member_id'] = this.memberId;
    data['msg'] = this.msg;
    return data;
  }
}

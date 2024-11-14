class BankModel {
  final int id;
  final int idUser;
  final String rekening;
  final String bank;

  BankModel({
    required this.id,
    required this.idUser,
    required this.rekening,
    required this.bank,
  });

  factory BankModel.fromJson(Map<String, dynamic> json) {
    return BankModel(
      id: json['id'],
      idUser: json['id_user'],
      rekening: json['rekening'],
      bank: json['bank'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'id_user': idUser,
      'rekening': rekening,
      'bank': bank,
    };
  }
}

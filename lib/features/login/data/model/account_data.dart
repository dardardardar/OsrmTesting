import 'package:floor/floor.dart';
import 'package:osrmtesting/features/login/domain/entities/account_data.dart';

@Entity(tableName: 'account_data', primaryKeys: ['id'])
class AccountDataModel extends AccountDataEntity {
  const AccountDataModel({
    required super.id,
    required super.name,
    required super.phoneNumber,
    required super.email,
  });

  factory AccountDataModel.fromJson(data) {
    return AccountDataModel(
      id: data['id'],
      name: data['display_name'] ?? '-',
      phoneNumber: data['phone'] ?? '-',
      email: data['email'] ?? '-',
    );
  }
  factory AccountDataModel.formEntity(AccountDataEntity e) {
    return AccountDataModel(
      id: e.id,
      name: e.name,
      email: e.email,
      phoneNumber: e.phoneNumber,
    );
  }
}

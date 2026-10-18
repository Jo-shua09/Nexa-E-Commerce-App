import 'package:flutter_riverpod/legacy.dart';

class DeliveryAddress {
  final String id;
  final String nickname;
  final String fullAddress;
  final bool isDefault;

  const DeliveryAddress({
    required this.id,
    required this.nickname,
    required this.fullAddress,
    this.isDefault = false,
  });

  DeliveryAddress copyWith({
    String? id,
    String? nickname,
    String? fullAddress,
    bool? isDefault,
  }) {
    return DeliveryAddress(
      id: id ?? this.id,
      nickname: nickname ?? this.nickname,
      fullAddress: fullAddress ?? this.fullAddress,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class AddressNotifier extends StateNotifier<List<DeliveryAddress>> {
  AddressNotifier()
    : super(const [
        DeliveryAddress(
          id: '1',
          nickname: 'Home',
          fullAddress: '925 S Chugach St #APT 10, Alaska 99645',
          isDefault: true,
        ),
        DeliveryAddress(
          id: '2',
          nickname: 'Office',
          fullAddress: '2438 6th Ave, Ketchikan, Alaska 99901',
        ),
        DeliveryAddress(
          id: '3',
          nickname: 'Apartment',
          fullAddress: '2551 Vista Dr #B301, Juneau, Alaska 99801',
        ),
        DeliveryAddress(
          id: '4',
          nickname: "Parent's House",
          fullAddress: '4821 Ridge Top Cir, Anchorage, Alaska 99508',
        ),
      ]);

  void addAddress(DeliveryAddress newAddress) {
    final updatedAddresses = [...state];

    if (newAddress.isDefault) {
      for (var i = 0; i < updatedAddresses.length; i++) {
        updatedAddresses[i] = updatedAddresses[i].copyWith(isDefault: false);
      }
    }

    state = [...updatedAddresses, newAddress];
  }
}

final addressListProvider =
    StateNotifierProvider<AddressNotifier, List<DeliveryAddress>>((ref) {
      return AddressNotifier();
    });

final selectedAddressIdProvider = StateProvider<String>((ref) => '1');

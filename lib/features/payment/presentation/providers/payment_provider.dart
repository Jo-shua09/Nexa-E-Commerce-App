import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class PaymentCardModel {
  final String id;
  final String brand;
  final String last4;
  final bool isDefault;

  const PaymentCardModel({
    required this.id,
    required this.brand,
    required this.last4,
    this.isDefault = false,
  });

  PaymentCardModel copyWith({bool? isDefault}) {
    return PaymentCardModel(
      id: id,
      brand: brand,
      last4: last4,
      isDefault: isDefault ?? this.isDefault,
    );
  }
}

class PaymentNotifier extends Notifier<List<PaymentCardModel>> {
  @override
  List<PaymentCardModel> build() {
    return [
      const PaymentCardModel(
        id: '1',
        brand: 'VISA',
        last4: '2512',
        isDefault: true,
      ),
      const PaymentCardModel(id: '2', brand: 'Mastercard', last4: '5421'),
      const PaymentCardModel(
        id: '3',
        brand: 'VISA',
        last4: '2512',
      ), // Second Visa as shown in design
    ];
  }

  void addCard(PaymentCardModel card) {
    state = [...state, card];
  }
}

final paymentListProvider =
    NotifierProvider<PaymentNotifier, List<PaymentCardModel>>(
      PaymentNotifier.new,
    );

final selectedPaymentIdProvider = StateProvider<String>((ref) => '1');

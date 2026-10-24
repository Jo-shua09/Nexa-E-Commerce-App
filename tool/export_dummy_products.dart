import 'dart:convert';
import 'dart:io';

import 'package:nexa/features/products/data/sources/dummy_products.dart';

Future<void> main(List<String> arguments) async {
  if (arguments.length != 1) {
    stderr.writeln(
      'Usage: dart run tool/export_dummy_products.dart <output-json-path>',
    );
    exitCode = 64;
    return;
  }

  final output = File(arguments.single);
  await output.parent.create(recursive: true);
  final products = dummyProducts
      .map((product) => {'id': product.id, ...product.toMap()})
      .toList();
  await output.writeAsString(
    const JsonEncoder.withIndent('  ').convert(products),
  );
  stdout.writeln('Exported ${products.length} products to ${output.path}.');
}

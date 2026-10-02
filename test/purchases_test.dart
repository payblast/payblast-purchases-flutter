import 'package:payblast_purchases/purchases.dart';
import 'package:test/test.dart';

void main() {
  test('customer info and paywall lookup keys', () async {
    final purchases = Purchases(
      'http://127.0.0.1:4000',
      PayblastHttp(
        getJson: (path, apiKey) async {
          expect(apiKey, 'pk_test');
          if (path.endsWith('/offerings')) {
            return {
              'packages': [
                {'lookup_key': 'monthly'}
              ]
            };
          }
          return {
            'entitlements': {
              'pro': {'is_active': true}
            }
          };
        },
        postJson: (path, apiKey, body) async => body,
      ),
    );
    purchases.configure('pk_test', 'user-1');
    final offerings = await purchases.getOfferings();
    expect(offerings['packages'][0]['lookup_key'], 'monthly');
    final info = await purchases.getCustomerInfo();
    expect(info['entitlements']['pro']['is_active'], isTrue);
    final rendered = purchases.presentPaywall({'blocks': []}, [
      Package('monthly', {'ios': 'pro_monthly'}),
      Package('annual', {'ios': 'pro_annual'}),
    ]);
    expect(rendered, contains('monthly'));
    expect(rendered, contains('annual'));
  });
}

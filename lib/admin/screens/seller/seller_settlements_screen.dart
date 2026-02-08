import 'package:flutter/material.dart';

class SellerSettlementsScreen extends StatelessWidget {
  const SellerSettlementsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Mock data for demonstration
    final mockSettlements = [
      {
        'period': 'Jan 1 - Jan 15, 2026',
        'totalSales': 5420.00,
        'commission': 270.00,
        'netPayout': 5150.00,
        'status': 'Paid',
        'paidDate': 'Jan 18, 2026',
      },
      {
        'period': 'Jan 16 - Jan 31, 2026',
        'totalSales': 6800.00,
        'commission': 340.00,
        'netPayout': 6460.00,
        'status': 'Pending',
        'paidDate': null,
      },
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settlements & Payouts',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Summary Cards
          Row(
            children: [
              Expanded(
                child: Card(
                  color: Colors.green.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.account_balance_wallet,
                            color: Colors.green.shade700, size: 32),
                        const SizedBox(height: 12),
                        Text(
                          'Total Earnings',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$11,610.00',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Card(
                  color: Colors.orange.shade50,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(Icons.pending_actions,
                            color: Colors.orange.shade700, size: 32),
                        const SizedBox(height: 12),
                        Text(
                          'Pending Payout',
                          style: TextStyle(color: Colors.grey.shade600),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '\$6,460.00',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.orange.shade700,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 32),

          // Settlement History
          Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settlement History',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: mockSettlements.length,
                    separatorBuilder: (context, index) => const Divider(height: 32),
                    itemBuilder: (context, index) {
                      final settlement = mockSettlements[index];
                      final isPaid = settlement['status'] == 'Paid';

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                settlement['period'] as String,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isPaid
                                      ? Colors.green.shade100
                                      : Colors.orange.shade100,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  settlement['status'] as String,
                                  style: TextStyle(
                                    color: isPaid
                                        ? Colors.green.shade700
                                        : Colors.orange.shade700,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Expanded(
                                child: _buildSettlementRow(
                                  'Total Sales',
                                  '\$${(settlement['totalSales'] as double).toStringAsFixed(2)}',
                                ),
                              ),
                              Expanded(
                                child: _buildSettlementRow(
                                  'Commission (5%)',
                                  '-\$${(settlement['commission'] as double).toStringAsFixed(2)}',
                                  isNegative: true,
                                ),
                              ),
                              Expanded(
                                child: _buildSettlementRow(
                                  'Net Payout',
                                  '\$${(settlement['netPayout'] as double).toStringAsFixed(2)}',
                                  isBold: true,
                                ),
                              ),
                            ],
                          ),
                          if (settlement['paidDate'] != null) ...[
                            const SizedBox(height: 8),
                            Text(
                              'Paid on ${settlement['paidDate']}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Commission Info
          Card(
            color: Colors.blue.shade50,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.info_outline, color: Colors.blue.shade700),
                      const SizedBox(width: 8),
                      const Text(
                        'Commission Information',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Commission rates vary by category (3% - 25%). Settlements are processed bi-weekly on the 15th and last day of each month. Funds are transferred within 2-3 business days.',
                    style: TextStyle(color: Colors.grey.shade700),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettlementRow(String label, String value,
      {bool isNegative = false, bool isBold = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            color: isNegative ? Colors.red.shade700 : Colors.black,
          ),
        ),
      ],
    );
  }
}

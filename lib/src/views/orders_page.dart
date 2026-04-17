import 'package:flutter/material.dart';

class OrdersPage extends StatelessWidget {
  final bool isDarkMode;

  const OrdersPage({super.key, required this.isDarkMode});

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color bgColor = isDark ? const Color(0xFF0D0E17) : const Color(0xFFF5F7F9);
    final Color cardColor = isDark ? const Color(0xFF1F202D) : Colors.white;

    // Enhanced mock data with product details
    final List<Map<String, dynamic>> orders = [
      {
        'id': 'BK142157',
        'date': '16 April 2026, 12:30 PM',
        'amount': '693',
        'status': 'Arriving',
        'timer': '14:39',
        'items': [
          {'name': 'Aashirvaad Atta', 'qty': 2, 'price': 275},
          {'name': 'Farm Fresh Eggs', 'qty': 2, 'price': 58},
        ],
      },
      {
        'id': 'BK9821123',
        'date': '15 April 2026, 08:15 AM',
        'amount': '120',
        'status': 'Delivered',
        'timer': null,
        'items': [
          {'name': 'Lays Classic', 'qty': 3, 'price': 20},
          {'name': 'Kurkure Masala', 'qty': 4, 'price': 15},
        ],
      },
    ];

    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(
        backgroundColor: const Color(0xFF2D7A3E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'My Orders',
          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
      body: orders.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_bag_outlined, size: 80, color: Colors.grey.withOpacity(0.5)),
                  const SizedBox(height: 16),
                  const Text('No orders yet', style: TextStyle(color: Colors.grey, fontSize: 18)),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 24),
                  decoration: BoxDecoration(
                    color: cardColor,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Card Header (Green for active/success)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                        decoration: BoxDecoration(
                          color: order['status'] == 'Arriving' ? const Color(0xFF2D7A3E) : Colors.grey.withOpacity(0.1),
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(24),
                            topRight: Radius.circular(24),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Order #${order['id']}',
                                  style: TextStyle(
                                    color: order['status'] == 'Arriving' ? Colors.white : (isDark ? Colors.white70 : Colors.black87),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  order['date'],
                                  style: TextStyle(
                                    color: order['status'] == 'Arriving' ? Colors.white.withOpacity(0.8) : Colors.grey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                              decoration: BoxDecoration(
                                color: order['status'] == 'Arriving' ? Colors.white24 : Colors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                order['status'],
                                style: TextStyle(
                                  color: order['status'] == 'Arriving' ? Colors.white : Colors.green,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            if (order['timer'] != null) ...[
                              Center(
                                child: Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                                  decoration: BoxDecoration(
                                    color: Colors.orange.withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: Colors.orange.withOpacity(0.3)),
                                  ),
                                  child: Column(
                                    children: [
                                      const Text('Arriving in', style: TextStyle(fontSize: 10, color: Colors.orange, fontWeight: FontWeight.bold)),
                                      Text(
                                        order['timer'],
                                        style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                            ],
                            
                            Text(
                              'Order Summary',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                color: isDark ? Colors.white : Colors.black,
                                letterSpacing: 0.5,
                              ),
                            ),
                            const SizedBox(height: 16),
                            ... (order['items'] as List).map((item) => Padding(
                              padding: const EdgeInsets.only(bottom: 12),
                              child: Row(
                                children: [
                                  Text('${item['qty']}x ', style: const TextStyle(color: Colors.grey, fontSize: 13)),
                                  Expanded(
                                    child: Text(
                                      item['name'],
                                      style: TextStyle(
                                        color: isDark ? Colors.white70 : Colors.black87,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  Text(
                                    '₹${item['price']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 13,
                                      color: isDark ? Colors.white : Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                            )),
                            const Divider(height: 32),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Total Amount', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                                Text(
                                  '₹${order['amount']}',
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w900,
                                    color: Color(0xFF2D7A3E),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}

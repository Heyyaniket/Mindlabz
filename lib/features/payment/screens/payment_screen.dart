import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/payment/screens/order_success_screen.dart'; // <--- NEW IMPORT

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  bool _saveCard = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppPallete.backgroundColor,

      // --- APP BAR ---
      appBar: AppBar(
        backgroundColor: AppPallete.backgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Checkout',
          style: GoogleFonts.playfairDisplay(
            color: AppPallete.black,
            fontSize: 28,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
          ),
        ),
        centerTitle: true,
        // --- PROGRESS TABS ---
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: Container(
            padding: const EdgeInsets.only(bottom: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildProgressTab('SHIPPING'),
                _buildProgressTab('PAYMENT', isActive: true),
                _buildProgressTab('REVIEW'),
              ],
            ),
          ),
        ),
      ),

      // --- BODY ---
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // 1. HEADER
            Text(
              'Payment Method',
              style: GoogleFonts.playfairDisplay(
                fontSize: 32,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 30),

            // 2. EXPRESS CHECKOUT BUTTONS
            Text(
              'EXPRESS CHECKOUT',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade400,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 15),

            // UPI Button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                color: Colors.white,
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.payment, color: Colors.grey),
                    const SizedBox(width: 5),
                    Text("UPI", style: GoogleFonts.inter(fontWeight: FontWeight.w700, fontStyle: FontStyle.italic)),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Apple Pay Button
            Container(
              width: double.infinity,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade200),
                color: Colors.white,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.apple, color: Colors.black, size: 24),
                  const SizedBox(width: 5),
                  Text(
                    'Pay',
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),

            // 3. DIVIDER
            Row(
              children: [
                const Expanded(child: Divider(color: Color(0xFFE0E0E0), thickness: 1)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Text(
                    'PAY WITH CARD',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade400,
                      letterSpacing: 1.0,
                    ),
                  ),
                ),
                const Expanded(child: Divider(color: Color(0xFFE0E0E0), thickness: 1)),
              ],
            ),

            const SizedBox(height: 30),

            // 4. CARD DETAILS FORM
            Text(
              'CARD DETAILS',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: Colors.grey.shade600,
                letterSpacing: 1.0,
              ),
            ),
            const SizedBox(height: 10),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: const Color(0xFFC9A761)), // Gold Border
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      const Icon(Icons.credit_card, color: Color(0xFFC9A761)),
                      const SizedBox(width: 15),
                      Expanded(
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: '0000 0000 0000 0000',
                            hintStyle: GoogleFonts.inter(color: Colors.grey.shade300, fontSize: 18, letterSpacing: 2.0),
                            border: InputBorder.none,
                          ),
                          keyboardType: TextInputType.number,
                        ),
                      ),
                      Container(width: 30, height: 20, color: Colors.grey.shade100),
                      const SizedBox(width: 5),
                      Container(width: 30, height: 20, color: Colors.grey.shade100),
                    ],
                  ),
                  const Divider(color: Color(0xFFE0E0E0)),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('EXPIRY', style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade400)),
                            TextField(
                              decoration: InputDecoration(
                                hintText: 'MM/YY',
                                hintStyle: GoogleFonts.inter(color: Colors.grey.shade300),
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(width: 1, height: 40, color: const Color(0xFFE0E0E0)),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('CVV', style: GoogleFonts.inter(fontSize: 10, color: Colors.grey.shade400)),
                            TextField(
                              obscureText: true,
                              decoration: InputDecoration(
                                hintText: '***',
                                hintStyle: GoogleFonts.inter(color: Colors.grey.shade300, letterSpacing: 4.0),
                                border: InputBorder.none,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. SAVE CARD CHECKBOX
            Row(
              children: [
                SizedBox(
                  height: 24,
                  width: 24,
                  child: Checkbox(
                    value: _saveCard,
                    activeColor: const Color(0xFFC9A761),
                    onChanged: (val) => setState(() => _saveCard = val!),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'Save card for future purchases',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.black,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const Divider(color: Color(0xFFE0E0E0)),
            const SizedBox(height: 20),

            // 6. BILLING ADDRESS
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Billing Address',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                Text(
                  'EDIT',
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFC9A761),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 15),
            Text(
              'Name\nAddress Address Address\nAddress Address',
              style: GoogleFonts.inter(
                fontSize: 13,
                color: Colors.grey.shade600,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 40),

            // 7. TOTAL & PAY BUTTON
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'TOTAL AMOUNT',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: Colors.grey.shade600,
                  ),
                ),
                Text(
                  '\$ 1,000',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 24,
                    fontWeight: FontWeight.w600,
                    color: AppPallete.black,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () {
                  // --- NAVIGATE TO ORDER SUCCESS ---
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const OrderSuccessScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppPallete.black,
                  foregroundColor: AppPallete.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  elevation: 0,
                ),
                child: Text(
                  'PAY',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 15),
            Center(
              child: Text(
                'ENCRYPTED & SECURE CHECKOUT',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  color: Colors.grey.shade400,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressTab(String title, {bool isActive = false}) {
    return Text(
      title,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w700,
        color: isActive ? AppPallete.black : Colors.grey.shade300,
        letterSpacing: 1.0,
      ),
    );
  }
}
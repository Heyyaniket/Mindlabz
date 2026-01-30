import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindlabz/core/theme/app_pallete.dart';
import 'package:mindlabz/features/checkout/widgets/checkout_text_field.dart';
import 'package:mindlabz/features/payment/screens/payment_screen.dart'; // <--- NEW IMPORT

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  bool _billingSameAsShipping = false;

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
                _buildProgressTab('SHIPPING', isActive: true),
                _buildProgressTab('PAYMENT'),
                _buildProgressTab('REVIEW'),
              ],
            ),
          ),
        ),
      ),

      // --- BODY ---
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // 1. EXPRESS CHECKOUT
                  Center(
                    child: Text(
                      'EXPRESS CHECKOUT',
                      style: GoogleFonts.inter(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.apple, color: Colors.black),
                      label: Text(
                        'Apple Pay',
                        style: GoogleFonts.inter(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Color(0xFFC9A761)),
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 2. CONNECT WITH DIVIDER
                  Row(
                    children: [
                      const Expanded(child: Divider(color: Color(0xFFE0E0E0), thickness: 1)),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          'CONNECT WITH',
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

                  // 3. HEADER
                  Text(
                    'Shipping Details',
                    style: GoogleFonts.playfairDisplay(
                      fontSize: 28,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w500,
                    ),
                  ),

                  const SizedBox(height: 30),

                  // 4. FORM FIELDS
                  const Row(
                    children: [
                      Expanded(child: CheckoutTextField(label: 'First Name', hintText: 'Name')),
                      SizedBox(width: 15),
                      Expanded(child: CheckoutTextField(label: 'Last Name', hintText: 'Name')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const CheckoutTextField(label: 'Email Address', hintText: 'email@gmail.com'),
                  const SizedBox(height: 20),

                  const CheckoutTextField(label: 'Address', hintText: 'address'),
                  const SizedBox(height: 20),

                  const CheckoutTextField(label: 'Secondary Address(Optional)', hintText: 'address'),
                  const SizedBox(height: 20),

                  const Row(
                    children: [
                      Expanded(child: CheckoutTextField(label: 'City', hintText: 'city')),
                      SizedBox(width: 15),
                      Expanded(child: CheckoutTextField(label: 'Pincode', hintText: 'Pincode')),
                    ],
                  ),
                  const SizedBox(height: 20),

                  const CheckoutTextField(label: 'Phone No', hintText: 'Phone No'),
                  const SizedBox(height: 30),

                  // 5. CHECKBOX
                  Row(
                    children: [
                      SizedBox(
                        height: 24,
                        width: 24,
                        child: Checkbox(
                          value: _billingSameAsShipping,
                          activeColor: AppPallete.black,
                          onChanged: (val) {
                            setState(() {
                              _billingSameAsShipping = val!;
                            });
                          },
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        'BILLING SAME AS SHIPPING',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade500,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),

          // 6. FOOTER
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              border: Border(top: BorderSide(color: Color(0xFFE0E0E0))),
              color: Colors.white,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'TOTAL AMOUNT',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w700,
                            color: Colors.grey.shade400,
                            letterSpacing: 1.0,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '\$ 1,000',
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            color: AppPallete.black,
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'VIEW DETAILS',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        color: AppPallete.black,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to Payment Screen
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PaymentScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppPallete.black,
                      foregroundColor: AppPallete.white,
                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                      elevation: 0,
                    ),
                    child: Text(
                      'CONTINUE TO PAYMENT',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
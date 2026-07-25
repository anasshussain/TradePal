import '/repositories/api_requests/api_calls.dart';
import '/models/structs/index.dart';
import '/core/theme/app_theme.dart';
import '/utils/util.dart';
import '/widgets/app_button.dart';
import 'dart:ui';
import '/utils/custom_code/actions/index.dart' as actions;
import '/utils/custom_functions.dart' as functions;
import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '/viewmodels/bank_card_component_model.dart';
export '/viewmodels/bank_card_component_model.dart';

class BankCardComponentWidget extends StatefulWidget {
  const BankCardComponentWidget({
    super.key,
    required this.bankCardDetail,
  });

  final BankDetailsStruct? bankCardDetail;

  @override
  State<BankCardComponentWidget> createState() =>
      _BankCardComponentWidgetState();
}

class _BankCardComponentWidgetState extends State<BankCardComponentWidget> {
  late BankCardComponentModel _model;
  bool _pressed = false;
  @override
  void setState(VoidCallback callback) {
    super.setState(callback);
    _model.onUpdate();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => BankCardComponentModel());

    WidgetsBinding.instance.addPostFrameCallback((_) => safeSetState(() {}));
  }

  @override
  void dispose() {
    _model.maybeDispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 320,
          height: 255,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            border: Border.all(
              color: Colors.white.withOpacity(0.08),
              width: 1,
            ),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xff214FC7),
                Color(0xff173C98),
                Color(0xff0E255E),
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.25),
                blurRadius: 40,
                spreadRadius: -5,
                offset: const Offset(0, 20),
              ),
            ],
          ),
          child: Stack(
            children: [
              _glassEffect(),
              Material(
                color: Colors.transparent,
                child: GestureDetector(
                  
                  onTapDown: (_) {
                    setState(() => _pressed = true);
                  },
                  onTapUp: (_) {
                    setState(() => _pressed = false);
                  },
                  onTapCancel: () {
                    setState(() => _pressed = false);
                  },
                  child: AnimatedScale(
                    duration: const Duration(milliseconds: 180),
                    scale: _pressed ? .98 : 1,
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      transform: Matrix4.translationValues(
                        0,
                        _pressed ? 4 : 0,
                        0,
                      ),
                      child: _cardContent(),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Padding(
                    padding: EdgeInsets.only(
                      top: 0,
                      left: 17,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Checkbox(
                          value: false,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap,
                          visualDensity: VisualDensity.compact,
                          onChanged: (value) {
                            // Handle checkbox
                          },
                         activeColor: const Color(0xff214FC7),
  side: const BorderSide(
    color: Colors.white70,
  ),
                          
                        ),
                        TextButton.icon(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.delete_outline,
                            color: Colors.red,
                          ),
                          label: const Text(
                            "Delete",
                            style: TextStyle(
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    )),
              )
            ],
          ),
        ),
      ],
    );
  }

  Widget _glassEffect() {
    return Stack(
      children: [
        Positioned(
          top: -60,
          right: -40,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(.08),
            ),
          ),
        ),
        Positioned(
          bottom: -80,
          left: -60,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white.withOpacity(.04),
            ),
          ),
        ),
        Positioned(
          top: -120,
          left: 120,
          child: Transform.rotate(
            angle: -.35,
            child: Container(
              width: 80,
              height: 320,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.18),
                    Colors.white.withOpacity(.02),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _cardContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  widget.bankCardDetail?.bankName ?? "",
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  style: GoogleFonts.spaceGrotesk(
                    color: Colors.white,
                    fontSize: 17,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xff57C84D),
                      Color(0xff39B54A),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  "DEFAULT",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    letterSpacing: .5,
                  ),
                ),
              ),
              TweenAnimationBuilder<double>(
                tween: Tween(begin: .9, end: 1),
                duration: const Duration(milliseconds: 1200),
                curve: Curves.easeInOut,
                builder: (_, value, child) {
                  return Transform.scale(
                    scale: value,
                    child: child,
                  );
                },
                child: const Icon(
                  Icons.contactless,
                  color: Colors.white,
                  size: 30,
                ),
              )
            ],
          ),
          const SizedBox(height: 14),
          Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(
                  colors: [
                    Colors.white.withOpacity(.14),
                    Colors.white.withOpacity(.05),
                  ],
                ),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  "assets/images/cardChip-removebg-preview.png",
                  width: 44,
                ),
              )),
          const SizedBox(height: 18),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "••••  ••••  ••••  ",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 22,
                    color: Colors.white,
                  ),
                ),
                TextSpan(
                  text: widget.bankCardDetail?.last4 ?? "",
                  style: GoogleFonts.spaceGrotesk(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${functions.countryCodeToEmoji(widget.bankCardDetail?.country ?? '')} "
                    "${widget.bankCardDetail?.country ?? ''}",
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    (widget.bankCardDetail?.currency ?? '').toUpperCase(),
                    style: GoogleFonts.spaceGrotesk(
                      color: Colors.white70,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(.08),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Image.asset(
                  "assets/images/logo-removebg-preview.png",
                  width: 44,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

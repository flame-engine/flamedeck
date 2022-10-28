import 'package:flamedeck/widgets/widgets.dart';
import 'package:flamedeck_cartridge/flamedeck_cartridge.dart';
import 'package:flutter/material.dart';

class Console extends StatefulWidget {
  const Console({
    super.key,
    required this.cartridge,
    required this.width,
    required this.height,
  });

  final FlamedeckCartridge cartridge;

  final double width;
  final double height;

  @override
  State<Console> createState() => _ConsoleState();
}

class _ConsoleState extends State<Console> {
  bool _focus = false;

  @override
  Widget build(BuildContext context) {
    final dpadSize = widget.height * .28;
    final buttonSize = dpadSize / 3;

    return AnimatedSlide(
      offset: _focus ? const Offset(0, -.5) : Offset.zero,
      duration: const Duration(milliseconds: 400),
      child: AnimatedScale(
        duration: const Duration(milliseconds: 400),
        scale: _focus ? 2 : 1,
        child: Panel(
          width: widget.width,
          height: widget.height,
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.only(
                  top: widget.width * .1,
                  left: widget.width * .1,
                  right: widget.width * .1,
                ),
                padding: EdgeInsets.all(widget.width * .1),
                decoration: const BoxDecoration(
                  color: Colors.black87,
                  borderRadius:
                      BorderRadiusDirectional.all(Radius.circular(16)),
                ),
                height: widget.height * .6,
                child: Column(
                  children: [
                    Expanded(
                      child: ColoredBox(
                        color: Colors.teal,
                        child: Center(
                          child: DefaultTextStyle(
                            style: const TextStyle(
                              color: Colors.tealAccent,
                            ),
                            child: _focus
                                ? Padding(
                                    padding: const EdgeInsets.all(8),
                                    child: Column(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            setState(() => _focus = false);
                                          },
                                          child: const Panel(
                                            color: Colors.tealAccent,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            width: 80,
                                            height: 26,
                                            offset: 8,
                                            child: Center(
                                              child: Text(
                                                'Back',
                                                style: TextStyle(
                                                  color: Colors.teal,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Expanded(
                                          child: SingleChildScrollView(
                                            child: Text(
                                              widget.cartridge.description,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(widget.cartridge.title),
                                      const SizedBox(height: 12),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() => _focus = true);
                                        },
                                        child: const Panel(
                                          color: Colors.tealAccent,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(8),
                                          ),
                                          width: 80,
                                          height: 26,
                                          offset: 8,
                                          child: Center(
                                            child: Text(
                                              'About...',
                                              style:
                                                  TextStyle(color: Colors.teal),
                                            ),
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: widget.height * .05),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: Colors.white60,
                        fontWeight: FontWeight.bold,
                        fontSize: widget.height * .06,
                      ),
                      child: const Text('FlameDeck'),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                      top: widget.width * .05,
                      left: widget.width * .1,
                    ),
                    width: dpadSize,
                    height: dpadSize,
                    child: Stack(
                      children: [
                        Positioned(
                          left: buttonSize,
                          child: Panel(
                            color: const Color(0xff4f4f4f),
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          top: buttonSize,
                          child: Panel(
                            color: const Color(0xff4f4f4f),
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          top: buttonSize,
                          right: 0,
                          child: Panel(
                            color: const Color(0xff4f4f4f),
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        ),
                        Positioned(
                          right: buttonSize,
                          bottom: 0,
                          child: Panel(
                            color: const Color(0xff4f4f4f),
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                      left: widget.width * .05,
                    ),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: widget.width * .2,
                          ),
                          child: Panel(
                            color: Colors.purple,
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                            left: widget.width * .02,
                          ),
                          child: Panel(
                            color: Colors.blue,
                            offset: buttonSize / 6,
                            width: buttonSize,
                            height: buttonSize,
                            borderRadius: BorderRadius.all(
                              Radius.circular(buttonSize / 2),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

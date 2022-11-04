import 'package:flamedeck/cartridges/cartridges.dart';
import 'package:flamedeck/home/home.dart';
import 'package:flutter/material.dart';

const _extendedHeight = 280.0;
const _limit = _extendedHeight - kToolbarHeight;

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _controller = ScrollController();
  bool _showBanner = false;

  @override
  void initState() {
    super.initState();

    _controller.addListener(() {
      if (_controller.offset >= _limit && !_showBanner) {
        setState(() => _showBanner = true);
      } else if (_controller.offset <= _limit && _showBanner) {
        setState(() => _showBanner = false);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        controller: _controller,
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            pinned: true,
            expandedHeight: _extendedHeight,
            centerTitle: true,
            title: _showBanner
                ? SizedBox(
                    height: kToolbarHeight,
                    child: Image.asset(
                      'assets/system/banner.png',
                    ),
                  )
                : Image.asset(
                    'assets/system/title.png',
                  ),
            flexibleSpace: HeaderBackground(
              child: Padding(
                padding: const EdgeInsets.only(top: kToolbarHeight * 2),
                child: Image.asset(
                  'assets/system/icon.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Wrap(
                children: [
                  for (int i = 0; i < cartridges.length; i++)
                    InkWell(
                      onTap: () async {
                        //context.read<HomeCubit>().selectGame(i);
                        await CartridgeOverlay.show(
                          context,
                          cartridges[i],
                        );
                      },
                      child: CartridgeCard(
                        cartridge: cartridges[i],
                      ),
                    ),
                ],
              )
            ]),
          ),
        ],
      ),
    );
  }
}

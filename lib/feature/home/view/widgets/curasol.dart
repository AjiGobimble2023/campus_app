import 'package:campus_app/core.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
class CarouselGambar extends StatefulWidget {
  final List<String> imageList; // Tambahkan parameter imageList

  const CarouselGambar({super.key, required this.imageList});

  @override
  State<CarouselGambar> createState() => _CarouselGambarState();
}

class _CarouselGambarState extends State<CarouselGambar> {
  final CarouselController _controller = CarouselController();
  int _current = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          top: AppSizes.primary, bottom: AppSizes.primary),
      child: SizedBox(
        height: 200,
        child: Column(
          children: [
            Expanded(
              child: CarouselSlider(
                items: widget.imageList.map((imageUrl) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: SizedBox.fromSize(
                      child: Image.network(
                        imageUrl, // Menggunakan Image.network untuk URL gambar
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  );
                }).toList(),
                carouselController: _controller,
                options: CarouselOptions(
                  height: 198,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  aspectRatio: MediaQuery.of(context).size.width,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _current = index;
                    });
                  },
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageList.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 12.0,
                    height: 32.0,
                    margin: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 4.0,
                    ),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: (Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : AppColors.blue500)
                          .withOpacity(_current == entry.key ? 0.9 : 0.4),
                    ),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

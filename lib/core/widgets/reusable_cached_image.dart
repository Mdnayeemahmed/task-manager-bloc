import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../app/app_config/app_configurations.dart';

// class ReusableCachedImage extends StatelessWidget {
//   const ReusableCachedImage({
//     required this.imageUrl,
//     super.key,
//     this.errorIcon,
//     this.errorIconSize = 40.0,
//     this.shape = BoxShape.rectangle,
//     this.isFullPath = true,
//     this.width,
//     this.height,
//     this.boxFit = BoxFit.cover,
//   });
//
//   final String imageUrl;
//   final Widget? errorIcon;
//   final double errorIconSize;
//   final BoxShape shape;
//   final bool isFullPath;
//   final double? width;
//   final double? height;
//   final BoxFit boxFit;
//
//   @override
//   Widget build(BuildContext context) {
//     return CachedNetworkImage(
//       imageUrl: isFullPath ? imageUrl : AppConfiguration.imageUrl + imageUrl,
//       imageBuilder: (context, imageProvider) => Container(
//         height: height ?? 50,
//         width: width ?? 50,
//         alignment: Alignment.center,
//         decoration: BoxDecoration(
//           shape: shape,
//           image: DecorationImage(
//             image: imageProvider,
//             fit: boxFit,
//           ),
//         ),
//       ),
//       placeholder: (_, __) => Center(
//         child: errorIcon ??
//             Icon(
//               Icons.image,
//               color: gainsBoro,
//               size: errorIconSize,
//             ),
//       ),
//       errorWidget: (_, __, ___) => Center(
//         child: errorIcon ??
//             Icon(
//               Icons.broken_image_outlined,
//               color: red,
//               size: errorIconSize,
//             ),
//       ),
//     );
//   }
// }
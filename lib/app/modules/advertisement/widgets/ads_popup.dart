import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/models/ads_model.dart';
import '../../../shared/utilities.dart';
import '../../../shared/widgets/center_load_circular.dart';
import '../../../shared/widgets/emtpy_state.dart';
import '../../main/main_store.dart';
import '../advertisement_store.dart';
import 'ads.dart';
import 'advertisement_app_bar.dart';

class AdsPopup extends StatefulWidget {
  final String sellerId;
  final void Function() onPop;

  const AdsPopup({Key? key, required this.sellerId, required this.onPop})
      : super(key: key);

  @override
  State<AdsPopup> createState() => _AdsPopupState();
}

class _AdsPopupState extends State<AdsPopup>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    // deleteScrollController.addListener(() {
    //   maxScrollExtent = deleteScrollController.position.maxScrollExtent;
    //   offset = deleteScrollController.offset;
    // });
    super.initState();
    _controller = AnimationController(vsync: this, value: 0);
    animateTo(1);
  }

  Future<void> animateTo(double val) async {
    await _controller.animateTo(val,
        duration: Duration(milliseconds: 400), curve: Curves.decelerate);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final AdvertisementStore store = Modular.get();
  final MainStore mainStore = Modular.get();
  late OverlayEntry overlayEntry;
  // final ScrollController deleteScrollController = ScrollController();

  double offset = 0.0;
  double maxScrollExtent = 0.0;

  int limit = 15;

  double lastExtent = 0;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      height: maxHeight(context),
      width: maxWidth(context),
      child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Material(
              color: Colors.transparent,
              child: Stack(
                alignment: Alignment.centerRight,
                children: [
                  GestureDetector(
                    onTap: () async {
                      await animateTo(0);
                      widget.onPop();
                    },
                    child: BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: _controller.value + 0.01,
                        sigmaY: _controller.value + 0.01,
                      ),
                      child: Container(
                        height: maxHeight(context),
                        width: maxWidth(context),
                        color: getColors(context)
                            .shadow
                            .withOpacity(.3 * _controller.value),
                      ),
                    ),
                  ),
                  Positioned(
                    right: -wXD(411, context) + 411 * _controller.value,
                    child: Container(
                      height: maxHeight(context),
                      width: wXD(411, context),
                      color: getColors(context).background,
                      child: Stack(
                        children: [
                          Column(
                            children: [
                              AdvertisementAppBar(),
                              Expanded(
                                child: SingleChildScrollView(
                                  // controller: scrollController,
                                  child: StreamBuilder<QuerySnapshot>(
                                    stream: FirebaseFirestore.instance
                                        .collection("sellers")
                                        .doc(widget.sellerId)
                                        .collection('ads')
                                        .orderBy("created_at", descending: true)
                                        .where("status", whereIn: [
                                          "ACTIVE",
                                          "UNDER-ANALYSIS"
                                        ])
                                        .limit(limit)
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      // if (snapshot.hasError) {
                                      //   print(snapshot.error);
                                      // }
                                      if (!snapshot.hasData) {
                                        return CircularProgressIndicator();
                                      } else {
                                        QuerySnapshot qs = snapshot.data!;
                                        // qs.docs.forEach((adDoc) {});
                                        // WidgetsBinding.instance.addTimingsCallback((_) {
                                        //   store.charging = store.setAdsValues(qs);
                                        // });
                                        List<AdsModel> adsList = [];
                                        for (DocumentSnapshot adsDoc
                                            in qs.docs) {
                                          // print("adsDoc.id: ${adsDoc.id}");
                                          adsList.add(AdsModel.fromDoc(adsDoc));
                                        }
                                        // WidgetsBinding.instance
                                        //     ?.addPostFrameCallback((timeStamp) {
                                        //   store.adsActive = adsList.length;
                                        // });
                                        return Observer(
                                          builder: (context) {
                                            switch (store.adsStatusSelected) {
                                              case 'ACTIVE':
                                                return adsList.isEmpty
                                                    ? EmptyState(
                                                        text:
                                                            'Sem anúncios ativos',
                                                        icon: Icons
                                                            .campaign_outlined,
                                                        height:
                                                            maxHeight(context),
                                                      )
                                                    : Column(
                                                        children: <Widget>[
                                                          SizedBox(
                                                              height: wXD(
                                                                  15, context)),
                                                          ...adsList.map(
                                                            (ads) {
                                                              String image = '';
                                                              if (ads.images
                                                                  .isNotEmpty) {
                                                                image = ads
                                                                    .images
                                                                    .first;
                                                              }
                                                              return Ads(
                                                                ad: ads,
                                                                image: image,
                                                              );
                                                            },
                                                          ),
                                                          Container(
                                                            height: wXD(
                                                                120, context),
                                                            width: wXD(
                                                                100, context),
                                                            alignment: Alignment
                                                                .center,
                                                            child: limit ==
                                                                    qs.docs
                                                                        .length
                                                                ? CircularProgressIndicator()
                                                                : Container(),
                                                          ),
                                                        ],
                                                      );
                                              case 'pending':
                                                return store.charging
                                                    ? CenterLoadCircular()
                                                    : store.pendingAds.isEmpty
                                                        ? EmptyState(
                                                            text:
                                                                'Sem anúncios pendentes',
                                                            icon: Icons
                                                                .campaign_outlined,
                                                          )
                                                        : Column(
                                                            children: <Widget>[
                                                              SizedBox(
                                                                  height: wXD(
                                                                      123,
                                                                      context)),
                                                              ...store
                                                                  .pendingAds
                                                                  .map(
                                                                (ads) => Ads(
                                                                  ad: AdsModel(
                                                                    id: ads.id,
                                                                    title: ads
                                                                        .title,
                                                                    // sellerPrice: ads.sellerPrice,
                                                                    paused: ads
                                                                        .paused,
                                                                    highlighted:
                                                                        ads.highlighted,
                                                                    description:
                                                                        ads.description,
                                                                  ),
                                                                  image:
                                                                      'https://t2.tudocdn.net/518979?w=660&h=643',
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                  height: wXD(
                                                                      120,
                                                                      context))
                                                            ],
                                                          );
                                              case 'expired':
                                                return store.charging
                                                    ? CenterLoadCircular()
                                                    : store.expiredAds.isEmpty
                                                        ? EmptyState(
                                                            text:
                                                                'Sem anúncios expirados',
                                                            icon: Icons
                                                                .campaign_outlined,
                                                          )
                                                        : Column(
                                                            children: <Widget>[
                                                              SizedBox(
                                                                  height: wXD(
                                                                      123,
                                                                      context)),
                                                              ...store
                                                                  .expiredAds
                                                                  .map(
                                                                (ads) => Ads(
                                                                  ad: AdsModel(
                                                                    id: ads.id,
                                                                    title: ads
                                                                        .title,
                                                                    // sellerPrice: ads.sellerPrice,
                                                                    paused: ads
                                                                        .paused,
                                                                    highlighted:
                                                                        ads.highlighted,
                                                                    description:
                                                                        ads.description,
                                                                  ),
                                                                  image:
                                                                      'https://t2.tudocdn.net/518979?w=660&h=643',
                                                                ),
                                                              ),
                                                              Container(
                                                                height: wXD(120,
                                                                    context),
                                                                width: wXD(100,
                                                                    context),
                                                                alignment:
                                                                    Alignment
                                                                        .center,
                                                                child:
                                                                    CircularProgressIndicator(),
                                                              )
                                                            ],
                                                          );
                                              default:
                                                return Text('Is wroooooooong');
                                            }
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Positioned(
                            top: wXD(0, context),
                            right: wXD(10, context),
                            child: IconButton(
                              onPressed: () async {
                                await animateTo(0);
                                widget.onPop();
                                mainStore.sellerId = widget.sellerId;
                                Modular.to.pushNamed("/advertisement");
                              },
                              icon: Icon(
                                Icons.fullscreen,
                                size: wXD(35, context),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Observer(builder: (context) {
                  //   return AnimatedPositioned(
                  //     duration: Duration(milliseconds: 400),
                  //     curve: Curves.ease,
                  //     bottom: wXD(127, context),
                  //     right: store.addAds ? wXD(17, context) : wXD(-56, context),
                  //     child: FloatingCircleButton(
                  //       onTap: () {
                  //         Modular.to.pushNamed('/advertisement/create-ads');
                  //         // Navigator.push(
                  //         //   context,
                  //         //   MaterialPageRoute(
                  //         //     builder: (BuildContext context) => CreateAds(),
                  //         //   ),
                  //         // );
                  //       },
                  //       size: wXD(56, context),
                  //       child: Icon(
                  //         Icons.add,
                  //         size: wXD(30, context),
                  //         color: getColors(context).primary,
                  //       ),
                  //     ),
                  //   );
                  // }),
                  // Observer(builder: (context) {
                  //   return Visibility(
                  //     visible: store.delete,
                  //     child: BackdropFilter(
                  //       filter: ImageFilter.blur(
                  //           sigmaX: store.delete ? 2 : 0.001,
                  //           sigmaY: store.delete ? 2 : 0.001),
                  //       child: AnimatedOpacity(
                  //         opacity: store.delete ? .6 : 0,
                  //         duration: Duration(seconds: 1),
                  //         child: GestureDetector(
                  //           onTap: () => store.callDelete(removeDelete: true),
                  //           child: Container(
                  //             height: store.delete ? maxHeight(context) : 0,
                  //             width: store.delete ? maxWidth(context) : 0,
                  //             color: getColors(context).onBackground,
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   );
                  // }),
                  // Observer(builder: (context) {
                  //   return AnimatedPositioned(
                  //     top: store.delete ? 0 : maxHeight(context),
                  //     duration: Duration(seconds: 1),
                  //     curve: Curves.ease,
                  //     child: DeleteAds(
                  //       scrollController: deleteScrollController,
                  //     ),
                  //   );
                  // }),
                ],
              ),
            );
          }),
    );
  }
}

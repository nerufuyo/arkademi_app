// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:io';

import 'package:arkademi_app/config/theme.dart';
import 'package:arkademi_app/domain/bloc/courses/courses_bloc.dart';
import 'package:arkademi_app/domain/services/constant.dart';
import 'package:arkademi_app/domain/services/encryption.dart';
import 'package:arkademi_app/domain/services/formatted.dart';
import 'package:arkademi_app/domain/services/storage.dart';
import 'package:arkademi_app/domain/services/traffic_manager.dart';
import 'package:arkademi_app/presentation/widgets/appbar_widget.dart';
import 'package:arkademi_app/presentation/widgets/bottom_sheet_widget.dart';
import 'package:arkademi_app/presentation/widgets/dialog_widget.dart';
import 'package:arkademi_app/presentation/widgets/state_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_vlc_player/flutter_vlc_player.dart';
import 'package:path_provider/path_provider.dart';

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  SecureStorage secureStorage = SecureStorage();
  TrafficManager trafficManager = TrafficManager();

  final List<Map<String, dynamic>> courseLocal = [];
  late VlcPlayerController videoPlayerController;

  bool? isOfflineVideoExists;
  String? currentCourseTitle;
  String? currentCourseProgress;
  String? currentCourseVideoUrl;

  @override
  void initState() {
    super.initState();
    _initializeState();
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    videoPlayerController.stopRendererScanning();
    super.dispose();
  }

  void _initializeState() async {
    _fetchData();
    _loadStorage();
    _initializeVideoPlayer();
  }

  void _fetchData() async {
    BlocProvider.of<CoursesBloc>(context).add(CoursesEvent());
  }

  void _initializeVideoPlayer() {
    videoPlayerController = VlcPlayerController.network(
      currentCourseVideoUrl.toString(),
      autoPlay: false,
      autoInitialize: true,
      hwAcc: HwAcc.full,
      options: VlcPlayerOptions(
        advanced: VlcAdvancedOptions([VlcAdvancedOptions.networkCaching(2000)]),
      ),
    );
  }

  void _loadStorage() async {
    SecureStorage secureStorage = SecureStorage();

    secureStorage.getJsonFromSecureStorage('courseVideo').then((value) {
      setState(() {
        courseLocal.addAll(value);
      });
    });
  }

  void _downloadSchema(courseData) async {
    bool keyExists = courseLocal.any((element) {
      return element['key'] == courseData.key;
    });

    if (!keyExists) {
      videoPlayerController.pause();
      courseLocal.add({
        'key': courseData.key,
        'title': courseData.title,
        'duration': courseData.duration,
        'offlineVideoLink': courseData.offlineVideoLink,
        'offlineVideoPath': '${courseData.key}.mp4',
      });
      await trafficManager
          .downloadFile(
            context: context,
            fileName: '${courseData.key}.mp4',
            fileUrl: courseData.offlineVideoLink,
            encryptionKey: Secrets.encryptionKey,
          )
          .then(
            (value) => secureStorage.saveJsonToSecureStorage(
                'courseVideo', courseLocal),
          );
    }

    if (keyExists) {
      dialogWidget(
        context,
        message: 'Apakah Anda yakin ingin menghapus video ini?',
        action: 'Hapus',
        onTapped: () async {
          courseLocal
              .removeWhere((element) => element['key'] == courseData.key);
          trafficManager.deleteFile(
            context,
            fileName: '${courseData.key}.mp4',
          );
          secureStorage.deleteJsonFromSecureStorage('courseVideo');
          Navigator.pop(context);
        },
      );
    }
  }

  void _playSelectedCourse(courseData) async {
    Directory? externalDirectory = await getApplicationDocumentsDirectory();
    bool keyExists = courseLocal.any((element) {
      return element['key'] == courseData.key;
    });

    if (!keyExists) {
      isOfflineVideoExists = false;
      currentCourseVideoUrl = courseData.onlineVideoLink;
      playVideo(currentCourseVideoUrl!);
      print('Play Online Video');
      return;
    }

    try {
      String filePath = '${externalDirectory.path}/${courseData.key}.mp4';
      isOfflineVideoExists = await File(filePath).exists();

      if (isOfflineVideoExists == true) {
        // Play Encrypted Video
        // if (currentCourseVideoUrl != null) {
        //   EncryptionHelper().encryptFileInLocal(
        //     filePath: currentCourseVideoUrl!,
        //     secretKey: Secrets.encryptionKey,
        //   );
        // }
        // String? decryptedFilePath = await EncryptionHelper().loadDecryptedFile(
        //   filePath: filePath,
        //   encryptionKey: Secrets.encryptionKey,
        // );

        // if (decryptedFilePath != null) {
        //   currentCourseVideoUrl = decryptedFilePath;
        //   playVideo(currentCourseVideoUrl!);
        //   print('Play Offline Video');
        // } else {
        //   ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(
        //       content: Text('Video decryption failed!'),
        //       backgroundColor: Colors.red,
        //     ),
        //   );
        // }

        // Play Unencrypted Video
        currentCourseVideoUrl = filePath;
        playVideo(currentCourseVideoUrl!);
        print('Play Offline Video');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          // Handle file not found or other errors
          content: Text('Error: $error'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void playVideo(String videoUrl) {
    if (isOfflineVideoExists == false) {
      videoPlayerController.setMediaFromNetwork(videoUrl);
    } else {
      videoPlayerController.setMediaFromFile(File(videoUrl));
    }

    videoPlayerController.play();
  }

  @override
  Widget build(BuildContext context) {
    if (currentCourseTitle == null && currentCourseProgress == null) {
      Timer.periodic(const Duration(seconds: 1), (timer) => setState(() {}));
    }

    return Scaffold(
      appBar: appBarWidget(
        context,
        title: currentCourseTitle ?? 'Memuat...',
        progress: currentCourseProgress ?? '0',
      ),
      body: buildBody(context),
      bottomSheet: bottomSheetWidget(
        onPrevious: () {},
        onNext: () {},
      ),
    );
  }

  Widget buildBody(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: NestedScrollView(
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    color: Colors.black,
                    child: VlcPlayer(
                      aspectRatio: 16 / 9,
                      controller: videoPlayerController,
                      virtualDisplay: false,
                      placeholder: Container(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      4,
                      (index) => IconButton(
                        onPressed: () {
                          switch (index) {
                            case 0:
                              videoPlayerController.seekTo(Duration.zero);
                              break;
                            case 1:
                              videoPlayerController.play();
                              break;
                            case 2:
                              videoPlayerController.pause();
                              break;
                            case 3:
                              videoPlayerController.seekTo(
                                videoPlayerController.value.position +
                                    const Duration(seconds: 10),
                              );
                              break;
                            default:
                              videoPlayerController.play();
                          }
                        },
                        icon: Icon(
                          index == 0
                              ? Icons.skip_previous_rounded
                              : index == 1
                                  ? Icons.play_circle_fill_rounded
                                  : index == 2
                                      ? Icons.pause_circle_filled_rounded
                                      : Icons.skip_next_rounded,
                          color: AppColors().primary,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverAppBar(
              automaticallyImplyLeading: false,
              backgroundColor: AppColors().white,
              expandedHeight: 60,
              scrolledUnderElevation: 10,
              surfaceTintColor: AppColors().white,
              shadowColor: AppColors().white,
              pinned: true,
              floating: true,
              bottom: TabBar(
                labelColor: AppColors().primary,
                unselectedLabelColor: Colors.grey,
                indicatorColor: AppColors().primary,
                indicatorSize: TabBarIndicatorSize.tab,
                tabs: List.generate(
                  courseSubHeader.length,
                  (index) => Tab(
                    text: courseSubHeader[index],
                  ),
                ),
              ),
            ),
          ];
        },
        body: TabBarView(
          children: List.generate(
            3,
            (index) => index == 0
                ? BlocBuilder<CoursesBloc, CoursesState>(
                    builder: (context, state) {
                      return buildBlocStateWidget(state);
                    },
                  )
                : const Center(
                    child: Text('No Data Found'),
                  ),
          ),
        ),
      ),
    );
  }

  Widget buildBlocStateWidget(CoursesState state) {
    switch (state.runtimeType) {
      case const (CoursesLoading):
        return loadingWidget();
      case const (CoursesLoaded):
        return buildLoadedWidget(state as CoursesLoaded);
      case const (CoursesError):
        return errorWidget(state as CoursesError);
      default:
        return emptyWidget();
    }
  }

  Widget buildLoadedWidget(CoursesLoaded state) {
    currentCourseTitle = state.course.courseName;
    currentCourseProgress = state.course.progress;

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 60),
      shrinkWrap: true,
      itemCount: state.course.curriculum!.length,
      itemBuilder: (context, index) {
        final courseData = state.course.curriculum![index];

        return courseData.type!.contains('section')
            ? _buildSectionTile(courseData)
            : _buildCourseTile(context, courseData);
      },
    );
  }

  Widget _buildSectionTile(courseData) {
    return ListTile(
      tileColor: Colors.grey.shade200,
      title: Text(
        courseData.title!,
        style: AppTypographies().headline6,
      ),
      subtitle: Text(
        formatDuration(courseData.duration!),
        style: AppTypographies().subtitle2.copyWith(
              color: Colors.black.withOpacity(.5),
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
      ),
    );
  }

  Widget _buildCourseTile(
    BuildContext context,
    courseData,
  ) {
    bool isDownloaded = courseLocal.any((element) {
      return element['key'] == courseData.key;
    });

    return ListTile(
      onTap: () => _playSelectedCourse(courseData),
      leading: const Icon(
        Icons.play_circle_rounded,
        color: Colors.grey,
      ),
      title: Text(
        courseData.title!,
        style: AppTypographies().bodyText2,
      ),
      subtitle: Text(
        formatDuration(courseData.duration!),
        style: AppTypographies().subtitle2.copyWith(
              color: Colors.black.withOpacity(.5),
              fontWeight: FontWeight.normal,
              fontSize: 12,
            ),
      ),
      trailing: ElevatedButton(
        onPressed: () => _downloadSchema(courseData),
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isDownloaded ? AppColors().white : AppColors().primary,
          fixedSize: Size(
            MediaQuery.of(context).size.width * .275,
            30,
          ),
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
            side: BorderSide(
              color: isDownloaded ? Colors.grey.shade300 : AppColors().primary,
            ),
          ),
        ),
        child: isDownloaded
            ? Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tersimpan',
                    style: AppTypographies().button.copyWith(
                          color: Colors.black,
                          fontSize: 12,
                        ),
                  ),
                  Icon(
                    Icons.check_circle_outline_rounded,
                    color: AppColors().primary,
                    size: 16,
                  ),
                ],
              )
            : Text(
                'Tonton Offline',
                style: AppTypographies().button.copyWith(
                      color: AppColors().white,
                      fontSize: 12,
                    ),
              ),
      ),
    );
  }
}

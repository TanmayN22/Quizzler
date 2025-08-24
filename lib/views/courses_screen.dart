import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:quizller/controllers/course_model.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  final List<CourseTopic> _topics = [
    CourseTopic(
      name: 'Operating Systems',
      videos: [
        YouTubeVideo(
            id: 'vBURSzkJoS0', title: 'Introduction to Operating Systems'),
        YouTubeVideo(id: '2i2NLL-2-M0', title: 'Process Management'),
        YouTubeVideo(id: 'iKlAcrqk3c4', title: 'CPU Scheduling Algorithms'),
        YouTubeVideo(id: '3Bzs_c8d2c4', title: 'Memory Management'),
        YouTubeVideo(id: 'wYfpjSiNMNl', title: 'File Systems'),
      ],
    ),
    CourseTopic(
      name: 'DBMS',
      videos: [
        YouTubeVideo(id: 'gg86QGKMFZ4', title: 'Introduction to DBMS'),
        YouTubeVideo(id: 'HXV3zeQKqGY', title: 'SQL Tutorial for Beginners'),
        YouTubeVideo(
            id: 'GFQaEYEc8_8', title: 'Normalization in DBMS (1NF, 2NF, 3NF)'),
        YouTubeVideo(id: 'ztHopE5Wnpc', title: 'Database Design'),
        YouTubeVideo(id: 'kBdlM6hNDAE', title: 'Transactions and Concurrency'),
      ],
    ),
    CourseTopic(
      name: 'Data Structures',
      videos: [
        YouTubeVideo(
            id: 'RBSGKlAvoiM',
            title: 'Introduction to Data Structures & Algorithms'),
        YouTubeVideo(id: '92S4zgXN17k', title: 'Arrays and Linked Lists'),
        YouTubeVideo(id: 'oSWTXtMglKE', title: 'Stacks and Queues'),
        YouTubeVideo(id: 'qH6yxkw0u78', title: 'Trees and Binary Search Trees'),
        YouTubeVideo(id: 'tWVWeAqZ0WU', title: 'Hash Tables and Graphs'),
      ],
    ),
  ];

  late CourseTopic _selectedTopic;
  List<YouTubeVideo> _filteredVideos = [];
  final TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeIn),
    );

    if (_topics.isNotEmpty) {
      _selectedTopic = _topics.first;
      _filteredVideos = _selectedTopic.videos;
    }
    _searchController.addListener(_filterVideos);
    _animationController.forward();
  }

  void _filterVideos() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredVideos = _selectedTopic.videos.where((video) {
        return video.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  void _selectTopic(CourseTopic topic) {
    setState(() {
      _selectedTopic = topic;
      _searchController.clear();
      _filteredVideos = topic.videos;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _launchURL(String videoId) async {
    setState(() => _isLoading = true);

    // Try multiple URL formats for better compatibility
    final List<String> urlsToTry = [
      'vnd.youtube:$videoId', // YouTube app deep link (Android)
      'youtube://watch?v=$videoId', // YouTube app deep link (iOS)
      'https://www.youtube.com/watch?v=$videoId', // Web URL
      'https://youtu.be/$videoId', // Short URL
    ];

    bool launched = false;

    for (String url in urlsToTry) {
      try {
        final uri = Uri.parse(url);

        // For app deep links, try to launch directly
        if (url.startsWith('vnd.youtube:') || url.startsWith('youtube://')) {
          launched = await launchUrl(uri, mode: LaunchMode.externalApplication);
        } else {
          // For web URLs, check if can launch first
          if (await canLaunchUrl(uri)) {
            launched =
                await launchUrl(uri, mode: LaunchMode.externalApplication);
          }
        }

        if (launched) {
          if (mounted) {
            _showSuccessSnackbar('Opening video...');
          }
          break;
        }
      } catch (e) {
        // Continue to next URL if this one fails
        continue;
      }
    }

    if (!launched && mounted) {
      _showErrorSnackbar(
          'Cannot open video. Please install YouTube app or check your internet connection.');
    }

    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  void _showErrorSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void _showSuccessSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.check_circle_outline, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.green.shade600,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: const Text(
          'Learning Hub',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        elevation: 1,
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () {
              _showInfoDialog();
            },
          ),
        ],
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: Column(
          children: [
            // Header Section
            Container(
              color: Colors.white,
              child: Column(
                children: [
                  // Topic Selection Chips
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Choose your subject:',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[700],
                          ),
                        ),
                        const SizedBox(height: 16),
                        SizedBox(
                          height: 45,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: _topics.length,
                            itemBuilder: (context, index) {
                              final topic = _topics[index];
                              final isSelected =
                                  _selectedTopic.name == topic.name;
                              return Padding(
                                padding: EdgeInsets.only(
                                  right: index == _topics.length - 1 ? 16 : 12,
                                  left: index == 0 ? 0 : 0,
                                ),
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 200),
                                  child: FilterChip(
                                    label: Text(
                                      topic.name,
                                      style: TextStyle(
                                        color: isSelected
                                            ? Colors.white
                                            : Colors.deepPurple,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.w500,
                                        fontSize: 14,
                                      ),
                                    ),
                                    selected: isSelected,
                                    onSelected: (_) => _selectTopic(topic),
                                    selectedColor: Colors.deepPurple,
                                    backgroundColor: Colors.grey[100],
                                    checkmarkColor: Colors.white,
                                    elevation: isSelected ? 6 : 2,
                                    shadowColor:
                                        Colors.deepPurple.withOpacity(0.3),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(25),
                                      side: BorderSide(
                                        color: isSelected
                                            ? Colors.deepPurple
                                            : Colors.grey.shade300,
                                        width: 1,
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey.shade300),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText:
                              'Search videos in ${_selectedTopic.name}...',
                          hintStyle: TextStyle(
                            color: Colors.grey[500],
                            fontSize: 14,
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.deepPurple,
                            size: 20,
                          ),
                          suffixIcon: _searchController.text.isNotEmpty
                              ? IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: Colors.grey[600],
                                    size: 20,
                                  ),
                                  onPressed: () {
                                    _searchController.clear();
                                  },
                                )
                              : null,
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ),
                  ),

                  // Divider
                  Container(
                    height: 1,
                    color: Colors.grey[200],
                  ),
                ],
              ),
            ),

            // Video List
            Expanded(
              child: _filteredVideos.isEmpty
                  ? _buildEmptyState()
                  : RefreshIndicator(
                      onRefresh: () async {
                        await Future.delayed(const Duration(seconds: 1));
                        setState(() {
                          _filteredVideos = _selectedTopic.videos;
                        });
                        _showSuccessSnackbar('Refreshed successfully!');
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: _filteredVideos.length,
                        itemBuilder: (context, index) {
                          final video = _filteredVideos[index];
                          return _buildVideoCard(video, index);
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: _isLoading
          ? FloatingActionButton(
              onPressed: null,
              backgroundColor: Colors.grey,
              child: const CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : null,
    );
  }

  Widget _buildVideoCard(YouTubeVideo video, int index) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 100 + (index * 50)),
      margin: const EdgeInsets.only(bottom: 12),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: InkWell(
          onTap: () {
            _launchURL(video.id);
          },
          borderRadius: BorderRadius.circular(12),
          child: Container(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                // Thumbnail with play overlay
                Container(
                  width: 100,
                  height: 75,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: Colors.grey[300],
                  ),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          'https://img.youtube.com/vi/${video.id}/maxresdefault.jpg',
                          fit: BoxFit.cover,
                          width: 100,
                          height: 75,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              gradient: LinearGradient(
                                colors: [
                                  Colors.deepPurple.shade300,
                                  Colors.deepPurple.shade600
                                ],
                              ),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.video_library,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                          loadingBuilder: (context, child, loadingProgress) {
                            if (loadingProgress == null) return child;
                            return Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.grey[200],
                              ),
                              child: Center(
                                child: SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.deepPurple,
                                    value: loadingProgress.expectedTotalBytes !=
                                            null
                                        ? loadingProgress
                                                .cumulativeBytesLoaded /
                                            (loadingProgress
                                                    .expectedTotalBytes ??
                                                1)
                                        : null,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      // Play button overlay
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: Colors.black.withOpacity(0.4),
                          ),
                          child: const Center(
                            child: Icon(
                              Icons.play_circle_filled,
                              color: Colors.white,
                              size: 32,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 12),

                // Video details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        video.title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                          height: 1.3,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.deepPurple.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          _selectedTopic.name,
                          style: TextStyle(
                            fontSize: 11,
                            color: Colors.deepPurple.shade700,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Icon(
                            Icons.play_arrow,
                            size: 16,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(width: 4),
                          Expanded(
                            child: Text(
                              'Tap to watch on YouTube',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            size: 14,
                            color: Colors.deepPurple.shade400,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off,
            size: 64,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 16),
          Text(
            'No videos found',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try searching with different keywords',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[500],
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: () {
              _searchController.clear();
            },
            icon: const Icon(Icons.refresh),
            label: const Text('Reset Search'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showInfoDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Row(
            children: [
              Icon(Icons.info_outline, color: Colors.deepPurple),
              const SizedBox(width: 8),
              const Text('Learning Hub'),
            ],
          ),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('• Select a subject from the chips above'),
              SizedBox(height: 8),
              Text('• Use the search bar to find specific topics'),
              SizedBox(height: 8),
              Text('• Tap on any video to watch it on YouTube'),
              SizedBox(height: 8),
              Text('• Pull down to refresh the video list'),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                'Got it!',
                style: TextStyle(color: Colors.deepPurple),
              ),
            ),
          ],
        );
      },
    );
  }
}

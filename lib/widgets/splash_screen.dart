import 'package:flutter/material.dart';
import 'package:fl_clash/managers/startup_manager.dart';

/// 启动页面 - 改善用户等待体验
class SplashScreen extends StatefulWidget {
  final VoidCallback? onInitializationComplete;
  
  const SplashScreen({
    super.key,
    this.onInitializationComplete,
  });

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  
  late AnimationController _logoController;
  late AnimationController _progressController;
  late Animation<double> _logoAnimation;
  late Animation<double> _progressAnimation;
  
  String _currentStep = '正在初始化...';
  double _progress = 0.0;
  bool _showProgress = false;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _startProgressMonitoring();
  }

  void _initAnimations() {
    // Logo动画控制器
    _logoController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    
    // 进度动画控制器
    _progressController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    // Logo缩放动画
    _logoAnimation = Tween<double>(
      begin: 0.5,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _logoController,
      curve: Curves.elasticOut,
    ));

    // 进度条透明度动画
    _progressAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _progressController,
      curve: Curves.easeInOut,
    ));

    // 启动Logo动画
    _logoController.forward();
    
    // 延迟显示进度条
    Future.delayed(const Duration(milliseconds: 500), () {
      if (mounted) {
        setState(() {
          _showProgress = true;
        });
        _progressController.forward();
      }
    });
  }

  void _startProgressMonitoring() {
    // 监听启动管理器的进度
    startupManager.addProgressListener(_onProgressUpdate);
    
    // 如果启动已完成，直接触发完成回调
    if (startupManager.isCompleted) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted && widget.onInitializationComplete != null) {
          widget.onInitializationComplete!();
        }
      });
    }
  }

  void _onProgressUpdate(StartupPhase phase, double progress, String message) {
    if (mounted) {
      setState(() {
        _currentStep = message;
        _progress = progress;
      });
      
      // 如果启动完成，延迟一点时间让用户看到100%
      if (phase == StartupPhase.completed) {
        Future.delayed(const Duration(milliseconds: 300), () {
          if (mounted && widget.onInitializationComplete != null) {
            widget.onInitializationComplete!();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    startupManager.removeProgressListener(_onProgressUpdate);
    _logoController.dispose();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    
    return Scaffold(
      backgroundColor: colorScheme.surface,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo区域
              Expanded(
                flex: 3,
                child: Center(
                  child: AnimatedBuilder(
                    animation: _logoAnimation,
                    builder: (context, child) {
                      return Transform.scale(
                        scale: _logoAnimation.value,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 应用Logo
                            Container(
                              width: 120,
                              height: 120,
                              decoration: BoxDecoration(
                                color: colorScheme.primary,
                                borderRadius: BorderRadius.circular(24),
                                boxShadow: [
                                  BoxShadow(
                                    color: colorScheme.primary.withOpacity(0.3),
                                    blurRadius: 20,
                                    offset: const Offset(0, 8),
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.flash_on,
                                size: 64,
                                color: colorScheme.onPrimary,
                              ),
                            ),
                            
                            const SizedBox(height: 24),
                            
                            // 应用名称
                            Text(
                              'FlClash',
                              style: theme.textTheme.headlineMedium?.copyWith(
                                color: colorScheme.onSurface,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            
                            const SizedBox(height: 8),
                            
                            // 应用标语
                            Text(
                              '快速、安全、稳定的网络代理',
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.7),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ),
              
              // 进度区域
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_showProgress) ...[
                      // 当前步骤文本
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _progressAnimation.value,
                            child: Text(
                              _currentStep,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: colorScheme.onSurface.withOpacity(0.8),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          );
                        },
                      ),
                      
                      const SizedBox(height: 16),
                      
                      // 进度条
                      AnimatedBuilder(
                        animation: _progressAnimation,
                        builder: (context, child) {
                          return Opacity(
                            opacity: _progressAnimation.value,
                            child: Column(
                              children: [
                                // 线性进度条
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: SizedBox(
                                    height: 6,
                                    child: TweenAnimationBuilder<double>(
                                      tween: Tween(begin: 0.0, end: _progress),
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeOutCubic,
                                      builder: (context, value, child) {
                                        return LinearProgressIndicator(
                                          value: value,
                                          backgroundColor: colorScheme.outline.withOpacity(0.2),
                                          valueColor: AlwaysStoppedAnimation<Color>(
                                            colorScheme.primary,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                
                                const SizedBox(height: 8),
                                
                                // 进度百分比
                                TweenAnimationBuilder<double>(
                                  tween: Tween(begin: 0.0, end: _progress),
                                  duration: const Duration(milliseconds: 300),
                                  builder: (context, value, child) {
                                    return Text(
                                      '${(value * 100).toInt()}%',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.primary,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    );
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ],
                  ],
                ),
              ),
              
              // 底部版本信息
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      'v2.0.0', // 临时版本号，实际应该从packageInfo获取
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: colorScheme.onSurface.withOpacity(0.5),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
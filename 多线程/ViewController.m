//
//  ViewController.m
//  多线程
//
//  Created by 杭州米发 on 2018/1/25.
//  Copyright © 2018年 冯硕. All rights reserved.
//

#import "ViewController.h"
/*
 多线程的基本知识
 
 先补一发基础知识
 
 什么是线程
 
 线程，有时被称为轻量级进程(Lightweight Process，LWP），是程序执行流的最小单元。一个标准的线程由线程ID，当前指令指针(PC），寄存器集合和堆栈组成。
 
 线程是程序中一个单一的顺序控制流程。进程内一个相对独立的、可调度的执行单元，是系统独立调度和分派CPU的基本单位指运行中的程序的调度单位。在单个程序中同时运行多个线程完成不同的工作，称为多线程。
 
 线程与进程的关系
 
 线程是进程中的一个实体，是被系统独立调度和分派的基本单位，线程自己不拥有系统资源，只拥有一点儿在运行中必不可少的资源，但它可与同属一个进程的其它线程共享进程所拥有的全部资源。一个线程可以创建和撤消另一个线程，同一进程中的多个线程之间可以并发执行。
 
 线程与进程的区别
 
 进程
 
 进程是资源分配的基本单位。每个进程拥有自己独立的进程控制块（PCB，Process Control Block），不同的进程拥有不同的虚拟地址空间。
 
 进程间通信，常用方法为：
 
 管道（pipe）
 消息队列（message queue）
 信号（sinal）
 信号量（semophore）
 共用内存（shared memory）
 套接字（socket）
 线程
 
 线程是被系统独立调度和分派的基本单位。线程只由相关堆栈（系统栈或用户栈）寄存器和线程控制表（TCB，Thread Control Table）组成，同一进程内的不同线程共享同一地址空间。
 
 线程间通信，常用方法为：
 
 锁（lock）：互斥锁、条件变量、读写锁等
 信号量（semophore）
 信号（signal）：用于线程同步

 */
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIButton *button;

@property (nonatomic, strong) UIImageView * imageView;
@property (nonatomic, strong) UIImageView * imageView1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

   
    UIImageView * imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 100, [UIScreen mainScreen].bounds.size.width, 300)];
    
    UIImageView * imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 500, [UIScreen mainScreen].bounds.size.width, 200)];
    
    self.imageView =imageView;
    self.imageView1 = imageView1;
    [self.view addSubview:imageView];
    [self.view addSubview:imageView1];
    
    
//    [self yibuBingfa];
//    [self tongbuBingfa];
//    [self yibuChuanxing];
//    [self tongbuchuanxing];
//    [self yibuzhuduilie];
//    [self tongbuzhuduilie];
   
//线程通讯
    [self xianchengtongxu];

//延时执行
    [self DispatchAfter];
    
//   栅栏
    [self barrier];
    
    
//    [self GCDGroup];
    
//    [self DispatchSemaphore];
    
//    [self DispatchKeepGroup];
    
//    dispatch_async(dispatch_get_global_queue(0, 0), ^{
//        NSString * str = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
//        UIImage * image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
//
//        NSString * str1 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
//        UIImage * image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str1]]];
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//           imageView.image = image;
//            imageView1.image = image1;
//        });
//    });
    
    
   
    
    
    
//    [self.button setImage:image forState:UIControlStateNormal];
    
    
    
//    dispatch_queue_t queue;
//    //穿行
//    queue = dispatch_queue_create("cn.itcast.queue", NULL);
//
//  //并发
//    dispatch_queue_t queue2 = dispatch_queue_create("com.wxhl.gcd.Queue2", DISPATCH_QUEUE_CONCURRENT);
//    
////    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
//    size_t  coutn = 20;
//    dispatch_apply(coutn, queue2, ^(size_t i) {
//        NSLog(@"%zd", i);
//    });
    
    
    
    
}

#pragma mark - dispatch_group_async


- (void)GCDGroup
{
    dispatch_group_t guroup =  dispatch_group_create();
    dispatch_queue_t queuue = dispatch_get_global_queue(0, 0);
    dispatch_async(queuue, ^{
        __block UIImage * image = nil;
        dispatch_group_async(guroup, queuue, ^{
        
            NSString * str = @"http://car0.autoimg.cn/upload/spec/9579/u_20120110174805627264.jpg";
        image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        });
        
    
        
       __block UIImage * image1 = nil;
        dispatch_group_async(guroup, queuue, ^{
            sleep(15);
            NSString * str1 = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
            image1 = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str1]]];
        });
        
       //
     
        
        dispatch_group_notify(guroup, dispatch_get_main_queue(), ^{
           
            self.imageView.image = image;
            self.imageView1.image = image1;
        });
        
      long result  =  dispatch_group_wait(guroup, dispatch_time(DISPATCH_TIME_NOW, 20ull * NSEC_PER_SEC));
        if ( result == 0) {
            NSLog(@"finish");
        }else{
            NSLog(@"not finish");
        }
        
        
        
    });
}



#pragma mark - dispatch_apply
//



#pragma mark - dispatch_after 延迟执行
- (void)DispatchAfter
{
//    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 20 * NSEC_PER_SEC);
//    //NSEC_PER_SEC  秒
//    //NSEC_PER_MSEC 毫秒
//    //NSEC_PER_USEC 微秒
//    dispatch_after(time, dispatch_get_main_queue(), ^{
//        NSLog(@"过了20秒了");
//    });
    
//    [NSTimer scheduledTimerWithTimeInterval:20 repeats:NO block:^(NSTimer * _Nonnull timer) {
//        NSLog(@"过了20秒了");
//    }];
//
    
    [self performSelector:@selector(run) withObject:self afterDelay:20];
    
}

- (void)run
{
    NSLog(@"过了20秒了");
}


#pragma mark - barrier(屏障， 栅栏)
- (void)barrier
{
//    //全局并发队列 在此处没有用处
//    dispatch_queue_t queue = dispatch_queue_create("fengshuo.GCD", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        NSLog(@"第一步");
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"第二步");
//    });
//
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"这是一个栅栏");
//    });
//
//    dispatch_async(queue, ^{
//        NSLog(@"第三步");
//    });
//
//    dispatch_barrier_async(queue, ^{
//        NSLog(@"这是一个栅栏");
//    });
//    dispatch_async(queue, ^{
//        NSLog(@"第四步");
//    });
    
    
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue = dispatch_queue_create("fengshuo>GCD", DISPATCH_QUEUE_CONCURRENT);
    dispatch_group_async(group, queue, ^{
        NSLog(@"第一步");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"第二步");
    });
    
    dispatch_barrier_async(queue, ^{
        NSLog(@"这是一个战狼");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"第三步");
    });
    
    dispatch_group_async(group, queue, ^{
        NSLog(@"第四步");
    });
    
}


#pragma mark - 单利 dispatch_once_t

- (void)DispatchOnce{
    static dispatch_once_t oncetoken;
    dispatch_once(&oncetoken, ^{
        
    });

}


#pragma mark - 信号量控制顺序

- (void)DispatchSemaphore
{
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    
    dispatch_semaphore_t dsema = dispatch_semaphore_create(1);
    
    NSMutableArray *array = [NSMutableArray array];
    
    for (int i = 0; i < 1000; i++) {
        dispatch_async(queue, ^{
            dispatch_semaphore_wait(dsema, DISPATCH_TIME_FOREVER);
            
            [array addObject:[NSNumber numberWithInt:i]];
            
            dispatch_semaphore_signal(dsema);
            
        });
    }
    
    NSLog(@"%@", array);
}

- (void)DispatchKeepGroup
{
 dispatch_group_t group =   dispatch_group_create();
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0 );
    NSMutableArray * array = [NSMutableArray array];

//
//    dispatch_group_enter(group);
    dispatch_group_async(group, queue, ^{
        for (int i = 0; i < 20; i++) {
            [array addObject:[NSString stringWithFormat:@"%d", i]];
        }
    });
//    dispatch_group_leave(group);
    
    

    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
          NSLog( @"%@",array);
    });
  
    
}


#pragma mark - 线程之间通讯
- (void)xianchengtongxu
{
    NSString * str  = @"http://hiphotos.baidu.com/lvpics/pic/item/3a86813d1fa41768bba16746.jpg";
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
       
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:str]]];
        //返回主线程 设置图片
        dispatch_async(dispatch_get_main_queue(), ^{
            self.imageView.image = image;
        });
        
    });
}


#pragma  mark - 异步并发
- (void)yibuBingfa
{
//    DISPATCH_QUEUE_CONCURRENT 并发 串行
    dispatch_queue_t queue = dispatch_queue_create("fengshuo.GCd", DISPATCH_QUEUE_CONCURRENT);
    dispatch_async(queue, ^{
        NSLog(@"异步并发1 ==%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步并发2 ==%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步并发3 ==%@", [NSThread currentThread]);
    });
    
    
}

#pragma mark - 同步并发
- (void)tongbuBingfa
{
  dispatch_queue_t queue =  dispatch_queue_create("fengshuo.GCD", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_sync(queue, ^{
        NSLog(@"同步并发1:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步并发2:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步并发3:%@", [NSThread currentThread]);
    });
}

#pragma mark - 异步 串行
//会开启新的线程 但是线程是一样的
- (void)yibuChuanxing
{
    dispatch_queue_t queue = dispatch_queue_create("fengshuo.GCD", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        NSLog(@"异步串行1:%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步串行2:%@", [NSThread currentThread]);
    });
    
    
    dispatch_async(queue, ^{
        NSLog(@"异步串行3:%@", [NSThread currentThread]);
    });
    
    
    
    
}

#pragma mark - 同步 串行
// 不会开启新的线程
- (void)tongbuchuanxing
{
    dispatch_queue_t queue = dispatch_queue_create("fengshuo.GCD", DISPATCH_QUEUE_SERIAL);
    
    dispatch_sync(queue, ^{
      NSLog(@"同步串行1:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步串行2:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步串行3:%@", [NSThread currentThread]);
    });
}

#pragma mark - 异步 主队列
//由于主队列的特性 所以不会开启新的线程 只会在主线程中执行 并且顺序执行
- (void)yibuzhuduilie
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_async(queue, ^{
        NSLog(@"异步主队列1:%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步主队列2:%@", [NSThread currentThread]);
    });
    
    dispatch_async(queue, ^{
        NSLog(@"异步主队列3:%@", [NSThread currentThread]);
    });
}

#pragma mark - 同步 主队列
//相互等待 谁也执行不了
- (void)tongbuzhuduilie
{
    dispatch_queue_t queue = dispatch_get_main_queue();
    dispatch_sync(queue, ^{
        NSLog(@"同步步主队列1:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步主队列2:%@", [NSThread currentThread]);
    });
    
    dispatch_sync(queue, ^{
        NSLog(@"同步主队列3:%@", [NSThread currentThread]);
    });
}





- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

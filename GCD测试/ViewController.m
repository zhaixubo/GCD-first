//
//  ViewController.m
//  GCD测试
//
//  Created by 翟旭博 on 2023/1/10.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//   [self syncConcurrent];      // 并发队列 + 同步执行
//    [self asyncConcurrent];     // 并发队列 + 异步执行
//    [self syncSerial];          // 串行队列 + 同步执行
//    [self asyncSerial];         // 串行队列 + 异步执行
//
 //   [self syncMain];
//    //主队列 + 同步执行
//    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
//    dispatch_async(queue, ^{
//        [self syncMain];
//    });
//    [self asyncMain];          //主队列 + 异步执行
//    [self gcdCommunication];     //GCD线程之间的通讯
//    [self barrier];      //GCD栅栏方法
//    [self after];
//    [self once];
    [self group];
}

- (void)syncConcurrent {          // 并发队列 + 同步执行
    NSLog(@"syncConcurrent---begin");
 
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
 
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
 
    NSLog(@"syncConcurrent---end");
}

- (void)asyncConcurrent {            //并发队列 + 异步执行
    NSLog(@"asyncConcurrent---begin");
 
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_CONCURRENT);
 
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncConcurrent---end");
}

- (void)syncSerial {             //串行队列 + 同步执行
    NSLog(@"syncSerial---begin");
 
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
 
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"syncSerial---end");
}

- (void)asyncSerial {         //串行队列 + 异步执行
    NSLog(@"asyncSerial---begin");
 
    dispatch_queue_t queue = dispatch_queue_create("test.queue", DISPATCH_QUEUE_SERIAL);
 
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
    
    NSLog(@"asyncSerial---end");
}

- (void)syncMain {     //主队列 + 同步执行
    NSLog(@"syncMain---begin");
 
    dispatch_queue_t queue = dispatch_get_main_queue();
 
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_sync(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
 
    NSLog(@"syncMain---end");
}

- (void)asyncMain {          //主队列 + 异步执行
    NSLog(@"asyncMain---begin");
 
    dispatch_queue_t queue = dispatch_get_main_queue();
 
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"1------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"2------%@", [NSThread currentThread]);
        }
    });
    dispatch_async(queue, ^{
        for (int i = 0; i < 2; ++i) {
            NSLog(@"3------%@", [NSThread currentThread]);
        }
    });
 
    NSLog(@"asyncMain---end");
}

- (void)gcdCommunication {        //GCD线程之间的通讯
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        for (int i = 0; i < 6; ++i) {
            NSLog(@"1------%@",[NSThread currentThread]);
        }
     
        // 回到主线程
        dispatch_async(dispatch_get_main_queue(), ^{
            NSLog(@"2-------%@",[NSThread currentThread]);
        });
    });

}

- (void)barrier {      //GCD栅栏方法
    dispatch_queue_t queue = dispatch_queue_create("666", DISPATCH_QUEUE_CONCURRENT);
 
    dispatch_async(queue, ^{
        NSLog(@"----1-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----2-----%@", [NSThread currentThread]);
    });
 
    dispatch_barrier_async(queue, ^{
        NSLog(@"----barrier-----%@", [NSThread currentThread]);
    });
 
    dispatch_async(queue, ^{
        NSLog(@"----3-----%@", [NSThread currentThread]);
    });
    dispatch_async(queue, ^{
        NSLog(@"----4-----%@", [NSThread currentThread]);
    });
}

- (void)after {       //GCD的延时执行方法
    NSLog(@"run -- 0");
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        // 2秒后异步执行这里的代码...
       NSLog(@"run -- 2");
    });
}

- (void)once {        //GCD的一次性代码(只执行一次)
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // 只执行1次的代码(这里面默认是线程安全的)
        NSLog(@"666");
    });

}

- (void)group {        //GCD的队列组
    dispatch_group_t group =  dispatch_group_create();
     
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        int i = 0;
        while (i < 100) {
            NSLog(@"1");
            i++;
        }
        
    });
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        // 等前面的异步操作都执行完毕后，回到主线程...
        NSLog(@"3");
    });
    dispatch_group_async(group, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 执行1个耗时的异步操作
        int i = 0;
        while (i < 100) {
            NSLog(@"2");
            i++;
        }
    });

}
@end

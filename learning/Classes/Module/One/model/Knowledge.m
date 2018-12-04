//
//  Knowledge.m
//  learning
//
//  Created by 祥伟 on 2018/8/20.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "Knowledge.h"
#import <objc/runtime.h>

@implementation Knowledge

+ (NSString *)showKnowledge:(NSString *)theme{
    SEL sel = NSSelectorFromString(theme);

    if ([self respondsToSelector:sel]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Warc-performSelector-leaks"
        return [self performSelector:sel];
#pragma clang diagnostic pop
    }

    return @"哇，没找到哇！";
}


/*
 *  中文命名是方便可读性
 */

+ (NSString *)assign和weak的区别{
    return @"区别：weak 只可以修饰对象，assign 可修饰对象，和基本数据类型\nweak 不会产生野指针问题。因为weak修饰的对象释放后（引用计数器值为0），指针会自动被置nil，之后再向该对象发消息也不会崩溃，assign 如果修饰对象，会产生野指针问题；如果修饰基本数据类型则是安全的。修饰的对象释放后，指针不会自动被置空，此时向对象发消息会崩溃\n\nweak表其实是一个hash（哈希）表，Key是所指对象的地址，Value是weak指针的地址数组\n1、初始化时：runtime会调用objc_initWeak函数，初始化一个新的weak指针指向对象的地址。\n2、添加引用时：objc_initWeak函数会调用 objc_storeWeak() 函数， objc_storeWeak() 的作用是更新指针指向，创建对应的弱引用表。\n3、释放时，调用clearDeallocating函数。clearDeallocating函数首先根据对象地址获取所有weak指针地址的数组，然后遍历这个数组把其中的数据设为nil，最后把这个entry从weak表中删除，最后清理对象的记录。";
}

+ (NSString *)KVC{
    return @"KVC（Key-value coding）键值编码,通过对象属性名称（Key）直接给属性值（value）编码\n1.自动查找类属性赋值\n2.value的值必须是id,也就是说不能传基本数据类型，必须是指针类型的变量\nSEL sel = sel_get_uid (setValue:forKey:);\nIMP method = objc_msg_lookup (site->isa,sel);\nmethod(site, sel, value, key);\n（1）首先根据方法名找到运行方法的时候所需要的环境参数。\n（2）他会从自己isa指针结合环境参数，找到具体的方法实现的接口。\n（3）再直接查找得来的具体的方法实现。";
}

+ (NSString *)SEl和IMP{
    return @"SEL : 类成员方法的指针，但不同于C语言中的函数指针，函数指针直接保存了方法的地址，但SEL只是方法编号。\nIMP:一个函数指针,保存了方法的地址\n每一个继承于NSObject的类都能自动获得runtime的支持。在这样的一个类中，有一个isa指针，指向该类定义的数据结构体,这个结构体是由编译器编译时为类（需继承于NSObject）创建的.在这个结构体中有包括了指向其父类类定义的指针以及 Dispatch table. Dispatch table是一张SEL和IMP的对应表\n@selector()就是取类方法的编号:SEL methodId=@selector(func1);\n对应执行方法:[self performSelector:methodId withObject:nil];\n通过编号获取方法:NSString*methodName = NSStringFromSelector(methodId);\nIMP怎么获得和使用:IMP methodPoint = [self methodForSelector:methodId]; methodPoint();\n为什么要从SEL这个编号走一圈再回到函数指针呢:我们可以对一个编号和什么方法映射做些操作,也就是说我们可以一个SEL指向不同的函数指针，这样就可以完成一个方法名在不同时候执行不同的函数体。另外可以将SEL作为参数传递给不同的类执行";
}

+ (NSString *)运行时机制{
    return @"1、编译器会先将代码[obj  method]转化为objc_msgSend(obj, @selector (method))函数去执行。\n2、在objc_msgSend()函数中,首先通过obj的isa指针找到(对象)obj对应的(类)class。\n3、在class中会先去cache中 通过SEL查找对应函数method（cache中method列表是以SEL为key通过hash表来存储的，这样能提高函数查找速度），若 cache中未找到。再去class中的消息列表methodList中查找，若methodlist中未找到，则取superClass中查找。若能找到，则将method加 入到cache中，以方便下次查找，并通过method中的函数指针跳转到对应的函数中去执行\n运行时做什么:\n1、互换方法的实现\n2、动态添加方法\n3、动态添加属性\n4、获取类中所有的成员变量和属性";
}

+ (NSString *)KVO{
    return @"注册\n-(void)addObserver:(NSObject *)anObserver forKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options context:(void *)context\n实现方法\n-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context\n移除\n-(void)removeObserver:(NSObject *)observer forKeyPath:(NSString *)keyPath\nKVO是基于runtime机制实现的\n当某个类的属性对象第一次被观察时，系统就会在运行期动态地创建该类的一个派生类，在这个派生类中重写基类中任何被观察属性的setter 方法。派生类在被重写的setter方法内实现真正的通知机制\n如果原类为Person，那么生成的派生类名为NSKVONotifying_Person\n每个类对象中都有一个isa指针指向当前类，当一个类对象的第一次被观察，那么系统会偷偷将isa指针指向动态生成的派生类，从而在给被监控属性赋值时执行的是派生类的setter方法\n键值观察通知依赖于NSObject 的两个方法: willChangeValueForKey: 和 didChangevlueForKey:；在一个被观察属性发生改变之前， willChangeValueForKey:一定会被调用，这就 会记录旧的值。而当改变发生后，didChangeValueForKey:会被调用，继而 observeValueForKey:ofObject:change:context: 也会被调用";
}

+ (NSString *)Block{
    return @"struct Block_descriptor {\n    unsigned long int reserved;\n    unsigned long int size;\n    void (*copy)(void *dst，void *src);\n    void (*dispose)(void *);\n};\n\nstruct Block_layout{\n    void *isa;\n    int flags;\n    int reserved;\n    void (* invoke)(void *,...);\n    struct Block_descriptor *descriptor;\n};\n\nblock本质是对象，带有自动变量的匿名函数\n降低代码离散程度：多线程、定时器、回调传值、AFNetworking、SDWebImage\n\nblock分三种\nNSGlobalBlock 不会访问外部变量，内存在编译时确定在全局区，起到方法函数作用\nNSMallocBlock 可以访问外部变量，存放在堆区，引用计数为0时销毁\n访问外部变量分两种\n1.指针类型\nblock持有这个对象，并添加引用计数，外部修改会改变外部变量值\n2.非指针类型\n编译器在编译时期将外部变量值赋值给block内部变量，进行值拷贝，外部修改不会影响block内部变量值\nNSStackBlock 一般在MRC环境，默认创建在栈区 ARC下编译器会进行判断自动将block从栈复制到堆区(copy修饰)\n\n知识点\n__block 关键字修饰，使非指针类型可以改变内部变量值，实际是将值从栈中放到堆中\n__weak修饰的变量，可以解决循环引用，因为__weak修饰的对象不会增加引用计数\n为什么会在block内使用__strong修饰变量，MRC下block对象在传递到其他地方时不会释放引用的对象,ARC默认是copy，会自动将该对象拷贝到堆区，可以省略\n\nblock和函数指针的理解\n相似点\n函数指针和Block都可以实现回调的操作，声明上也很相似，实现上都可以看成是一个代码片段。\n函数指针类型和Block类型都可以作为变量和函数参数的类型\n不同点\n函数指针只能指向预先定义好的函数代码块，函数地址是在编译链接时就已经确定好的。\nBlock本质是Objective-C对象，是NSObject的子类，可以接收消息\n函数里面只能访问全局变量，而Block代码块不光能访问全局变量，还拥有当前栈内存和堆内存变量的可读性\n从内存的角度看，函数指针只不过是指向代码区的一段可执行代码，而block实际上是程序运行过程中在栈内存动态创建的对象，可以向其发送copy消息将block对象拷贝到堆内存，以延长其生命周期";
}

+ (NSString *)delegate跟block的区别{
    return @"代理:A对象设置协议和代理,并让B对象遵守协议和成为代理,从而让B对象实现协议方法\nblock的本质是指针函数, 内部封存的是代码块\ndelegate运行成本低，block的运行成本高\nblock出栈需要将使用的数据从栈内存拷贝到堆内存，当然对象的话就是引用计数加1，使用完或者block置nil后才销毁。delegate只是保存了一个对象指针(一定要用week修饰delegate，不然也会循环引用)，直接回调，没有额外消耗。就像C的函数指针，只多做了一个查表动作\nblock容易造成循环引用\block的代码可读性更好,block不需要声明协议，也不需要遵守协议，只需要声明属性和实现就可以了\nblock是一种轻量级的回调，可以直接访问上下文，由于block的代码是内联的，运行效率更高。block就是一个对象，实现了匿名函数的功能。所以我们可以把block当做一个成员变量、属性、参数使用，使用起来非常灵活。像用AFNetworking请求数据和GCD实现多线程，都使用了block回调\n使用场景：\n如果回调的状态(次数)很多，多于三个使用代理\n";
}

+ (NSString *)消息转发机制原理{
    return @"1、动态方法解析\n+(BOOL)resolveInstanceMethod:\n 2、备用接收者\n- (id)forwardingTargetForSelector:(SEL)aSelector\n 3、完整消息转发\n- (void)forwardInvocation:(NSInvocation *)anInvocation\n- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector";
}

+ (NSString *)几种传值方式{
    return @"1.属性传值\n2.方法(带参数)传值\n3.Block传值\n4.代理传值\n5.通知传值\n6.KVC传值\n7.KVO传值\n8.单例传值\n全局变量传值(extern)9.本地数据传值";
}

+ (NSString *)OC反射机制{
    return @"运行状态中，对于任意一个类，都能够知道这个类的所有属性和方法；对于任意一个对象，都能够调用它的任意一个方法；这种动态获取的以及动态调用对象的方法的功能就是反射机制。\n\n获得class\n1、FOUNDATION_EXPORT Class __nullable NSClassFromString(NSString *aClassName);\n2、调用某个类的class方法来获取。\n3、调用某个对象的class方法，该方法是NSObject类中的一个方法。\n检查继承关系\n1、isKindOfClass：\n2、isMemberOfClass：\n3、conformsToProtocol：\n\n\n// SEL、Class、Procotol和字符串转换NSObjCRuntime NS***from***\nNSString * NSStringFromSelector(SEL aSelector);\nSEL NSSelectorFromString(NSString *aSelectorName);\n// Class和字符串转换\nNSString * NSStringFromClass(Class aClass);\nClass NSClassFromString(NSString *aClassName);\n// Protocol和字符串转换\nFNSString * NSStringFromProtocol(Protocol *proto);\nProtocol * NSProtocolFromString(NSString *namestr);\n";
}

+ (NSString *)类方法和实例方法的区别{
    return @"类方法：\n1.类方法是属于类对象的\n2.类方法只能通过类对象调用3.类方法中的self是类对象4.类方法可以调用其他的类方法\n5.类方法中不能访问成员变量\n6.类方法中不能直接调用对象方法\n实例方法：\n1.实例方法是属于实例对象的\n2.实例方法只能通过实例对象调用\n3.实例方法中的self是实例对象\n4.实例方法可以调用其他的实例方法\n5.实例方法中可以访问成员变量\n6.实例方法中可以调用类方法";
}

+ (NSString *)排序{
    return @"冒泡排序\n原理\n1.比较相邻的元素。如果第一个比第二个大，就交换他们两个\n2.对每一对相邻元素做同样的工作，从开始第一对到结尾的最后一对。在这一点，最后的元素应该会是最大的数\n3.针对所有的元素重复以上的步骤，除了最后一个\n4.持续每次对越来越少的元素重复上面的步骤，直到没有任何一对数字需要比较\n1.空间复杂度 O(1)\n2.时间复杂度 O(n^2)\n3.最坏排序次数 n(n-1)/2\n4.最优时间复杂度 O(n)\nfor (int i = 0 ; i < arr.count - 1 ; i++){\n       for(j = 0 ; j < arr.count - 1 - i ; j++){\nif (arr[j] > arr[j+1]){\n[arr exchangeObjectAtIndex:j withObjectAtIndex:j+1];\n                }\n        }\n}\n\n\n选择排序：不稳定\n原理\n每一次从待排序的数据元素中选出最小（或最大）的一个元素，存放在序列的起始位置，直到全部待排序的数据元素排完\n1.空间复杂度 O(1)\n2.时间复杂度 O(n^2)\n3.最坏排序次数 n(n-1)/2\n4.最优时间复杂度 O(n^2)\nfor(int i = 0 ; i < arr.count ; i++){\n      for(j = i+1 ; j < arr.count ; j++){\n             if (arr[i] > arr[j]){\n                    [arr exchangeObjectAtIndex:i withObjectAtIndex:j];\n             }\n      }\n} ";
}

+ (NSString *)objc向nil对象发送消息{
    return @"结论：OC中向nil发消息，程序是不会崩溃的\nobjc在向一个对象发送消息时，runtime库会根据对象的isa指针找到该对象实际所属的类，然后在该类中的方法列表以及其父类方法列表中寻找方法运行，然后在发送消息的时候，objc_msgSend方法不会返回值，所谓的返回内容都是具体调用时执行的\n视方法返回值，向nil发消息可能会返回nil（返回值为对象），0（返回值为一些基础数据）或0X0（返回值为id）等";
}

+ (NSString *)类别能不能添加属性{
    return @"在分类里使用@property声明属性,但是没有生成相应的成员变量，也没有实现setter和getter方法\n根本原因:\ncategory 它是在运行期决议的。 因为在运行期即编译完成后，对象的内存布局已经确定\n类结构体中的 objc_ivar_list 实例变量的链表 和 instance_size 实例变量的内存大小已经确定\n\nobjc_setAssociatedObject(id _Nonnull object, const void * _Nonnull key,id _Nullable value, objc_AssociationPolicy policy)\nobjc_getAssociatedObject(id _Nonnull object, const void * _Nonnull key)";
}

+ (NSString *)lldb（gdb）常用的调试命令{
    return @"1.breakpoint 设置断点定位到某一个函数\n2.n断点指针下一步\npo打印对象";
}

+ (NSString *)进程与线程{
    return @"线程:\n线程是CPU调度（执行任务）的最小单位\n其实质就是一段代码（一个任务）\n进程:\n系统中正在运行的一个应用程序\n进程是CPU分配资源和调度的单位\n两者的联系与区别\n线程是进程的组成部分，一个进程可以开启多个子线程，但是每1个进程至少要有1个线程\n1个进程的所有任务都是在线程中执行的\n同1个进程内的线程共享进程的资源";
}

+ (NSString *)多线程{
    return @"原理:多个线程并发执行，其实质是CPU快速地在多条线程之间调度（切换）\n当CPU调度线程的时间足够快，就会造成多线程并发执行的假象\n优点\n能适当地提高程序的执行效率\n能适当提高资源利用率（CPU和内存利用率）\n缺点\n创建多线程是有开销的，包括内存空间和创建时间上的开销\n如果开启大量线程，会降低程序的性能\n线程越多，CPU在调度线程上的开销就越大\n\n\n四种多线程\nNSThread,NSOperation,GCD\n1.NSThread\n优点：NSThread 比其他两个轻量级。\n缺点：需要自己管理线程的生命周期，线程同步。(线程同步对数据的加锁会有一定的系统开销)\n2.NSOperation\n优点:不需要关心线程管理， 数据同步的事情，可以把精力放在自己需要执行的操作上。\n添加操作之间的依赖关系，方便的控制执行顺序\n可以很方便的取消一个操作的执行\n使用 KVO 观察对操作执行状态的更改：isExecuteing、isFinished、isCancelled。\n缺点:相比GCD，开销比大，运行慢\nGCD\n优点：GCD主要与block结合使用。代码简洁高效\nGCD更接近底层\nGCD 会自动利用更多的 CPU 内核\nGCD 会自动管理线程的生命周期（创建线程、调度任务、销毁线程）\n缺点：从异步操作之间的事务性，顺序行，依赖关系。GCD需要自己写更多的代码来实现，而NSOperationQueue已经内建了这些支持\n可能会出现线程死锁";
}

+ (NSString *)GCD{
    return @"GCD的使用\n1.创建一个队列：串行队列或并发队列\ndispatch_queue_create(const char *,dispatch_queue_attr_t)\n第一个参数表示队列的唯一标识符\n第二个参数标识串行队列DISPATCH_QUEUE_SERIAL(实际就是NULL)或并发队列DISPATCH_QUEUE_CONCURRENT\ndispatch_get_main_queue()主队列\ndispatch_get_global_queue(long identifier,unsigned long flags)\n\n2.将任务添加到队列中，同步或异步来执行任务\n\n同步dispatch_sync\n1串行队列：没有开启新线程，串行执行任务\n并发队列：没有开启新线程，串行执行任务\n主队列：主线程调用死锁 其他线程调用不开启新线程\n异步dispatch_async\n串行队列：开启1条新线程，串行执行任务\n并发队列：开启新线程，并行执行任务\n主队列：没有开启新线程，串行执行任务\n\n线程间的通信\ndispatch_async(dispatch_get_main(),^{})\n\n延时执行\ndispatch_after(dispatch_time(DISPATCH_TIME_NOW,(int 64_t)(1 *NSEC_PER_SEC)),dispatch_get_main_queue(),^{})\n\n执行一次，多线程安全\nstatic dispatch_once_t onceToken\ndispatch_once(&onceToken,^{})\n\n快速迭代\ndispatch_apply(10,dispatch_queue_t,^(size_t index){})\n\n栅栏：执行完第一组任务后执行第二组\ndispatch_barrier_async(queue,^{})\n\n队列组使用\ndispatch_group_create()\ndispatch_group_async(dispatch_group_t,dispatch_queue_t,^{})\ndispatch_group_notify(dispatch_group_t,dipatch_queue_t,^{})\ndispatch_group_wait(dispatch_group_t,dispatch_time_t)\ndispatch_group_enter(dispatch_group_t)\ndispatch_group_leave(dispatch_group_t)\n\n信号量dispatch_semaphore\ndispatch_semaphore_create(long value)\ndipatch_semaphore_signal(dispatch_semaphore_t)\ndispatch_semaphore_wait(dispatch_semaphore,dispatch_time_t)\n\nGCD的介绍\nGCD与block相结合,代码看上去简洁,性能更接近底层,会自动调用更多的CPU内核,自动管理线程的生命周期(自动调度任务、自动销毁线程),FIFO(先进先出，后进后出)\n线程之间存在依赖,代码实现变得复杂,对线程的管理(开始，取消)无法处理";
}

+ (NSString *)NSOperation{
    return @"NSOperation是基于GCD更高一层的封装,NSOperation可以简单设置依赖关系,用KVO监听完成、取消、开始、挂起等状态,设置任务之间的优先级,设置线程的最大并发数\n\nNSOperation需要配合NSOperationQueue来实现多线程。因为默认情况下，NSOperation单独使用时系统同步执行操作，并没有开辟新线程的能力，只有配合NSOperationQueue才能实现异步执行\n\nNSOperation的使用\n创建任务,创建队列,将任务加入到队列中\n\n1.创建任务\n使用子类NSInvocationOperation\n使用子类NSBlockOperation\n定义继承自NSOperation的子类\n以上方法不添加到队列中，都是主线程执行，除了使用NSBlockOperation 的addExecutionBlock操作\n\n2.创建队列\n主队列:主线程中执行\n其他队列:串行、并发功能\n3.将任务加入到队列中\n当maxConcurrentOperationCount为1时，进行串行执行,大于1时，进行并发执行\n4.操作依赖：addDependency\n4.优先级：queuePriority\n5.线程堵塞：waitUntilFinished\nwaitUntilAllOperationsAreFinished";
}


+ (NSString *)NSTimer{
    return @"使用：创建，添加到runloop\n问题：\n1.需要添加到runloop，否则不会运行\n2.添加的runloop模式不对也是不会运行的\n3.runloop会对timer有强引用，timer会对目标对象进行强引用\n4.timer的执行时间并不准确(基本是毫秒妙级别以下的延迟)\n\n系统提供了8个创建方法，6个类创建方法，2个实例初始化方法\n+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;\n+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;\n+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;\n这三个类方法添加到当前runloop，模式是default mode\n\n+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;\n+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti invocation:(NSInvocation *)invocation repeats:(BOOL)yesOrNo;\n+ (NSTimer *)timerWithTimeInterval:(NSTimeInterval)ti target:(id)aTarget selector:(SEL)aSelector userInfo:(id)userInfo repeats:(BOOL)yesOrNo;\n- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)ti target:(id)t selector:(SEL)s userInfo:(id)ui repeats:(BOOL)rep;\n- (instancetype)initWithFireDate:(NSDate *)date interval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer *timer))block;\n上面五种创建，不会自动添加到runloop，还需调用addTimer:forMode:\n\n一个timer可以被添加到runloop的多个模式，比如在主线程中runloop一般处于NSDefaultRunLoopMode，而当滑动屏幕的时候，比如UIScrollView或者它的子类UITableView、UICollectionView等滑动时runloop处于UITrackingRunLoopMode模式下，因此如果你想让timer在滑动的时候也能够触发，就可以分别添加到这两个模式下。或者直接用NSRunLoopCommonModes一个模式集，包含了上面的两种模式\n\n内存泄露问题：\n互相持有的关系,在NSTimer机制下对Target持有的方式使用的是autorelease的方式,也就是说target会在runloop下一次执行的时候查看这块区域是否进行释放,这也就能解释为什么我们如果将repeats属性设置成NO内存可以释放的原因,以及为什么将self设置成nil后内存依然不释放的原因\n解决方案：及时的调用invalidate方法，使用block回调的方式";
}

+ (NSString *)网络七层协议{
    return @"1.应用层 示例：HTTP\n与其它计算机进行通讯的一个应用，它是对应应用程序的通信服务的\n\n2.表示层 示例：加密，ASCII\n这一层的主要功能是定义数据格式及加密\n\n会话层\n它定义了如何开始、控制和结束一个会话，包括对多个双向消息的控制和管理，以便在只完成连续消息的一部分时可以通知应用，从而使表示层看到的数据是连续的\n\n传输层 示例：TCP，UDP\n这层的功能包括是否选择差错恢复协议还是无差错恢复协议，及在同一主机上对不同应用的数据流的输入进行复用，还包括对收到的顺序不对的数据包的重新排序功能\n\n网络层 示例：IP\n这层对端到端的包传输进行定义，它定义了能够标识所有结点的逻辑地址，还定义了路由实现的方式和学习的方式\n\n数据链路层\n它定义了在单个链路上如何传输数据\n\n物理层\nOSI的物理层规范是有关传输介质的特这些规范通常也参考了其他组织制定的标准";
}

+ (NSString *)HTTP{
    return @"URL：全称是Uniform Resource Locator（统一资源定位符）\nURL基本格式=协议://主机地址/路径\nURL常见协议：\n1.HTTP 超文本传输协议，访问的是远程的网络资源，格式是http://\n2.file 访问的是本地计算机上的资源，格式是file://（不用加主机地址）\n3.mailto 访问的是电子邮件地址，格式是mailto:\n4.FTP 访问的是共享主机的文件资源，格式是ftp://\n\nHTTP协议的作用\n（1）规定客户端和服务器之间的数据传输格式\n（2）让客户端和服务器能有效地进行数据沟通\n优点\n（1）简单快速  因为HTTP协议简单，所以HTTP服务器的程序规模小，因而通信速度很快\n（2）灵活  HTTP允许传输任意类型的数据\n（3）每次连接只处理一个请求，服务器对客户端的请求做出响应后，马上断开连接，这种方式可以节省传输时间\n\nHTTP的通信过程：请求和响应数据\n1.HTTP通信过程 - 请求\n请求行：包含了请求方法、请求资源路径、HTTP协议版本\nGET /MJServer/resources/images/1.jpg HTTP/1.1\n请求头：包含了对客户端的环境描述、客户端请求的主机地址等信息\nHost: 192.168.1.105:8080 // 客户端想访问的服务器主机地址\nUser-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9) Firefox/30.0// 客户端的类型，客户端的软件环境\nAccept: text/html, */*// 客户端所能接收的数据类型\nAccept-Language: zh-cn // 客户端的语言环境\nAccept-Encoding: gzip // 客户端支持的数据压缩格式\n请求体：客户端发给服务器的具体数据，比如文件数据\n2.HTTP通信过程 - 响应\n状态行：包含了HTTP协议版本、状态码、状态英文名称\nHTTP/1.1 200 OK\n响应头：包含了对服务器的描述、对返回数据的描述\nServer: Apache-Coyote/1.1 // 服务器的类型\nContent-Type: image/jpeg // 返回数据的类型\nContent-Length: 56811 // 返回数据的长度\nDate: Mon, 23 Jun 2014 12:54:52 GMT // 响应的时间\n实体内容：服务器返回给客户端的具体数据，比如文件数据 \n\n常见的响应状态码\n200  OK  请求成功\n400  Bad Request  客户端请求的语法错误，服务器无法解析\n404  Not Found  服务器无法根据客服的请求找到资源\n500  Internal Server Error  服务器内部错误，无法完成请求\n\n8种发送http请求的方法：GET、POST、OPTIONS、HEAD、PUT、DELETE、TRACE、CONNECT、PATCH\nGET在请求URL后面以?的形式跟上发给服务器的参数，多个参数之间用&隔开\n\nhttps比http多一个SSL（安全套接字层）";
}

+ (NSString *)TCP和UDP{
    return @"TCP：可靠 稳定\nTCP的可靠体现在TCP在传输数据之前，会有三次握手来建立连接，而且在数据传递时，有确认. 窗口. 重传. 拥塞控制机制，在数据传完之后，还会断开来连接用来节约系统资源。\n缺点：慢，效率低，占用系统资源高，易被攻击\n\nUDP：快，比TCP稍安全\nUDP没有TCP拥有的各种机制，是一种无状态的传输协议，所以传输数据非常快，没有TCP的这些机制，被攻击利用的机会就少一些，但是也无法避免被攻击,UDP支持一对一，一对多，多对一和多对多的交互通信\n缺点：不可靠，不稳定,容易丢包，造成数据的缺失\n\n适用场景：\nTCP：当对网络质量有要求时，比如HTTP，HTTPS，FTP等传输文件的协议；POP，SMTP等邮件传输的协议\nUDP：对网络通讯质量要求不高时，要求网络通讯速度要快的场景";
}

+ (NSString *)字典实现原理{
    return @"Objective-C中的字典NSDictionary底层其实是一个哈希表,hash表来实现key和value之间的映射和存储的\n哈希原理\n散列表（Hash table，也叫哈希表），是根据关键码值(Key value)而直接进行访问的数据结构。也就是说，它通过把关键码值映射到表中一个位置来访问记录，以加快查找的速度。这个映射函数叫做散列函数，存放记录的数组叫做散列表。\n哈希概念:哈希表的本质是一个数组，数组中每一个元素称为一个箱子(bin)，箱子中存放的是键值对。\n哈希存储过程\n1.根据 key 计算出它的哈希值 h。\n2.假设箱子的个数为 n，那么这个键值对应该放在第 (h % n) 个箱子中。\n3.如果该箱子中已经有了键值对，就使用开放寻址法或者拉链法解决冲突\n哈希表还有一个重要的属性: 负载因子(load factor)，它用来衡量哈希表的空/满程度，一定程度上也可以体现查询的效率，计算公式为:负载因子 = 总键值对数 / 箱子个数\n\n1.如果哈希表中本来箱子就比较多，扩容时需要重新哈希并移动数据，性能影响较大。\n2.如果哈希函数设计不合理，哈希表在极端情况下会变成线性表，性能极低。";
}

+ (NSString *)预编译指令{
    return @"#if                 编译预处理中的条件命令，相当于C语法中的if语句\n#ifdef            判断某个宏是否被定义，若已定义，执行随后的语句\n#ifndef          与#ifdef相反，判断某个宏是否未被定义\n#elif                若#if, #ifdef, #ifndef或前面的#elif条件不满足，则执行#elif之后的语句，相当于C语法中的else-if\n#else            与#if, #ifdef, #ifndef对应, 若这些条件不满足，则执行#else之后的语句，相当于C语法中的else\n#endif           #if, #ifdef, #ifndef这些条件命令的结束标志.\ndefined        与#if, #elif配合使用，判断某个宏是否被定义";
}

+ (NSString *)数据持久化{
    return @"功能：主要是将数据持久化到本地，减少对网络请求的次数，既节省了用户的流量，也增强了App的体验效果\n\n种类：\n1.plist：键值对\n2.偏好存储：配置信息\n3.归档序列化存储：二进制序列化持久化\n4.沙盒存储：Document目录存储非机密数据，比如图片，音频，视频等\n5.本地数据库存储：存储大数据\n\nplist存储\n能存储NSString、NSArray、NSDictionary、NSData、NSDate、NSNumber、Boolean,常用于存储长时间不容易发生变化的数据，例如省市列表\n缺点：不能存储自定义对象,读写需要取出整个plist文件\n\n偏好存储\n可以存储OC定义的所有数据类型,保存到Library/Preferences目录下的plist 文件,常用于存储用户名、密码、字体大小等设置\n缺点：读写需要取出整个plist文件\n\n归档序列化存储\n存储遵循NSCoding协议的类的实例对象,存储到.archive的文件\n缺点：读写需要取出整个文件\n\nDocument沙盒存储\nApplication：存放程序源文件，上架前经过数字签名，上架后不可修改\nDocuments: 保存应⽤运行时生成的需要持久化的数据,iTunes同步设备时会备份该目录\ntmp: 保存应⽤运行时所需的临时数据,使⽤完毕后再将相应的文件从该目录删除\nLibrary/Caches: 保存应用运行时⽣成的需要持久化的数据,iTunes同步设备时不会备份该目录\nLibrary/Preference: 保存应用的所有偏好设置，iTunes同步设备时会备份该目录\n\n本地数据库存储\n通过表进行数据存储的方式,常用Sqlite、CoreData、FMDB,大数据量的存储,查询速度快";
}

+ (NSString *)NSUserDefault和encode{
    return @"数据存储\n\n[NSUserDefaults standardUserDefaults]\nset***:forKey:\n***可以是基础类型、NSURL、id、NSInteger\n- (BOOL)synchronize\n- (void)removeObjectForKey:(NSString *)defaultName\n\n归档<coding>\n- (void)encodeWithCoder:(NSCoder *)aCoder//编码\n- (instancetype)initWithCoder:(NSCoder *)aDecoder//解码\n\nNSKeyedArchiver和NSKeyedUnarchiver\n\n+ (NSData *)archivedDataWithRootObject:(id)rootObject\n+ (BOOL)archiveRootObject:(id)rootObject toFile:(NSString *)path\n\n+ (id)unarchiveObjectWithData:(NSData *)data\n+ (id)unarchiveObjectWithFile:(NSString *)path";
    
}

+ (NSString *)CoreData{
    return @"对SQLite的一个封装，ORM(对象-关系映射)\n\n创建模型文件：系统创建或者自己创建\n创建工程，勾选 use Core date 或 创建文件，选择 Data Model\n在#name.xcdatamodeld创建项目中需要用到的实体（Add Entity)\n添加属性并设置类型\n创建获取请求模板、设置配置模板等\n\n生成上下文 关联数据库\nNSManagedObjectContext 管理对象，上下文，持久性存储模型对象，处理数据与应用的交互\nNSManagedObjectModel 被管理的数据模型，数据结构\nNSPersistentStoreCoordinator 添加数据库，设置数据存储的名字，位置，存储方式\nNSManagedObject 被管理的数据记录\nNSFetchRequest 数据请求\nNSEntityDescription 表格实体结构\n\n数据库创建\n1.创建模型对象\n2、创建持久化存储助理\n3.创建上下文,关联持久化助理\n";
}

+ (NSString *)FMDB{
    return @"FMDB是针对libsqlite3框架进行封装的三方\nFMDB的优点：\n面向对象，避免了复杂的C语言代码\n比Core Data框架，更加轻量级和灵活\n多线程安全跟数据准确性\n\n使用示例\n1.建库 [FMDatabase databaseWithPath:#path];\\一般存在沙盒Document\n2.数据库是否open [db open]\n3.建表(sql语句) create table if not exists Student ('ID' INTEGER PRIMARY KEY AUTOINCREMENT,'name' TEXT NOT NULL, 'phone' TEXT NOT NULL,'score' INTEGER NOT NULL) \n4.执行更新操作 [db executeUpdate:#sql] 判断创建表是否成功//增删改查中 除了查询（executeQuery 返回FMResultSet），其余操作都用（executeUpdate 返回BOOL）\n5. 插入命令sql语句 insert into 'Student'(ID,name,phone) values(?,?,?)\n6.更新命令sql语句 update 'Student' set ID = ? where name = ?\n7.查询命令sql语句 select * from 'Student' where ID = ?\n\nFMDB的事务\n原子性（Atomic）：事务中包含的一系列操作被看作一个逻辑单元，这个逻辑单元要不全部成功，要不全部失败\n一致性（Consistency）：事务中包含的一系列操作，只有合法的数据被写入数据库，一些列操作失败之后，事务会滚到最初创建事务的状态\n隔离性（Isolation）：对数据进行修改的多个事务之间是隔离的，每个事务是独立的，不应该以任何方式来影响其他事务\n持久性（Durability）事务完成之后，事务处理的结果必须得到固化，它对于系统的影响是永久的，该修改即使出现系统固执也将一直保留，真实的修改了数据库\n开启事务 ：beginTransaction\n回滚事务：rollback\n提交事务：commit";
}

+ (NSString *)App性能监控{
    return @"APP的性能监控包括：CPU占用率、内存使用情况、网络状况监控、卡顿、使用时崩溃、耗电量监控、流量监控等等\n\n1.CPU\nCPU持续高负载运行，将会出现APP卡顿、手机发热发烫、电量消耗过快等等严重影响用户体验的现象\n获取CPU的占有率\n计算当前Mach Task下所有线程占用CPU的情况，内核提供了task_threads API 调用获取指定task的线程列表，然后可以通过thread_info API获得定线程的信息，通过thread_basic_info_t结构体获得用户和系统的运行时间、运行状态和调度优先级等\n\n2.内存\n内存过高造成闪退\nMach task 的内存使用信息存放在mach_task_basic_info结构体中 ，其中resident_size 为应用使用的物理内存大小，virtual_size为虚拟内存大小\n\n启动时间\n1.main()函数执行之前\n删减一些无用的静态变量\n删减没有被调用到或者已经废弃的方法\n将不必须在+load方法中做的事情延迟到+initialize中\n尽量不要用C++虚函数(创建虚函数表有开销)\n2.main()函数执行之后\n尽量使用纯代码编写，减少xib的使用\n启动阶段的网络请求，是否都放到异步请求\n一些耗时的操作是否可以放到后面去执行，或异步执行等\n\n卡顿\n现在的手机设备基本都是采用双缓存+垂直同步（即V-Sync）屏幕显示技术\n系统内CPU、GPU和显示器是协同完成显示工作的。其中CPU负责计算显示的内容，例如视图创建、布局计算、图片解码、文本绘制等等。随后CPU将计算好的内容提交给GPU，由GPU进行变换、合成、渲染。GPU会预先渲染好一帧放入一个缓冲区内，让视频控制器读取，当下一帧渲染好后，GPU会直接将视频控制器的指针指向第二个容器（双缓存原理）\n卡顿原因\n系统内CPU、GPU和显示器是协同完成显示工作的。其中CPU负责计算显示的内容，例如视图创建、布局计算、图片解码、文本绘制等等。随后CPU将计算好的内容提交给GPU，由GPU进行变换、合成、渲染。GPU会预先渲染好一帧放入一个缓冲区内，让视频控制器读取，当下一帧渲染好后，GPU会直接将视频控制器的指针指向第二个容器（双缓存原理）\n\n1.FPS\nFrames Per Second 的简称缩写，意思是每秒传输帧数,每秒钟帧数愈多，所显示的画面就会愈流畅,一定程度上可以衡量应用在图像绘制渲染处理时的性能\nCADisplayLink 是一个用于显示的定时器， 它可以让用户程序的显示与屏幕的硬件刷新保持同步，iOS系统中正常的屏幕刷新率为60Hz（60次每秒）。CADisplayLink可以以屏幕刷新的频率调用指定selector，也就是说每次屏幕刷新的时候就调用selector，那么只要在selector方法里面统计每秒这个方法执行的次数，通过次数/时间就可以得出当前屏幕的刷新率了。\n2.主线程卡顿监控\n通过采用检测主线程每次执行消息循环的时间，当这一时间大于规定的阈值时，就记为发生了一次卡顿的方式来监控(美团Hertz方案，)\n开辟一个子线程，然后实时计算 kCFRunLoopBeforeSources 和 kCFRunLoopAfterWaiting 两个状态区域之间的耗时是否超过某个阀值，来断定主线程的卡顿情况";
}

+ (NSString *)MLeaksFinder{
    return @"app 的内存分三类：\nLeaked memory: Memory unreferenced by your application that cannot be used again or freed (also detectable by using the Leaks instrument)\n泄漏内存:应用程序未引用的内存，不能再次使用或释放(也可以通过泄漏工具检测到)\nAbandoned memory: Memory still referenced by your application that has no useful purpose.\n废弃内存:应用程序仍然引用的内存，没有任何用途。\nCached memory: Memory still referenced by your application that might be used again for better performance.\n缓存内存:仍然由应用程序引用的内存，可以再次使用以获得更好的性能。\nLeaks 负责检测 Leaked memory,Allocations 负责检测Abandoned memory\n\nMLeaksFinder无需修改任何业务逻辑代码,只在 debug 下开启,操作简单,确定哪个对象没被释放\n\n原理：在一个 ViewController 被 pop 或 dismiss 一小段时间后，看看该 UIViewController，它的 view，view 的 subviews 等等是否还存在。\n实现：\n为基类 NSObject 添加一个方法 -willDealloc 方法，该方法的作用是，先用一个弱指针指向 self，并在一小段时间(3秒)后，通过这个弱指针调用 -assertNotDealloc，而 -assertNotDealloc 主要作用是直接中断言,当我们认为某个对象应该要被释放了，在释放前调用这个方法，如果3秒后它被释放成功，weakSelf 就指向 nil，不会调用到 -assertNotDealloc 方法，也就不会中断言\n\n问题：\n1.例外机制(比如单例),重载上面的 -willDealloc 方法，直接 return NO 即可\n2.系统View,建立白名单\n3.手动扩展,目前只检测 ViewController 跟 View 对象。";
}

+ (NSString *)MVC和MVVM{
    return @"MVC:简单来说就是，逻辑、试图、数据进行分层，实现解耦。\nMVVM:是Model-View-ViewMode模式的简称.将一部分逻辑(耗时，公共方法，网络请求等)和数据的处理等操作从控制器里面搬运到ViewModel中\n\nMVVM的特点：\n1.低耦合\n2.可重用性\n3.独立开发\n4.可测试性";
}

+ (NSString *)autoreleasepool{
    return @"autoreleasepool管理内存，程序执行时，若某自动变量超出其作用域，该自动变量将被自动废弃\n\n何时释放：autorelease对象是在当前的runloop迭代结束时释放\n\n原理：\n@autoreleasepool 使用clang编译之后,被转换成__AtAutoreleasePool 结构体类型,__AtAutoreleasePool() 构造函数调用objc_autoreleasePoolPush(),~__AtAutoreleasePool() 析构函数调用 objc_autoreleasePoolPop(),每当自动释放池调用objc_autoreleasePoolPush时都会把边界对象放进栈顶,然后返回边界对象,用于释放。";
}

+ (NSString *)野指针定位{
    return @"野指针：指针指向的对象被释放或者收回，该指针仍旧指向已经回收的内存地址\n\n特点：\n1.随机性强\n野指针指向的内存被覆盖（正常、依赖的对象被删除、逻辑问题）和没有被覆盖（对象可以被访问（消息转发机制unrecognized selector、逻辑问题、非法访问等）和对象不可以被访问（objc_msgSend、线程问题、非法指令等））\n2.难以定位：野指针多数来自C语言层面，获得只有系统栈信息\n\n定位：\n1.重现用户使用场景，辅助设备信息、用户行为等信息\n2.edit scheme->run->Diagnostics\nMalloc Scribble对已释放内存进行数据填充,保证野指针访问是必然崩溃\nZombie(造币) Objects，将释放的对象标记为Zombie对象，再次给Zombie对象发送消息时，发生crash并且输出相关的调用信息\n\n3. 解决思路\n1.FJFZombieSnifferDemo\n替换C函数的free方法为自身方法safe_free,然后在safe_free方法中对已经释放变量的内存，填充0x55，使已经释放变量不能访问，从而使某些野指针从不必现Crash变成了必现.为了防止系统内存过快耗尽,我们需要在自己保留的内存大于一定值的时候就释放一部分，防止被系统杀死。同时在系统内存警告的时候，也要释放一部分内存。引入了一个代理类MOACatcher继承自NSProxy，同时MOACatcher持有一个originClass，重写消息转发的三个方法以及NSObject的实例方法，来进行异常信息的打印\n\n2.LXDZombieSniffer\n通过objc的runtime方法进行方法交换，交换了根类的NSObject和NSProxy的dealloc方法为originalDeallocImp.为了避免 内存空间释放之后被复写造成野指针问题，通过字典_rootClassDeallocImps存储被释放的对象，同时设置在30秒之后调用dealloc方法将存储的对象释放，避免内存空间的增大.崩溃信息采用重写消息转发方法以及内存管理相关的方法.";
}

+ (NSString *)字段符号的含义{
    return @"空指针\nnil：指向oc中对象的空指针\nNil：指向oc中类的空指针\nNULL：指向其他类型的空指针，如一个c类型的内存指针\nNSNull：在集合对象中，表示空值的对象\n\n定义宏\n#define 定义一个预处理宏\n#undef 取消宏的定义\n#include 包含文件命令\n#if 预编译处理中的条件命令，相当于C语法中的if语句\n#ifdef 判断某个宏是否被定义，若已定义，执行随后的语句\n#ifndef 与#ifdef相反\n#elif 若#if,#ifdef,#ifndef或前面的#elif条件不满足，则执行#elif之后的语句，相当于C语法中的else-if\n#else 相当于C语法中的else\n#endif #if,#ifdef,#ifndef这些条件命令的结束标志\n#defined 与#if,#elif配合使用,判断某个宏是否被定义\n#line 标志该语句所在的行号\n# 将宏参数代替为以参数值为内容的字符串常亮\n## 将两个相邻的标记（token）连接为一个单独的标记\n#pragma 说明编译器信息\n#warning 显示编译警告信息\n#error 显示编译错误信息\n\n系统宏方法\n__COUNTER__ 无重复的计数器，从程序启动开始每次调用都会++,常用语宏中定义无重复的参数名称\n__FILE__ 当前文件的绝对路径\n__LINE__ 展开该宏时在文件中的行数\n__func__ 所在scope的函数名称\n__FUNCTION__ 当前函数名称\n__DATE__ 编译日期的字符，eg:Sep 20 2018\n__TIME__ 编译时间的字符，eg:14:15:59\n\n版本宏\n**NS_AVAILABLE_IOS(5_0) **\n这个方法可以在iOS5.0及以后的版本中使用，如果在比5.0更老的版本中调用这个方法，就会引起崩溃。\nNS_DEPRECATED_IOS(2_0, 6_0)\n这个宏中有两个版本号。前面一个表明了这个方法被引入时的iOS版本，后面一个表明它被废弃时的iOS版本。被废弃并不是指这个方法就不存在了，只是意味着我们应当开始考虑将相关代码迁移到新的API上去了。\nNS_AVAILABLE(10_8, 6_0)\n这个宏告诉我们这方法分别随Mac OS 10.8和iOS 6.0被引入。\nNS_DEPRECATED(10_0, 10_6, 2_0, 4_0)\n这个方法随Mac OS 10.0和iOS 2.0被引入，在Mac OS 10.6和iOS 4.0后被废弃。\nNS_CLASS_AVAILABLE(10_11, 9_0)\n这个类分别随Mac OS 10.11和iOS9.0被引入。\nNS_ENUM_AVAILABLE(10_11, 9_0)\n这个枚举分别随Mac OS 10.11和iOS9.0被引入。\n\n浮点型转整型\nint(f)  floor(f)  向下取整\nceil(f)  向上取整\n\n路径截取操作,eg xxx/name.jpg\n[string lastPathComponent] name.jpg\n[string stringByDeletingLastPathComponent] xxx\n[string pathExtension] jpg\n[string stringByDeletingPathExtension] name.jpg";
}

+ (NSString *)app的生命周期{
    return @"application:willFinishLaunchingWithOptions\n处理应用状态的存储和恢复\n\napplication:didFinishLaunchingWithOptions\n程序启动时调用的函数\n\napplicationDidBecomeActive\n应用在准备进入前台运行\n\napplicationWillResignActive\n应用当前正要从前台运行状态离开\n\napplicationDidEnterBackground\n进入后台，将进入挂起状态\n\napplicationWillEnterForeground\n当前应用正从后台移入前台运行状态\n\napplicationWillTerminate\n当前应用即将被终止";
}

+ (NSString *)AFNetworking{
    return @"AFNetworking由五个模块组成：\nNSURLSession 网络通信模块\nAFURLSessionManager和AFHTTPSessionManager\nSecurity 网络通讯安全模块\nAFSecurityPolicy\nReachability 网络状态监听模块\nAFNetworkReachabilityManager\nSerialization 网络通信信息序列化、反序列化模块\nAFURLResponseSerialization\nUIKit\n\nNSURLSession\n由NSURLSession、NSURLSessionConfiguation、NSURLSessionTask三个基本模块构成。NSURLSession相当于通信中的会话,但本身不进行网络数据传输,在多个NSURLSessionTask执行网络请求\nNSURLSession的行为取决于三个方面,NSURLSession的类型、NSURLSessionTask的类型和创建task的app是否处于前端\ndefaultSession将cache和creditials储存于本地\nEphemeral Session对数据更加保密安全，并不会向本地储存任何数据，并和Session绑定，当Session销毁时，对应的数据也会被销毁\nbackgroundSession可以使app在后台继续数据传输,其行为和defaultSession差不多,数据传输由一个非本app的进程来管理\nSession一但配置后，就不能修改，除非重新创建\nNSURLSessionTask分别为NSURLSessionDataTask、NSURLSessionDownLoadTask、NSURLSessionUploadTask\n所有的task状态都是暂停的，需要【task resume】启动\nNSURLSession可以通过delegate或者block回调数据\nNSURLSession对象的销毁有两种\n-(void)invalidateAndCancel 取消该session中所有task,销毁delegate、block、session\n-(void)finishTaskAndInvalidate 不会取消已启动的task\nsession加快了网络访问速度，同一个session中的task不需要重复实现三次握手\n\n\n网络请求的过程\n创建NSURLSessionConfig对象,初始化NSURLSession,创建NSURLSessionTask对象执行resume,使用delegate或者block\nAFURLSessionManager分装了这个过程,初始化AFURLSessionManager,获取AFURLSessionManager的task对象,启动task";
}

+ (NSString *)加密{
    return @"MD5加密\nMD5加密的特点：\n1.不可逆运算\n2.加密后的长度32位\n3.相同的数据，加密结果一致\n4.修改一个字节结果变化很大\n5.不同的数据,拥有相同的md5值可能性是很小的\n\n加盐\n加长字符串的长度,使md5破解更复杂\n\nSHA加密（安全哈希算法）主要适用于数字签名标准里面定义的数字签名算法,SHA会产生一个消息摘要\n特性：不可以从消息摘要中复原消息,两个不同的消息不会产生同样的消息摘要\n\nHMAC加密\n给定一个密钥，对明文加密，做两次散列,密钥是服务器生成,客户端请求获得key\n已注册为例：当用户把账号提交给服务器,服务器验证账号的合法性,合法生成一个key(key只在注册的时候出现,一个账号对应一个key),客户端将key用HMAC加密后发给服务器,服务器保存这个密码,下次登录去比对\n将生成的HMAC的密码加上服务器时间（年月日时分）,然后md5加密去比对,更加安全\n\n对称加密\n对称加密算法又称传统加密算法\n加密和解密使用的是同一个密钥\n明文->密钥加密->密文,密文->密钥解密->明文\n特性：计算量小,速度快,效率高,但同样的密钥使安全得不到保证\n注意事项：密钥的保密,密钥的定期更换\nDES数据加密标准(可暴力破解)\n3DES使用3次密钥(维护成本高)\nAES高级加密标准,目前美国安全局和苹果store使用的加密方法,公认最安全的加密方式\n加密模式：ECB和CBC(推荐)\n\n非对称加密RSA\n如果对公钥加密,只有使用私钥才能解密,若果对私钥加密,只有对公钥才能解密\n特点：算法复杂,速度慢，效率低\n";
}


+ (NSString *)内存分配{
    return @" 内存分配：栈区、堆区、全局区、常量区、代码区\n\n栈区：\n静态和动态分配，静态分配在编译时由编译器分配，动态分配由alloca函数创建，释放都是编译器完成。先进后出\n基础数据类型、函数内局部变量（非静态）、栈block\n内存大小固定1M,地址由高到低\n\n堆区：\n动态分配，由malloc、new、alloc创建的对象\n如果程序没有释放，存在内存泄露、溢出问题\n内存分配方式：链表存储空闲地址，链表遍历由低到高\n1.系统记录一个空闲的地址链表\n2.当系统收到内存申请，会遍历链表，寻找第一个控件大于等于申请空间的堆节点，将该节点从表中删除\n堆节点的大小如果大于申请的内存大小，多余的堆节点重新放入表中\n\n全局区\n内存大小在编译时确定，程序运行是一直存在，程序结束，系统释放\n初始化和未初始化的全局变量和静态变量在相邻区域\n静态数据、全局数据、常量 const、static\n\n常量区：\n常量字符串存储位置\n\n代码区：\n函数的二进制代码\n\niOS是基于UNIX、Android是基于Linux的";
}

+ (NSString *)transform{
    return @"transform通常与UIView一起用\n\nview.transform使用CGAffineTransform\nview.layer.transform使用CATransform3D\n\n1.平移\nx,y,z代表坐标轴方向，t代表另一个动画\nMake区别动画是否叠加\nCGAffineTransformMakeTranslation(x,y)\nCGAffineTransformTranslate(t,x,y)\nCATransform3DMakeTranslation(x,y,z)\nCATransform3DTranslate(t,x,y,z)\n\n2.缩放\nCGAffineTransformMakeScale(x,y)\nCGAffineTransformScale(t,x,y)\nCATransform3DMakeScale(x,y)\nCATransform3DScale(t,x,y)\n\n3.旋转\nCGAffineTransformMakeRotation(angle)\nCGAffineTransformRotate(t,angle)\nCATransform3DMakeRotation(angle,x,y,z)\nCATransform3DRotate(t,angle,x,y,z)";
}

+ (NSString *)CAAnimation{
    return @"核心动画\n少量代码，功能强大\n动画执行在后台，不堵塞主线程\n直接操作在CALayer层\n\nCALayer负责图层绘制，UIView负责展示\n每一个UIView都有一个根CALayer\n\nCAAnimation、CAMediaTiming、CAPropertyAnimation、CABasicAnimation、CASpringAnimation、CAKeyframeAnimation、CAAnimationGroup、CATransform\n\nCAAnimation 核心动画，不能直接使用\ntimingFunction 动画节奏类型\n[CAMediaTimingFunction functionWithName:]\nkCAMediaTimingFunctionLinear 匀速\nkCAMediaTimingFunctionEaseIn 慢进快出\nkCAMediaTimingFunctionEaseOut 快进慢出\nkCAMdeiaTimingFunctionEaseInEaseOut 慢进慢出，中间加速\nremoveOnCompletion 动画结束移除视图恢复之前动画状态，默认YES\ndelegate 代理\n-(void)animationDidStart:(CAAnimation *)anim\n-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag\n\nCAMediaTiming 定义动画时间、速度、重复次数等\nbeginTime 动画延时，CACurrentMediaTime()+s\nduration 动画时间\nspeed 速率，默认值1，动画时间=duration/speed\ntimeOffset 动画偏移量 指定位置开始\nrepeatCount 动画重复次数\nrepeatDuration 动画重复时间\nautoreverses 动画结束，逆转\nfillMode 动画结束时行为\nkCAFillModeForwards 动画结束，保持最后状态（removeOnCompletion=NO）\nkCAFillModeBackwards 动画开始前添加一个新layer，这个layer进入动画开始状态\nkCAFillModeBoth 前两个状态和\nkCAFillModeRemoved 动画结束恢复开始状态\n\nCAPropertyAnimation 属性动画，不能直接使用\nkeyPath、additive、cumulative、valueFunction\n+ (instancetype)animationWithKeyPath:(nullable NSString *)path\n\nCABasicAnimation 基础动画\nfromValue 初始值\ntoValue 结束值\nbyValue 过程值\n\nCAKeyframeAnimation 帧动画\nvalues 关键帧组成的动画\npath 关键帧路径、优先级大于value\nkeyTimes 每一帧对应的时间\ntimingFunctions 每一帧对应的动画节奏\ncalculationMode 动画的计算模式\ntensionValues 动画张力控制\ncontinuityValues 动画连续性控制\nbiasvalues 动画偏差率控制\nrotationModel 动画沿路径旋转方式\n\nCASpringAnimation 带有初始速度以及阻尼指数等物理参数的属性动画\nmass 小球质量，影响惯性\nstiffness 弹簧的劲度系数\ndamping 阻尼系数，地面摩擦力\ninitialVelocity 初始速度，相当于给小球一个初始速度\nsettingDuration 结算时间\n\nCATransition 转场动画\ntype 动画类型\nsubType 动画方向\nstartProgress 动画起点速度\nendprogress 动画终点速度\nfilter 自定义转场\n\nCAAnimationGroup 动画组\nanimations 动画效果元素的数组\n\n为什么动画结束后会返回原状态?\n视图动画中，我们看到的动画不是视图本身，动画开始，视图的layer隐藏，presention layer出现并执行动画，结束时presention layer从屏幕移除，视图layer显示\n\naddAnimation:forkey:做了什么?\n一个CABasicAnimation的实例对象只是一个数据模型，和它绑定到那个layer上没有关系,该方法将CABasicAnimation对象进行了copy操作";
}

+ (NSString *)BezierPath{
    return @"使用场景\n-(void)drawRect:(CGRect)rect\n在CAKeyframeAnimation.path中使用（CGPathRef=bezierPath.CGPath）\n在layer.mask=CAShapLayer.path中使用\n\n+(UIBezierPath *)bezierPath;//初始化\n+(UIBezierPath *)bezierPathWithRect:(CGRect)rect;//矩形\n+(UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect cornerRadius:(CGFloat)cornerRadius;//矩形圆角\n+(UIBezierPath *)bezierPathWithRoundedRect:(CGRect)rect byRoundingCorners:(UIRectCorner)conrners cornerRadii:(CGSize)cornerRadii;矩形圆角\n+(UIBezierPath *)bezierPathOvalInRect:(CGRect)rect;//圆\n+(UIBezierPath *)bezierPathWithArcCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;//弧\n\n画直/曲线\n1.UIBezierPath *path = [UIBezierPath bezierPath]\\初始化\n2.-(void)moveToPoint:(CGPoint)point;//起点\n-(void)addLineToPoint:(CGPoint)point;//其他点（自动和上一个点连接起来）\n-(void)closePath;//起点终点连接\nlineWidth //线宽度\nlineCapStyle(kCGLineCapButt、kCGLineCapRound、kCGLineCapSquare)线端点类型\nlineJoinStyle(kCGLinejoinMiter、kCGLineJoinRound、kCGLineJoinBevel)两条线交点\n[[UIColor whiteColor] setStroke] 边线颜色\n[[UIColor whiteColor] setFill] 内部颜色\n-(void)stroke 边线填充\n-(void)fill 内部填充\n\n-(void)appendPath:(UIBezierPath *)bezierPath;//添加新的贝塞尔曲线\n-(void)addArcWithCenter:(CGPoint)center radius:(CGFloat)radius startAngle:(CGFloat)startAngle endAngle:(CGFloat)endAngle clockwise:(BOOL)clockwise;//曲线\n-(void)addQuadCurveToPoint:(CGPoint)endPoint controlPoint:(CGPoint)controlPoint;//二次曲线\n-(void)addCurveToPoint:(CGPoint)endPoint controlPoint1:(CGpoint)controlPoint1 controlPoint2:(CGPoint)controlpoint2;\\三次曲线\n-(void)addClip;//超出部分不显示\n-(void)removeAllPoint;//移除所有点\nCGPath(UIBezierPath->CGPathRef) 路径\ncurrentPoint 当前位置(终点位置)";
}

+ (NSString *)锁{
    return @"锁分两种：自旋锁和互斥锁\n互斥锁根据类型：递归锁、NSCoditionLock、NSLock、@synchronized\n\n自旋锁(OSSpinLock):已有线程加锁，等待加锁的线程处于死循环等待(do while)，当加锁的线程解锁，等待的线程立马加锁。\n性能高，浪费CPU资源，不适合长时间死锁任务，同时存在安全问题\n互斥锁(pthread_mutex):已有线程加锁，等待加锁的线程处于休眠状态，当线程解锁，等待的线程被唤醒。\n\nNSLock\n创建NSLock对象，lock 加锁，unlock 解锁\n\n@synchronized()\n@synchronized后面跟着一个OC对象，这个对象当做锁来使用，通过哈希表实现，出现异常会自动解锁\n\n信号量dispatch_semaphore_t\ndispath_semaphore_t dispatch_semaphore_create(long value)//创建信号量\ndispatch_semaphore_signal(dispatch_semaphore_t dsema)//信号量加1\ndispatch_semaphore_wait()//当信号量为0时，该线程处于休眠状态，等待信号量值大于0，执行下面的语句";
}

+ (NSString *)关键字property等{
    return @"@property\n作用：快速创建实例变量存取；允许点语法使用\n\n在编译阶段编译器自动生成ivar成员变量+set方法+get方法\n属性名前加前缀_,set/get方法使用驼峰式命名\n往类添加属性，系统会在objc_ivar_list中添加一个成员变量的描述，在objc_method_list中添加set/get方法的描述\n\n举例:字符串var，分别对应_var、setVar、getVar\n注意：当类有同名成员变量，就不在重复添加\n\n@synthesize\n作用：为属性添加一个实例变量名，或者说别名。同时会为该属性生成 setter/getter 方法\n\n当我们同时重写了setter and getter方式时，需要在.m的文件中使用@synthesize\n当在 protocol 中声明并实现属性时，需要使用@synthesize生成setter和getter\n如果 @synthesize和 @dynamic都没写，那么默认的就是@syntheszie var = _var\n@syntheszie var = _var；等价于 @syntheszie var；\n\n@dynamic\n属性的 setter 与 getter 方法由用户自己实现，不自动生成。当然对于 readonly 的属性只需提供 getter 即可\n\n@synchornized(obj)\nobj作为锁对象，底层通过哈希表实现，锁异常会自动解锁，牺牲性能换来代码的简洁\n注意：一个代码块只需一把锁，多把锁是无效的";
}

+ (NSString *)runtime{
    return @"OC是运行时语言，runtime使用场景有类别添加属性、KVO、动态添加或者获得（方法、属性、成员变量、协议）api\n\n1.类别添加属性\nsetAssociatedObject(id object,const void * key,id value,policy)\nOBJC_ASSOCIATION_RETAIN\nOBJC_ASSOCIATION_COPY_NONOTOMIC\nOBJC_ASSOCIATION_ASSIGN_NONATOMIC\nOBJC_ASSOCIATION_COPY\nOBJC_ASSOCIATION_ASSIGN\ngetAssociatedObject(id object,const void * key)\n\n动态添加方法前缀class_add***\nclass_addIvar(Class cls,const char * name,size_t size,unit8_t alignment,const char * types)\nclass_addProperty(Class cls,const char * name,const objc_property_attribute_t * attribute,unsigned int attributeCount)\ncalss_addMethod(Class cls,SEL sel,IMP imp,const char * types)\nclass_addProcotol(Class cls,Protocol * protocol)\n\n动态获得列表方法前缀class_copy***List\nclass_copyIvarList(Class cls,unsigned int * outCount)\nclass_copyPropertyList(Class cls,unsigned int * outCount)\nclass_copyMethodList(Class cls,unsigned int * outCount)\nclass_copyProtocolList(Class cls,unsigned int * couCount)\n\n动态替换方法class_replace***\nclass_replaceMethod(Class cls,SEL sel,IMP imp,const char * types)\nclass_replaceProperty(Class cls,const char * name,const objc_property_attribute_t *attributes,unsigned int attributeCount)\n\nclass_set***\nclass_setVersion(Class cls,int version)\nclass_setIvarLayout(Class cls,const unint8_t * layout)\nclass_setWeakIvarLayout(Class cls,const unint8_t * layout)\n\nclass_get***\nclass_getName(Class cls)\nclass_getSuperClass(Class cls)\nclass_getVersion(Class cls)\nclass_getInstanceSize(Class cls)\nclass_getInstanceVariable(Class cls,const char * name)\nclass_getClassVariable(Class cls,const char * name)\nclass_getInstanceMethod(Class cls,SEL name)\nclass_getClassMethod(Class cls,SEL name)\nclass_getMethodImplementation(Class cls,SEL name)\nclass_getMethodImplementation_stret(Class cls,SEL name)\nclass_getProperty(Class cls,const char * name)\nclass_getIvarLayout(Class cls)\nclass_getWeakLayout(Class cls)\nclass_getImageName(Class cls)\n\n";
}

@end

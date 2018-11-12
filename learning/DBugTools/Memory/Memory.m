//
//  Memory.m
//  learning
//
//  Created by 祥伟 on 2018/9/4.
//  Copyright © 2018年 wanda. All rights reserved.
//

#import "Memory.h"
#import <mach/mach.h>
#import <mach/task_info.h>

@implementation Memory

+ (double)getResidentMemory {
    struct mach_task_basic_info info;
    mach_msg_type_number_t count = MACH_TASK_BASIC_INFO_COUNT;
    if (task_info(mach_task_self(), MACH_TASK_BASIC_INFO, (task_info_t)&info, &count) == KERN_SUCCESS) {
        return info.resident_size / (1024 * 1024);
    } else {
        return -1.0;
    }
}

+ (double)getMemoryUsage {
    task_vm_info_data_t vmInfo;
    mach_msg_type_number_t count = TASK_VM_INFO_COUNT;
    if(task_info(mach_task_self(), TASK_VM_INFO, (task_info_t) &vmInfo, &count) == KERN_SUCCESS) {
        return (double)vmInfo.phys_footprint / (1024 * 1024);
    } else {
        return -1.0;
    }
}

@end

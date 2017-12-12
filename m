From: Jia-Ju Bai <baijiaju1990@gmail.com>
Subject: [BUG] fs/f2fs: a possible sleep-in-atomic bug in f2fs_trace_pid
Date: Tue, 12 Dec 2017 08:59:29 +0800
Message-ID: <8e7328d3-2df3-e79d-9558-a9b3713751c4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: linux-f2fs-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

According to fs/f2fs/trace.c, the kernel module may sleep under a spinlock.
The function call path is:
f2fs_trace_pid (acquire the spinlock)
   f2fs_radix_tree_insert
     cond_resched --> may sleep

I do not find a good way to fix it, so I only report.
This possible bug is found by my static analysis tool (DSAC) and my code 
review.


Thanks,
Jia-Ju Bai

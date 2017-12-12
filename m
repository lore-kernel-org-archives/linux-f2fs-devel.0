From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [BUG] fs/f2fs: a possible sleep-in-atomic bug in f2fs_trace_pid
Date: Tue, 12 Dec 2017 10:00:54 +0800
Message-ID: <9272d87c-ef9b-a19d-ffe1-1db2b8785d74@huawei.com>
References: <8e7328d3-2df3-e79d-9558-a9b3713751c4@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8e7328d3-2df3-e79d-9558-a9b3713751c4@gmail.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jia-Ju Bai <baijiaju1990@gmail.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jia-Ju,

Thanks for your report. :)

On 2017/12/12 8:59, Jia-Ju Bai wrote:
> According to fs/f2fs/trace.c, the kernel module may sleep under a spinlock.
> The function call path is:
> f2fs_trace_pid (acquire the spinlock)
>    f2fs_radix_tree_insert
>      cond_resched --> may sleep
> 
> I do not find a good way to fix it, so I only report.
> This possible bug is found by my static analysis tool (DSAC) and my code 
> review.
That's a known issue, and there are other problems in IO trace related codes,
so I want to refactor the code directly, you could check the code in below link:

https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git/commit/?h=f2fs-dev&id=d895154be1733e2bd29c9e64b57e4e201f0e8a0c

But the patch still needs debugging so far. Since the IO trace feature is off
by default, I expect the impaction is limited, so I pend the debug job on this
patch.

Anyway, I think this issue you reported should be fixed first, let me make the
fixing part independent from original patch for fixing.

Thanks,

> 
> 
> Thanks,
> Jia-Ju Bai
> 
> 

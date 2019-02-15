From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [PATCH] f2fs: do not use mutex lock in atomic context
Date: Fri, 15 Feb 2019 09:58:15 +0530
Message-ID: <77c63bf6-069c-704c-220a-b50d997d2463@codeaurora.org>
References: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
 <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
 <20190214074628.GD7308@codeaurora.org>
 <5650af07-c55d-fcb4-ca98-eca45248392d@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <riteshh@codeaurora.org>) id 1guV74-00053l-LT
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 04:28:34 +0000
Received: from smtp.codeaurora.org ([198.145.29.96])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1guV6x-00GO36-7A
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 15 Feb 2019 04:28:33 +0000
In-Reply-To: <5650af07-c55d-fcb4-ca98-eca45248392d@kernel.org>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>, Sahitya Tummala <stummala@codeaurora.org>, Chao Yu <yuchao0@huawei.com>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net


On 2/14/2019 9:40 PM, Chao Yu wrote:
> On 2019-2-14 15:46, Sahitya Tummala wrote:
>> On Wed, Feb 13, 2019 at 11:25:31AM +0800, Chao Yu wrote:
>>> On 2019/2/4 16:06, Sahitya Tummala wrote:
>>>> Fix below warning coming because of using mutex lock in atomic context.
>>>>
>>>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
>>>> in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
>>>> Preemption disabled at: __radix_tree_preload+0x28/0x130
>>>> Call trace:
>>>>   dump_backtrace+0x0/0x2b4
>>>>   show_stack+0x20/0x28
>>>>   dump_stack+0xa8/0xe0
>>>>   ___might_sleep+0x144/0x194
>>>>   __might_sleep+0x58/0x8c
>>>>   mutex_lock+0x2c/0x48
>>>>   f2fs_trace_pid+0x88/0x14c
>>>>   f2fs_set_node_page_dirty+0xd0/0x184
>>>>
>>>> Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
>>>> spin_lock() acquired.
>>>>
>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>> ---
>>>>   fs/f2fs/trace.c | 20 +++++++++++++-------
>>>>   1 file changed, 13 insertions(+), 7 deletions(-)
>>>>
>>>> diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
>>>> index ce2a5eb..d0ab533 100644
>>>> --- a/fs/f2fs/trace.c
>>>> +++ b/fs/f2fs/trace.c
>>>> @@ -14,7 +14,7 @@
>>>>   #include "trace.h"
>>>>   
>>>>   static RADIX_TREE(pids, GFP_ATOMIC);
>>>> -static struct mutex pids_lock;
>>>> +static spinlock_t pids_lock;
>>>>   static struct last_io_info last_io;
>>>>   
>>>>   static inline void __print_last_io(void)
>>>> @@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
>>>>   
>>>>   	set_page_private(page, (unsigned long)pid);
>>>>   
>>>> +retry:
>>>>   	if (radix_tree_preload(GFP_NOFS))
>>>>   		return;
>>>>   
>>>> -	mutex_lock(&pids_lock);
>>>> +	spin_lock(&pids_lock);
>>>>   	p = radix_tree_lookup(&pids, pid);
>>>>   	if (p == current)
>>>>   		goto out;
>>>>   	if (p)
>>>>   		radix_tree_delete(&pids, pid);
>>>>   
>>>> -	f2fs_radix_tree_insert(&pids, pid, current);

Do you know why do we have a retry logic here? When anyways we have 
called for radix_tree_delete with pid key?
Which should ensure the slot is empty, no?
Then why in the original code (f2fs_radix_tree_insert), we were 
retrying. For what condition a retry was needed?

Regards
Ritesh


>>>> +	if (radix_tree_insert(&pids, pid, current)) {
>>>> +		spin_unlock(&pids_lock);
>>>> +		radix_tree_preload_end();
>>>> +		cond_resched();
>>>> +		goto retry;
>>>> +	}
>>>>   
>>>>   	trace_printk("%3x:%3x %4x %-16s\n",
>>>>   			MAJOR(inode->i_sb->s_dev), MINOR(inode->i_sb->s_dev),
>>>>   			pid, current->comm);
>>> Hi Sahitya,
>>>
>>> Can trace_printk sleep? For safety, how about moving it out of spinlock?
>>>
>> Hi Chao,
>>
>> Yes, trace_printk() is safe to use in atomic context (unlike printk).
> Hi Sahitya,
>
> Thanks for your confirmation. :)
>
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>
> Thanks,
>
>> Thanks,
>> Sahitya.
>>
>>> Thanks,
>>>
>>>>   out:
>>>> -	mutex_unlock(&pids_lock);
>>>> +	spin_unlock(&pids_lock);
>>>>   	radix_tree_preload_end();
>>>>   }
>>>>   
>>>> @@ -119,7 +125,7 @@ void f2fs_trace_ios(struct f2fs_io_info *fio, int flush)
>>>>   
>>>>   void f2fs_build_trace_ios(void)
>>>>   {
>>>> -	mutex_init(&pids_lock);
>>>> +	spin_lock_init(&pids_lock);
>>>>   }
>>>>   
>>>>   #define PIDVEC_SIZE	128
>>>> @@ -147,7 +153,7 @@ void f2fs_destroy_trace_ios(void)
>>>>   	pid_t next_pid = 0;
>>>>   	unsigned int found;
>>>>   
>>>> -	mutex_lock(&pids_lock);
>>>> +	spin_lock(&pids_lock);
>>>>   	while ((found = gang_lookup_pids(pid, next_pid, PIDVEC_SIZE))) {
>>>>   		unsigned idx;
>>>>   
>>>> @@ -155,5 +161,5 @@ void f2fs_destroy_trace_ios(void)
>>>>   		for (idx = 0; idx < found; idx++)
>>>>   			radix_tree_delete(&pids, pid[idx]);
>>>>   	}
>>>> -	mutex_unlock(&pids_lock);
>>>> +	spin_unlock(&pids_lock);
>>>>   }
>>>>
>
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

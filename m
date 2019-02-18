From: Ritesh Harjani <riteshh@codeaurora.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: do not use mutex lock in atomic context
Date: Mon, 18 Feb 2019 07:34:54 +0530
Message-ID: <2731428f-9aa5-d2f0-4793-c01211dcc125@codeaurora.org>
References: <1549267613-9288-1-git-send-email-stummala@codeaurora.org>
 <c98cbfcb-f45d-e9a9-5c2e-6730d0448e82@huawei.com>
 <20190214074628.GD7308@codeaurora.org>
 <5650af07-c55d-fcb4-ca98-eca45248392d@kernel.org>
 <77c63bf6-069c-704c-220a-b50d997d2463@codeaurora.org>
 <70630a8c-4f7d-7d97-54a2-b1e4bceca492@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <70630a8c-4f7d-7d97-54a2-b1e4bceca492@huawei.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Chao Yu <chao@kernel.org>, Sahitya Tummala <stummala@codeaurora.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net


On 2/15/2019 2:40 PM, Chao Yu wrote:
> On 2019/2/15 12:28, Ritesh Harjani wrote:
>> On 2/14/2019 9:40 PM, Chao Yu wrote:
>>> On 2019-2-14 15:46, Sahitya Tummala wrote:
>>>> On Wed, Feb 13, 2019 at 11:25:31AM +0800, Chao Yu wrote:
>>>>> On 2019/2/4 16:06, Sahitya Tummala wrote:
>>>>>> Fix below warning coming because of using mutex lock in atomic context.
>>>>>>
>>>>>> BUG: sleeping function called from invalid context at kernel/locking/mutex.c:98
>>>>>> in_atomic(): 1, irqs_disabled(): 0, pid: 585, name: sh
>>>>>> Preemption disabled at: __radix_tree_preload+0x28/0x130
>>>>>> Call trace:
>>>>>>    dump_backtrace+0x0/0x2b4
>>>>>>    show_stack+0x20/0x28
>>>>>>    dump_stack+0xa8/0xe0
>>>>>>    ___might_sleep+0x144/0x194
>>>>>>    __might_sleep+0x58/0x8c
>>>>>>    mutex_lock+0x2c/0x48
>>>>>>    f2fs_trace_pid+0x88/0x14c
>>>>>>    f2fs_set_node_page_dirty+0xd0/0x184
>>>>>>
>>>>>> Do not use f2fs_radix_tree_insert() to avoid doing cond_resched() with
>>>>>> spin_lock() acquired.
>>>>>>
>>>>>> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>
>>>>>> ---
>>>>>>    fs/f2fs/trace.c | 20 +++++++++++++-------
>>>>>>    1 file changed, 13 insertions(+), 7 deletions(-)
>>>>>>
>>>>>> diff --git a/fs/f2fs/trace.c b/fs/f2fs/trace.c
>>>>>> index ce2a5eb..d0ab533 100644
>>>>>> --- a/fs/f2fs/trace.c
>>>>>> +++ b/fs/f2fs/trace.c
>>>>>> @@ -14,7 +14,7 @@
>>>>>>    #include "trace.h"
>>>>>>    
>>>>>>    static RADIX_TREE(pids, GFP_ATOMIC);
>>>>>> -static struct mutex pids_lock;
>>>>>> +static spinlock_t pids_lock;
>>>>>>    static struct last_io_info last_io;
>>>>>>    
>>>>>>    static inline void __print_last_io(void)
>>>>>> @@ -58,23 +58,29 @@ void f2fs_trace_pid(struct page *page)
>>>>>>    
>>>>>>    	set_page_private(page, (unsigned long)pid);
>>>>>>    
>>>>>> +retry:
>>>>>>    	if (radix_tree_preload(GFP_NOFS))
>>>>>>    		return;
>>>>>>    
>>>>>> -	mutex_lock(&pids_lock);
>>>>>> +	spin_lock(&pids_lock);
>>>>>>    	p = radix_tree_lookup(&pids, pid);
>>>>>>    	if (p == current)
>>>>>>    		goto out;
>>>>>>    	if (p)
>>>>>>    		radix_tree_delete(&pids, pid);
>>>>>>    
>>>>>> -	f2fs_radix_tree_insert(&pids, pid, current);
>> Do you know why do we have a retry logic here? When anyways we have
>> called for radix_tree_delete with pid key?
>> Which should ensure the slot is empty, no?
>> Then why in the original code (f2fs_radix_tree_insert), we were
>> retrying. For what condition a retry was needed?
> Hi,
>
> f2fs_radix_tree_insert is used in many places, it was introduced to used in
> some paths we should not failed.
>
> And here, I guess we used it for the same purpose, if we failed to insert
> @current pointer into radix, next time, we may not skip calling
> trace_printk, actually it will print the same current->comm info as
> previous one, it's redundant.

Sure, thanks for the info.

Regards
Ritesh

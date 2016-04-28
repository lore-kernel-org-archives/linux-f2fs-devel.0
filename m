From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH RESEND 2/2] f2fs: disable preemption when
 waiting on all pages writeback
Date: Thu, 28 Apr 2016 23:06:23 +0800
Message-ID: <572226EF.20101@kernel.org>
References: <5720C19C.3000503@kernel.org>
	<20160427180801.GA33099@jaegeuk.gateway>
	<0fda915e-2945-9c2b-0e5a-dff3b4e37a92@huawei.com>
	<20160428140314.GD3448@twins.programming.kicks-ass.net>
	<57221E9F.30002@kernel.org>
	<20160428143738.GQ3408@twins.programming.kicks-ass.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1avnWh-00067r-B8
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:06:47 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1avnWd-0000hi-Ti
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 28 Apr 2016 15:06:47 +0000
In-Reply-To: <20160428143738.GQ3408@twins.programming.kicks-ass.net>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Peter Zijlstra <peterz@infradead.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/4/28 22:37, Peter Zijlstra wrote:
> On Thu, Apr 28, 2016 at 10:30:55PM +0800, Chao Yu wrote:
>> On 2016/4/28 22:03, Peter Zijlstra wrote:
>>> On Thu, Apr 28, 2016 at 07:51:04PM +0800, Chao Yu wrote:
>>>>> On Wed, Apr 27, 2016 at 09:41:48PM +0800, Chao Yu wrote:
>>>>>> From: Chao Yu <yuchao0@huawei.com>
>>>>>>
>>>>>> The following condition can happen in a preemptible kernel, it may cause
>>>>>> checkpointer hunging.
>>>>>>
>>>>>> CPU0:					CPU1:
>>>>>>  - write_checkpoint
>>>>>>   - do_checkpoint
>>>>>>    - wait_on_all_pages_writeback
>>>>>> 					 - f2fs_write_end_io
>>>>>> 					  - wake_up
>>>>>> 					this is last writebacked page, but
>>>>>> 					no sleeper in sbi->cp_wait wait
>>>>>> 					queue, wake_up is not been called.
>>>>>>     - prepare_to_wait(TASK_UNINTERRUPTIBLE)
>>>>>>     Here, current task can been preempted,
>>>>>>     but there will be no waker since last
>>>>>>     write_end_io has bypassed wake_up. So
>>>>>>     current task will sleep forever.
>>>
>>> But here, you should be verifying if you really should go sleep; as the
>>> code did; it tests for !get_pages(, F2FS_WRITEBACK), and if you've just
>>> completed that very last one, this will break out.
>>
>> You mean after being preempted with TASK_UNINTERRUPTIBLE status, that task still
>> has chance to be scheduled to check '!get_pages(, F2FS_WRITEBACK)', is that right?
> 
> Yes, preemption ignores task_struct::state.

Got it. Thanks very much for your help! :)

> 

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z

From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [f2fs-dev] [PATCH RESEND 2/2] f2fs: disable preemption when
 waiting on all pages writeback
Date: Thu, 28 Apr 2016 16:37:38 +0200
Message-ID: <20160428143738.GQ3408@twins.programming.kicks-ass.net>
References: <5720C19C.3000503@kernel.org>
 <20160427180801.GA33099@jaegeuk.gateway>
 <0fda915e-2945-9c2b-0e5a-dff3b4e37a92@huawei.com>
 <20160428140314.GD3448@twins.programming.kicks-ass.net>
 <57221E9F.30002@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <57221E9F.30002@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Thu, Apr 28, 2016 at 10:30:55PM +0800, Chao Yu wrote:
> On 2016/4/28 22:03, Peter Zijlstra wrote:
> > On Thu, Apr 28, 2016 at 07:51:04PM +0800, Chao Yu wrote:
> >>> On Wed, Apr 27, 2016 at 09:41:48PM +0800, Chao Yu wrote:
> >>>> From: Chao Yu <yuchao0@huawei.com>
> >>>>
> >>>> The following condition can happen in a preemptible kernel, it may cause
> >>>> checkpointer hunging.
> >>>>
> >>>> CPU0:					CPU1:
> >>>>  - write_checkpoint
> >>>>   - do_checkpoint
> >>>>    - wait_on_all_pages_writeback
> >>>> 					 - f2fs_write_end_io
> >>>> 					  - wake_up
> >>>> 					this is last writebacked page, but
> >>>> 					no sleeper in sbi->cp_wait wait
> >>>> 					queue, wake_up is not been called.
> >>>>     - prepare_to_wait(TASK_UNINTERRUPTIBLE)
> >>>>     Here, current task can been preempted,
> >>>>     but there will be no waker since last
> >>>>     write_end_io has bypassed wake_up. So
> >>>>     current task will sleep forever.
> > 
> > But here, you should be verifying if you really should go sleep; as the
> > code did; it tests for !get_pages(, F2FS_WRITEBACK), and if you've just
> > completed that very last one, this will break out.
> 
> You mean after being preempted with TASK_UNINTERRUPTIBLE status, that task still
> has chance to be scheduled to check '!get_pages(, F2FS_WRITEBACK)', is that right?

Yes, preemption ignores task_struct::state.

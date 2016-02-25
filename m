From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 losing wake_up
Date: Thu, 25 Feb 2016 17:32:17 +0800
Message-ID: <013001d16faf$88374ae0$98a5e0a0$@samsung.com>
References: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
	<009501d16dfd$52a518c0$f7ef4a40$@samsung.com>
	<56CC0410.50103@huawei.com>
	<009601d16e1a$e198af20$a4ca0d60$@samsung.com>
	<56CC442C.1050202@huawei.com>
	<00c401d16eb6$14754cf0$3d5fe6d0$@samsung.com>
	<56CD5C72.7040305@huawei.com>
	<00e301d16eda$383ca740$a8b5f5c0$@samsung.com>
	<0F0234076C344444BEA001AACCA4A9D5ED6BC5@SZXEMI504-MBS.china.huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aYsIO-0003YL-2e
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 09:33:16 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aYsIL-0000Yb-T0
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 09:33:16 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O3300IX3JV3U160@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 25 Feb 2016 18:33:04 +0900 (KST)
In-reply-to: <0F0234076C344444BEA001AACCA4A9D5ED6BC5@SZXEMI504-MBS.china.huawei.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "'hebiao (G)'" <hebiao6@huawei.com>, 'heyunlei' <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Hebiao,

> -----Original Message-----
> From: hebiao (G) [mailto:hebiao6@huawei.com]
> Sent: Wednesday, February 24, 2016 5:46 PM
> To: Chao Yu; heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: Wangbintian
> Subject: RE: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
> 
> Hi, Chao,
> 
> > -----Original Message-----
> > From: Chao Yu [mailto:chao2.yu@samsung.com]
> > Sent: Wednesday, February 24, 2016 4:05 PM
> > To: heyunlei; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> > Cc: Wangbintian; hebiao (G)
> > Subject: RE: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing
> > wake_up
> >
> > Hi Yunlei,
> >
> > > -----Original Message-----
> > > From: He YunLei [mailto:heyunlei@huawei.com]
> > > Sent: Wednesday, February 24, 2016 3:32 PM
> > > To: Chao Yu; jaegeuk@kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: bintian.wang@huawei.com; 'Biao He'
> > > Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by
> > > losing wake_up
> > >
> > > On 2016/2/24 11:46, Chao Yu wrote:
> > > > Hi Yunlei,
> > > >
> > > >> -----Original Message-----
> > > >> From: He YunLei [mailto:heyunlei@huawei.com]
> > > >> Sent: Tuesday, February 23, 2016 7:36 PM
> > > >> To: Chao Yu; jaegeuk@kernel.org;
> > > >> linux-f2fs-devel@lists.sourceforge.net
> > > >> Cc: bintian.wang@huawei.com; 'Biao He'
> > > >> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused
> > > >> by losing wake_up
> > > >>
> > > >> On 2016/2/23 17:15, Chao Yu wrote:
> > > >> Hi Chao,
> > > >>
> > > >>> Hi Yunlei,
> > > >>>
> > > >>>> -----Original Message-----
> > > >>>> From: He YunLei [mailto:heyunlei@huawei.com]
> > > >>>> Sent: Tuesday, February 23, 2016 3:03 PM
> > > >>>> To: Chao Yu; jaegeuk@kernel.org;
> > > >>>> linux-f2fs-devel@lists.sourceforge.net
> > > >>>> Cc: bintian.wang@huawei.com; 'Biao He'
> > > >>>> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem
> > > >>>> caused by losing wake_up
> > > >>>>
> > > >>>> On 2016/2/23 13:44, Chao Yu wrote:
> > > >>>>> Hi Yunlei,
> > > >>>> Hi Chao,
> > > >>>>>
> > > >>>>>> -----Original Message-----
> > > >>>>>> From: Yunlei He [mailto:heyunlei@huawei.com]
> > > >>>>>> Sent: Tuesday, February 23, 2016 12:08 PM
> > > >>>>>> To: chao2.yu@samsung.com; jaegeuk@kernel.org;
> > > >>>>>> linux-f2fs-devel@lists.sourceforge.net
> > > >>>>>> Cc: bintian.wang@huawei.com; Yunlei He; Biao He
> > > >>>>>> Subject: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused
> > > >>>>>> by losing wake_up
> > > >>>>>>
> > > >>>>>> The D state of wait_on_all_pages_writeback should be waken by
> > > >>>>>> function f2fs_write_end_io when all writeback pages have been
> > > >>>>>> succesfully written to device. It's possible that wake_up comes
> > > >>>>>> between get_pages and io_schedule. Maybe in this case it will
> > > >>>>>> lost wake_up and still in D state even if all pages have been
> > > >>>>>> write back to device, and finally, the whole system will be
> > > >>>>>> into the hungtask state.
> > > >>>>>
> > > >>>>> I haven't encountered such issue so far, do you suffer this in
> > > >>>>> real world?
> > > >>>>>
> > > >>>> yes, I have encounter it, the whole file system is blocked at
> > > >>>> function wait_on_all_pages_writeback beyond 120s when write cp,
> > > >>>> and no error reported by storage device driver.
> > > >>>
> > > >>> Could this reproducible? If it could, could you please share the details.
> > > >>> And did this occur in a huge size f2fs image?
> > > >>>
> > > >>>>>>
> > > >>>>>>                    if (!get_pages(sbi, F2FS_WRITEBACK))
> > > >>>>>>                             break;
> > > >>>>>> 					<---------  wake_up
> > > >>>>>
> > > >>>>> wake_up will put all tasks linked in sbi->cp_wait on run-queue,
> > > >>>>> so here it should be save to call io_schedule, after being
> > > >>>>> rescheduled, it will get the chance to check above condition to break
> > out.
> > > >>>>>
> > > >>>>> Thanks,
> > > >>>>
> > > >>>> Here, we just doubt something weird may cause
> > > >>>> wait_on_all_pages_writeback could not be waken. Wake_up trigger
> > > >>>> only one time by last bio's end_io function, if the thread happen
> > > >>>> to miss it, the thread will be in D state forever. So we change
> > > >>>> the code to make wait_on_all_pages_writeback awaken periodically,
> > then check the condition.
> > > >>>
> > > >>> Got it.
> > > >>>
> > > >>> The patch can fix issue that checkpointer will wait forever in
> > > >>> case of write_end_io was failed to call wake_up for some reason.
> > > >
> > > > I found one possible case:
> > > >
> > > > CPU0:					CPU1:
> > > >   - write_checkpoint
> > > >    - do_checkpoint
> > > >     - wait_on_all_pages_writeback
> > > > 					 - f2fs_write_end_io
> > > > 					  - wake_up
> > > > 					this is last writebacked page, but
> > > > 					no sleeper in sbi->cp_wait wait
> > > > 					queue, wake_up is not been called.
> > > >      - prepare_to_wait(TASK_UNINTERRUPTIBLE)
> > > >      Here, current task is been preempted,
> > > >      but there will be no waker to wake up
> > > >      this task since last write_end_io
> > > >      has been called before. So current
> > > >      task will sleep forever.
> > > >      - io_schedule
> > > >
> > > > How do you think of it?
> > > Hi Chao,
> > >
> > > Here, current task add itself into wait queue at first, and then check
> > > the condition whether write back page is zero. So, in the above
> > > situation, current task is been preempted in -
> > > prepare_to_wait(TASK_UNINTERRUPTIBLE),
> > > current task will not sleep for the write back page is zero.
> >
> > Oh, I meant:
> >
> >  - prepare_to_wait(TASK_UNINTERRUPTIBLE)
> >  - Preempt
> >  - if (!get_pages(sbi, F2FS_WRITEBACK)) break;    or maybe preempt here
> >  - io_schedule
> >  - finish_wait
> >
> > Even there is no more writeback state page, also preemption can happen
> > before finish_wait, after that, once the task was been switched out, as it was
> > set as TASK_UNINTERRUPTIBLE, there is no chance to schedule it again.
> >
> > Thanks,
> >
> First, according to our hungtask stack, we can confirm we are in io_schedule.

Oh, IMO, it can prove that we actually arrive there, not being preempted, thanks
for your information.

> 
> Secondly, from my point of view, it is safe to preempt regardless of the task's state. It will
> eventually reschedule. You can see kernel\sched\core.c :: __schedule. If PREEMPT_ACTIVE
> is set, the current task will be put back to the run queue.

OK, I will have a look at it.

Thanks,

> 
> > >
> > > Thanks,
> > > >
> > > > And if this is right, following patch can fix this issue.
> > > >
> > > > ---
> > > >   fs/f2fs/checkpoint.c | 14 +++++++++-----
> > > >   fs/f2fs/data.c       |  9 +++++++--
> > > >   fs/f2fs/f2fs.h       |  3 ++-
> > > >   fs/f2fs/super.c      |  1 +
> > > >   4 files changed, 19 insertions(+), 8 deletions(-)
> > > >
> > > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c index
> > > > 9d277f8..9446c3d 100644
> > > > --- a/fs/f2fs/checkpoint.c
> > > > +++ b/fs/f2fs/checkpoint.c
> > > > @@ -914,15 +914,19 @@ static void wait_on_all_pages_writeback(struct
> > f2fs_sb_info *sbi)
> > > >   {
> > > >   	DEFINE_WAIT(wait);
> > > >
> > > > -	for (;;) {
> > > > -		prepare_to_wait(&sbi->cp_wait, &wait, TASK_UNINTERRUPTIBLE);
> > > > +	spin_lock(&sbi->cp_wb_lock);
> > > >
> > > > -		if (!get_pages(sbi, F2FS_WRITEBACK))
> > > > -			break;
> > > > +	while (get_pages(sbi, F2FS_WRITEBACK)) {
> > > > +		prepare_to_wait(&sbi->cp_wait, &wait,
> > TASK_UNINTERRUPTIBLE);
> > > >
> > > > +		spin_unlock(&sbi->cp_wb_lock);
> > > >   		io_schedule();
> > > > +		spin_lock(&sbi->cp_wb_lock);
> > > > +
> > > > +		finish_wait(&sbi->cp_wait, &wait);
> > > >   	}
> > > > -	finish_wait(&sbi->cp_wait, &wait);
> > > > +
> > > > +	spin_unlock(&sbi->cp_wb_lock);
> > > >   }
> > > >
> > > >   static int do_checkpoint(struct f2fs_sb_info *sbi, struct
> > > > cp_control *cpc) diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c index
> > > > e5c762b..e31deb97 100644
> > > > --- a/fs/f2fs/data.c
> > > > +++ b/fs/f2fs/data.c
> > > > @@ -59,6 +59,7 @@ static void f2fs_write_end_io(struct bio *bio)
> > > >   {
> > > >   	struct f2fs_sb_info *sbi = bio->bi_private;
> > > >   	struct bio_vec *bvec;
> > > > +	unsigned long flags;
> > > >   	int i;
> > > >
> > > >   	bio_for_each_segment_all(bvec, bio, i) { @@ -74,8 +75,12 @@
> > > > static void f2fs_write_end_io(struct bio *bio)
> > > >   		dec_page_count(sbi, F2FS_WRITEBACK);
> > > >   	}
> > > >
> > > > -	if (!get_pages(sbi, F2FS_WRITEBACK) && wq_has_sleeper(&sbi->cp_wait))
> > > > -		wake_up(&sbi->cp_wait);
> > > > +	if (!get_pages(sbi, F2FS_WRITEBACK)) {
> > > > +		spin_lock_irqsave(&sbi->cp_wb_lock, flags);
> > > > +		if (wq_has_sleeper(&sbi->cp_wait))
> > > > +			wake_up(&sbi->cp_wait);
> > > > +		spin_unlock_irqrestore(&sbi->cp_wb_lock, flags);
> > > > +	}
> > > >
> > > >   	bio_put(bio);
> > > >   }
> > > > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h index 0d25430..fd47984
> > > > 100644
> > > > --- a/fs/f2fs/f2fs.h
> > > > +++ b/fs/f2fs/f2fs.h
> > > > @@ -727,7 +727,8 @@ struct f2fs_sb_info {
> > > >   	struct rw_semaphore cp_rwsem;		/* blocking FS operations */
> > > >   	struct rw_semaphore node_write;		/* locking node writes */
> > > >   	struct mutex writepages;		/* mutex for writepages() */
> > > > -	wait_queue_head_t cp_wait;
> > > > +	wait_queue_head_t cp_wait;		/* for wait pages writeback */
> > > > +	spinlock_t cp_wb_lock;			/* for protect cp_wait */
> > > >   	unsigned long last_time[MAX_TIME];	/* to store time in jiffies */
> > > >   	long interval_time[MAX_TIME];		/* to store thresholds */
> > > >
> > > > diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c index
> > > > 7b62016..5316c7a 100644
> > > > --- a/fs/f2fs/super.c
> > > > +++ b/fs/f2fs/super.c
> > > > @@ -1374,6 +1374,7 @@ try_onemore:
> > > >
> > > >   	init_rwsem(&sbi->cp_rwsem);
> > > >   	init_waitqueue_head(&sbi->cp_wait);
> > > > +	spin_lock_init(&sbi->cp_wb_lock);
> > > >   	init_sb_info(sbi);
> > > >
> > > >   	/* get an inode for meta space */
> > > >
> >



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140

From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: avoid hungtask problem caused by
 losing wake_up
Date: Tue, 23 Feb 2016 17:15:41 +0800
Message-ID: <009601d16e1a$e198af20$a4ca0d60$@samsung.com>
References: <1456200476-9811-1-git-send-email-heyunlei@huawei.com>
	<009501d16dfd$52a518c0$f7ef4a40$@samsung.com>
	<56CC0410.50103@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1aY95d-0006um-JV
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 09:17:05 +0000
Received: from [203.254.224.33] (helo=mailout3.samsung.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1aY95a-0006Tl-K8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 09:17:05 +0000
Received: from epcpsbgm2new.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout3.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0O2Z01GS9TQUUDB0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 23 Feb 2016 18:16:30 +0900 (KST)
In-reply-to: <56CC0410.50103@huawei.com>
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
To: 'He YunLei' <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: 'Biao He' <hebiao6@huawei.com>

Hi Yunlei,

> -----Original Message-----
> From: He YunLei [mailto:heyunlei@huawei.com]
> Sent: Tuesday, February 23, 2016 3:03 PM
> To: Chao Yu; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: bintian.wang@huawei.com; 'Biao He'
> Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
> 
> On 2016/2/23 13:44, Chao Yu wrote:
> > Hi Yunlei,
> Hi Chao,
> >
> >> -----Original Message-----
> >> From: Yunlei He [mailto:heyunlei@huawei.com]
> >> Sent: Tuesday, February 23, 2016 12:08 PM
> >> To: chao2.yu@samsung.com; jaegeuk@kernel.org; linux-f2fs-devel@lists.sourceforge.net
> >> Cc: bintian.wang@huawei.com; Yunlei He; Biao He
> >> Subject: [f2fs-dev] [PATCH] f2fs: avoid hungtask problem caused by losing wake_up
> >>
> >> The D state of wait_on_all_pages_writeback should be waken by
> >> function f2fs_write_end_io when all writeback pages have been
> >> succesfully written to device. It's possible that wake_up comes
> >> between get_pages and io_schedule. Maybe in this case it will
> >> lost wake_up and still in D state even if all pages have been
> >> write back to device, and finally, the whole system will be into
> >> the hungtask state.
> >
> > I haven't encountered such issue so far, do you suffer this in real
> > world?
> >
> yes, I have encounter it, the whole file system is blocked at function
> wait_on_all_pages_writeback beyond 120s when write cp, and no error reported
> by storage device driver.

Could this reproducible? If it could, could you please share the details.
And did this occur in a huge size f2fs image?

> >>
> >>                  if (!get_pages(sbi, F2FS_WRITEBACK))
> >>                           break;
> >> 					<---------  wake_up
> >
> > wake_up will put all tasks linked in sbi->cp_wait on run-queue, so
> > here it should be save to call io_schedule, after being rescheduled,
> > it will get the chance to check above condition to break out.
> >
> > Thanks,
> 
> Here, we just doubt something weird may cause wait_on_all_pages_writeback
> could not be waken. Wake_up trigger only one time by last bio's end_io
> function, if the thread happen to miss it, the thread will be in D state
> forever. So we change the code to make wait_on_all_pages_writeback awaken
> periodically, then check the condition.

Got it.

The patch can fix issue that checkpointer will wait forever in case of
write_end_io was failed to call wake_up for some reason.

But I doubt more that the reason we are stuck is there are remained pages
cached in bio buffer without being submitted. To make sure, maybe in
wait_on_all_pages_writeback we could add print info to see whether
sbi->write_io[].bio is valid or not.

Thanks,

> 
> >
> >>                  io_schedule();
> >>
> >> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> >> Signed-off-by: Biao He <hebiao6@huawei.com>
> >> ---
> >>   fs/f2fs/checkpoint.c | 2 +-
> >>   1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> >> index 2bac8a1..f55355d 100644
> >> --- a/fs/f2fs/checkpoint.c
> >> +++ b/fs/f2fs/checkpoint.c
> >> @@ -920,7 +920,7 @@ static void wait_on_all_pages_writeback(struct f2fs_sb_info *sbi)
> >>   		if (!get_pages(sbi, F2FS_WRITEBACK))
> >>   			break;
> >>
> >> -		io_schedule();
> >> +		io_schedule_timeout(5*HZ);
> >>   	}
> >>   	finish_wait(&sbi->cp_wait, &wait);
> >>   }
> >> --
> >> 1.9.1
> >
> >
> >
> > .
> >



------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140

From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: add memory barrier for wait list and
	pages count
Date: Thu, 10 Mar 2016 12:18:18 -0800
Message-ID: <20160310201818.GA58400@jaegeuk.gateway>
References: <CAAde8TA5GZF62UHOck8zgFW=ShcGWLp_2=KZNopRoCpa_PuNFQ@mail.gmail.com>
	<20160310010338.GA56809@jaegeuk.gateway>
	<CAAde8TBW=7=L4JQJ0yTdRxrh5dpOt0KQCubKKxDuOcemvOHGBw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ae72O-0006LY-Fu
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Mar 2016 20:18:24 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ae72N-0004mc-48
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 10 Mar 2016 20:18:24 +0000
Content-Disposition: inline
In-Reply-To: <CAAde8TBW=7=L4JQJ0yTdRxrh5dpOt0KQCubKKxDuOcemvOHGBw@mail.gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hong Mei Li <a21834@motorola.com>
Cc: Zhiming Yuan <a14194@motorola.com>, linux-f2fs-devel@lists.sourceforge.net

Hi,

On Wed, Mar 09, 2016 at 05:52:01PM -0800, Hong Mei Li wrote:
> Thank you Jaegeuk for your quick response.
> 
> When using io_schedule_timeout(timeout), seems the timeout parameter is not
> easy to be determined.
> 
> We do not know how many data to be transferred.
> 
> If we have large amount of data to transact, and the timeout parameter is
> small,
> the waiting task would be waken up several times redundantly and then just
> back to sleep again.

Currently 5*HZ is used.
I think it's okay since wait_on_all_pages_writeback is called only by
checkpoint, which means every operations are waiting for this ends up.
Moreover scheduling redundantly would not a big deal, and pretty rare even.
If we can rely on timeout, we can avoid smp_mb overhead in every end_io too.

Thanks,

> 
> Otherwise, if the timeout parameter is big, then, we are just replacing the
> always stuck problem with a long time stuck?
> 
> By comparing the implementation of wq_has_sleeper and sock_poll_wait,
> we do need paired smp_mb in both wait_on_all_pages_writeback and end_io.
> 
> Thanks
> Hongmei
> 
> 
> 
> On Wed, Mar 9, 2016 at 5:03 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> 
> > Hi Hong Mei,
> >
> > In order to avoid this problem, we already added wq_has_sleeper() which
> > calls
> > smp_mb() in end_io, and use io_schedule_timeout() instead of io_schedule()
> > in
> > wait_on_all_pages_writeback().
> >
> > How do you think whether this is enough or not?
> >
> > Thanks,
> >
> > On Wed, Mar 09, 2016 at 01:42:12PM -0800, Hong Mei Li wrote:
> > > From: Hong-Mei Li <a21834@motorola.com>
> > >
> > >
> > > Sometimes, f2fs fdatasync would stuck at wait_on_all_pages_writeback
> > > with pages count == 0 and itself in the waitlist.
> > >
> > > Fix it by adding an explicit smp_mb() after writting wait list, to make
> > > sure the store is done before get_pages.
> > > And add another memory barrier in wakeup side, to make sure cpu reading
> > > wait list happens after decreased pages count syncing to memory.
> > >
> > > Signed-off-by: Hong-Mei Li <a21834@motorola.com>
> > > Cc: linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> > >
> > > ---
> > >  fs/f2fs/checkpoint.c | 1 +
> > >  fs/f2fs/data.c       | 1 +
> > >  2 files changed, 2 insertions(+)
> > >
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index 3842af9..4e5acab 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -899,6 +899,7 @@ static void wait_on_all_pages_writeback(struct
> > > f2fs_sb_info *sbi)
> > >         for (;;) {
> > >                 prepare_to_wait(&sbi->cp_wait, &wait,
> > TASK_UNINTERRUPTIBLE);
> > >
> > > +               smp_mb();
> > >                 if (!get_pages(sbi, F2FS_WRITEBACK))
> > >                         break;
> > >
> > > diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> > > index 5c06db1..b1d383c 100644
> > > --- a/fs/f2fs/data.c
> > > +++ b/fs/f2fs/data.c
> > > @@ -75,6 +75,7 @@ static void f2fs_write_end_io(struct bio *bio)
> > >                 dec_page_count(sbi, F2FS_WRITEBACK);
> > >         }
> > >
> > > +       smp_mb();
> > >         if (!get_pages(sbi, F2FS_WRITEBACK) &&
> > >                         !list_empty(&sbi->cp_wait.task_list))
> > >                 wake_up(&sbi->cp_wait);
> > > --
> > > 1.9.1
> >
> 
> 
> 
> -- 
> 
> Thanks and Regards
> Hongmei

------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

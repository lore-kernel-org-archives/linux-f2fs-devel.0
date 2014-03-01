From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: fix dirty page accounting when redirty
Date: Sat, 01 Mar 2014 10:35:29 +0800
Message-ID: <000201cf34f7$05e676f0$11b364d0$@samsung.com>
References: <000001cf342a$95864830$c092d890$@samsung.com>
	<20140301002643.GL30131@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WJZn7-0003Ew-Qp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Mar 2014 02:36:41 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WJZn4-0004Yr-Cp
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Mar 2014 02:36:41 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N1Q00I5LKKSDI60@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 01 Mar 2014 11:36:28 +0900 (KST)
In-reply-to: <20140301002643.GL30131@dastard>
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
To: 'Dave Chinner' <david@fromorbit.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Dave Chinner [mailto:david@fromorbit.com]
> Sent: Saturday, March 01, 2014 8:27 AM
> To: Chao Yu
> Cc: ???; linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH] f2fs: fix dirty page accounting when redirty
> 
> On Fri, Feb 28, 2014 at 10:12:05AM +0800, Chao Yu wrote:
> > We should de-account dirty counters for page when redirty in ->writepage().
> >
> > Wu Fengguang described in 'commit 971767caf632190f77a40b4011c19948232eed75':
> > "writeback: fix dirtied pages accounting on redirty
> > De-account the accumulative dirty counters on page redirty.
> >
> > Page redirties (very common in ext4) will introduce mismatch between
> > counters (a) and (b)
> >
> > a) NR_DIRTIED, BDI_DIRTIED, tsk->nr_dirtied
> > b) NR_WRITTEN, BDI_WRITTEN
> >
> > This will introduce systematic errors in balanced_rate and result in
> > dirty page position errors (ie. the dirty pages are no longer balanced
> > around the global/bdi setpoints)."
> >
> > Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> > ---
> >  fs/f2fs/checkpoint.c |    1 +
> >  fs/f2fs/data.c       |    1 +
> >  fs/f2fs/node.c       |    1 +
> >  3 files changed, 3 insertions(+)
> >
> > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > index c8516ee..f069249 100644
> > --- a/fs/f2fs/checkpoint.c
> > +++ b/fs/f2fs/checkpoint.c
> > @@ -178,6 +178,7 @@ no_write:
> >  redirty_out:
> >  	dec_page_count(sbi, F2FS_DIRTY_META);
> >  	wbc->pages_skipped++;
> > +	account_page_redirty(page);
> >  	set_page_dirty(page);
> >  	return AOP_WRITEPAGE_ACTIVATE;
> 
> redirty_page_for_writepage()?

set_page_dirty() in a_ops of f2fs not only call __set_page_dirty_nobuffers(),
but also set some private data of page and print trace info.
So it seems we could not easily replace with redirty_page_for_writepage().

Thanks.

> 
> Cheers,
> 
> Dave.
> --
> Dave Chinner
> david@fromorbit.com


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk

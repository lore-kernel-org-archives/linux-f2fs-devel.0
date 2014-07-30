From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH 08/11] f2fs: fix wrong condition for unlikely
Date: Wed, 30 Jul 2014 20:58:37 +0800
Message-ID: <00f401cfabf6$14f52b70$3edf8250$@samsung.com>
References: <1406328445-63707-1-git-send-email-jaegeuk@kernel.org>
	<1406328445-63707-8-git-send-email-jaegeuk@kernel.org>
	<009901cfab97$f2981be0$d7c853a0$@samsung.com>
	<20140730031820.GC99885@jaegeuk-mac02>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XCTTe-0007Kt-7n
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 12:59:30 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XCTTb-00034B-Ra
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 12:59:30 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9J00JFX02WWXC0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 30 Jul 2014 21:59:20 +0900 (KST)
In-reply-to: <20140730031820.GC99885@jaegeuk-mac02>
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
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Wednesday, July 30, 2014 11:18 AM
> To: Chao Yu
> Cc: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH 08/11] f2fs: fix wrong condition for unlikely
> 
> On Wed, Jul 30, 2014 at 09:44:43AM +0800, Chao Yu wrote:
> > Hi Jaegeuk,
> >
> > > -----Original Message-----
> > > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > > Sent: Saturday, July 26, 2014 6:47 AM
> > > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > > linux-f2fs-devel@lists.sourceforge.net
> > > Cc: Jaegeuk Kim
> > > Subject: [f2fs-dev] [PATCH 08/11] f2fs: fix wrong condition for unlikely
> > >
> > > This patch fixes the wrongly used unlikely condition.
> > >
> > > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> > > ---
> > >  fs/f2fs/checkpoint.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> > > index 42a16c1..36b0d47 100644
> > > --- a/fs/f2fs/checkpoint.c
> > > +++ b/fs/f2fs/checkpoint.c
> > > @@ -932,7 +932,7 @@ static void do_checkpoint(struct f2fs_sb_info *sbi, bool is_umount)
> > >  	/* Here, we only have one bio having CP pack */
> > >  	sync_meta_pages(sbi, META_FLUSH, LONG_MAX);
> > >
> > > -	if (unlikely(!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG))) {
> > > +	if (!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG)) {
> >
> > Maybe use likely(!is_set_ckpt_flags(ckpt, CP_ERROR_FLAG)) or
> >
> > if (unlikely(is_set_ckpt_flags(ckpt, CP_ERROR_FLAG)))
> > 	return;
> >
> > is more appropriate. How do you think?
> 
> Currently I'd like to put this without any likely or unlikely.
> Best thing is to measure some performance how this would make effect on.

I think we could get little improvement of performance if we use likely or unlikely
here. So if you'd like leave it without pre-judgment, it will be ok.
Let's just leave it as it was. :)

Thanks,

> Until then, it'd be better to do without it, since apparently this should
> not be unlikely.
> 
> How about you?
> Can we compare both of them explicitly?
> 
> Thanks,
> 
> >
> > >  		clear_prefree_segments(sbi);
> > >  		release_dirty_inode(sbi);
> > >  		F2FS_RESET_SB_DIRT(sbi);
> > > --
> > > 1.8.5.2 (Apple Git-48)
> > >
> > >
> > > ------------------------------------------------------------------------------
> > > Want fast and easy access to all the code in your enterprise? Index and
> > > search up to 200,000 lines of code with a free copy of Black Duck
> > > Code Sight - the same software that powers the world's largest code
> > > search on Ohloh, the Black Duck Open Hub! Try it now.
> > > http://p.sf.net/sfu/bds
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk

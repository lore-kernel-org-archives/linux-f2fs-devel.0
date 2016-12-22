From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v3] f2fs: fix a missing discard prefree
 segments
Date: Wed, 21 Dec 2016 18:21:22 -0800
Message-ID: <20161222022122.GA33509@jaegeuk.local>
References: <20161221092716.18049-1-heyunlei@huawei.com>
	<20161221180431.GB1361@jaegeuk.local>
	<69ab3186-0d74-624b-0d4c-2b10a187c230@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cJt0g-0007Xq-OY
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Dec 2016 02:21:34 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cJt0c-00055K-VE
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Dec 2016 02:21:34 +0000
Content-Disposition: inline
In-Reply-To: <69ab3186-0d74-624b-0d4c-2b10a187c230@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: heyunlei <heyunlei@huawei.com>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

On 12/22, heyunlei wrote:
> Hi Jaegeuk,
> 
> On 2016/12/22 2:04, Jaegeuk Kim wrote:
> > On 12/21, Yunlei He wrote:
> > > If userspace issue a fstrim with a range not involve prefree segments,
> > > it will reuse these segments without discard. This patch fix it.
> > > 
> > > Signed-off-by: Yunlei He <heyunlei@huawei.com>
> > > ---
> > >  fs/f2fs/segment.c | 9 +++++++--
> > >  1 file changed, 7 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > > index 0738f48..e0fff28 100644
> > > --- a/fs/f2fs/segment.c
> > > +++ b/fs/f2fs/segment.c
> > > @@ -916,9 +916,13 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > > 
> > >  		dirty_i->nr_dirty[PRE] -= end - start;
> > > 
> > > -		if (force || !test_opt(sbi, DISCARD))
> > > +		if (!test_opt(sbi, DISCARD))
> > >  			continue;
> > > 
> > > +		if (force && start >= cpc->trim_start &&
> > > +					(end -1) <= cpc->trim_end)
> > > +				continue;
> > > +
> > >  		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
> > >  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
> > >  				(end - start) << sbi->log_blocks_per_seg);
> > > @@ -2263,7 +2267,8 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> > >  	f2fs_bug_on(sbi, sit_i->dirty_sentries);
> > >  out:
> > >  	if (cpc->reason == CP_DISCARD) {
> > > -		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
> > > +		__u64 trim_start = cpc->trim_start;
> > > +		for (; trim_start <= cpc->trim_end; trim_start++)
> > 
> > BTW, why do we need this?
> > The below add_discard_addrs() will use cpc->trim_start.
> 
> Here, we need to reserve the original value of cpc->trim_start, because
> we will use it as a boundary judgement for skipping prefree segments
> discard.  How about this:

Looks good to me. :)
Could you send v4?

Thanks,

> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0738f48..30cd445 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -916,9 +916,13 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
> 
>                 dirty_i->nr_dirty[PRE] -= end - start;
> 
> -               if (force || !test_opt(sbi, DISCARD))
> +               if (!test_opt(sbi, DISCARD))
>                         continue;
> 
> +               if (force && start >= cpc->trim_start &&
> +                                       (end -1) <= cpc->trim_end)
> +                               continue;
> +
>                 if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
>                         f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>                                 (end - start) << sbi->log_blocks_per_seg);
> @@ -2263,8 +2267,11 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>         f2fs_bug_on(sbi, sit_i->dirty_sentries);
>  out:
>         if (cpc->reason == CP_DISCARD) {
> +               __u64 trim_start = cpc->trim_start;
>                 for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
>                         add_discard_addrs(sbi, cpc);
> +
> +               cpc->trim_start = trim_start;
>         }
>         mutex_unlock(&sit_i->sentry_lock);
> 
> Thanks,
> 
> > 
> > Thanks,
> > 
> > >  			add_discard_addrs(sbi, cpc);
> > >  	}
> > >  	mutex_unlock(&sit_i->sentry_lock);
> > > --
> > > 2.10.1
> > > 
> > > 
> > > ------------------------------------------------------------------------------
> > > Developer Access Program for Intel Xeon Phi Processors
> > > Access to Intel Xeon Phi processor-based developer platforms.
> > > With one year of Intel Parallel Studio XE.
> > > Training and support from Colfax.
> > > Order your platform today.http://sdm.link/intel
> > > _______________________________________________
> > > Linux-f2fs-devel mailing list
> > > Linux-f2fs-devel@lists.sourceforge.net
> > > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> > 
> > .
> > 

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel

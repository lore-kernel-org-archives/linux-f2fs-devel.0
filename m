From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [oops, 4.4-rc8] warn + oops during generic/204
Date: Sat, 23 Jan 2016 12:15:32 -0800
Message-ID: <20160123201532.GA61827@jaegeuk.hsd1.ca.comcast.net>
References: <20160120213102.GF20456@dastard>
	<008501d15441$68c7d870$3a578950$@samsung.com>
	<20160122015259.GB53329@jaegeuk>
	<00ab01d154dc$6099de50$21cd9af0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aN4b0-0004o5-1x
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 20:15:42 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aN4ay-0006LB-Pf for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 23 Jan 2016 20:15:42 +0000
Content-Disposition: inline
In-Reply-To: <00ab01d154dc$6099de50$21cd9af0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Dave Chinner' <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Fri, Jan 22, 2016 at 02:15:26PM +0800, Chao Yu wrote:
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Friday, January 22, 2016 9:53 AM
> > To: Chao Yu
> > Cc: 'Dave Chinner'; linux-f2fs-devel@lists.sourceforge.net
> > Subject: Re: [f2fs-dev] [oops, 4.4-rc8] warn + oops during generic/204
> > 
> > On Thu, Jan 21, 2016 at 07:46:10PM +0800, Chao Yu wrote:
> > > Hi Dave,
> > >
> > > > -----Original Message-----
> > > > From: Dave Chinner [mailto:david@fromorbit.com]
> > > > Sent: Thursday, January 21, 2016 5:31 AM
> > > > To: linux-f2fs-devel@lists.sourceforge.net
> > > > Subject: [f2fs-dev] [oops, 4.4-rc8] warn + oops during generic/204
> > > >
> > > > Hi f2fs folks,
> > > >
> > > > I just ran xfstests on f2fs using defaults and a pair of 4GB ram
> > > > disks for the test and scratch devices, and it hard locked the
> > > > machine with this failure in generic/204:
> > >
> > > Thanks for your report! :)
> > >
> > > Hi all,
> > >
> > > We didn't handle well with the case of inline data storm which floods
> > > full disk. Actually the reason is: if we have 10M free space, and user
> > > fillings the disk with ~10M inline data, then in memory there are ~10M
> > > dirty inline datas and ~10M dirty inodes, once inodes were writebacked
> > > before inline datas, all free space will be occupied, then we have to
> > > write these dirty inline datas to ovp area which doesn't have enough
> > > space there normally.
> > 
> > Well, I think the user block count was wrong which is determined by mkfs.f2fs.
> > When writing inline_data, gc should activate to reclaim the space, but it
> > seems it couldn't do that cause there is no victim.
> > So, when taking a look at mkfs, I suspect that the number of total user blocks
> > does not consider our current segments, which is 6 by default.
> > IOWs, we gave more blocks to users, which turns out actually gc couldn't get a
> > victim from them in this case.
> 
> Hmm, I don't think this could fix similar inline storm issue, I change some
> parameters in generic/204 like below patch, and do the test with your patch
> based on commit 9b72a388f586 ("f2fs: skip releasing nodes in chindless extent
> tree"), oops occurs again, still the same problem. :(

Urg, yes.

> 
> ---
>  tests/generic/204 | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/generic/204 b/tests/generic/204
> index 24a2a94..4db1533 100755
> --- a/tests/generic/204
> +++ b/tests/generic/204
> @@ -56,7 +56,7 @@ _scratch_mkfs 2> /dev/null | _filter_mkfs 2> $tmp.mkfs > /dev/null
>  # And v4/512 v5/1k xfs don't have enough free inodes, set imaxpct=50 at mkfs
>  # time solves this problem.
>  [ $FSTYP = "xfs" ] && MKFS_OPTIONS="$MKFS_OPTIONS -l size=7m -i maxpct=50"
> -SIZE=`expr 106 \* 1024 \* 1024`
> +SIZE=`expr 406 \* 1024 \* 1024`
>  
>  _scratch_mkfs_sized $SIZE $dbsize 2> /dev/null \
>  		| _filter_mkfs 2> $tmp.mkfs > /dev/null
> @@ -69,7 +69,7 @@ _scratch_mount
>  # work out correctly. Space usages is based 22500 files and 1024 reserved blocks
>  # on a 4k block size 256 byte inode size filesystem.
>  resv_blks=1024
> -space=97920000
> +space=397920000
>  
>  # decrease files for inode size.
>  #	22500 * (256 + 4k) = ~97MB
> -- 
> 2.6.3
> 
> I traced the details of this issue, we can get some hints with below datas:
> 
> steps in this issue:
> a) generic/204: submit 22 * 512 inline data
> b) f2fs_write_node_pages: f2fs_balance_fs_bg->f2fs_sync_fs
> c) f2fs_write_data_pages: write inline data page into inode page
> d) f2fs_write_node_pages: persist inode pages
> 
> 
> Test #1, mkfs.f2fs: not patched,  generic/204: not patched:
> [MAIN: 45(OverProv:23 Resv:16)]
> valid user segment = 45 - 23 = 22
> 	inline data	dentry		node		free segment	prefree+dirty
> a)	22		1		22		39		0
> b)	22		0		0		18		0
> c)	0		0		22		18		0
> d)	0		0		4		0		19
> 
> Test #2, mkfs.f2fs: patched,  generic/204: not patched:
> [MAIN: 45(OverProv:23 Resv:16)]
> valid user segment = 45 - 23 - 6 = 16
> 	inline data	dentry		node		free segment	prefree+dirty
> a)	16		1		16		39		0
> b)	16		0		0		23		0
> c)	0		0		16		23		0
> d)	0		0		0		7		16
> 
> Test #3, mkfs.f2fs: patched,  generic/204: patched:
> [MAIN: 195(OverProv:44 Resv:28)]
> valid user segment = 195 - 44 - 6 = 145
> 	inline data	dentry		node		free segment	prefree+dirty
> a)	145		1		145		189		0
> b)	145		0		0		45		0
> c)	0		0		145		45		0
> d)	0		0		99		0		46
> 
> Once we arrive step c), we would face the danger, because writebacking
> of dirty node page will exhaust free segments, result in oops.
> During step c) to step d), inode pages were COWed, prefree will increase,
> it's a pity these prefree segments could only be reused after a checkpoint,
> however checkpoint needs more free space for flushing dirty nodes, that
> also will exhaust free segments, this likes a chicken and egg problem.
> 
> Any idea to solve this?

One question is why f2fs_gc couldn't make the free space during c).
The answer was there was no victim and no prefree segments, but the dirty node
blocks are producing suddenly.

I wrote two patches regarding to this issue.
Could you check them too?

Thanks,

> 
> Thanks,
> 
> > 
> > I could reproduce this issue, and once I reduced the number by 6 segments,
> > I could avoid the issue.
> > 
> > Here the change of f2fs-tools.
> > 
> > From 411166a44009bb138eca937376863e9ce673278a Mon Sep 17 00:00:00 2001
> > From: Jaegeuk Kim <jaegeuk@kernel.org>
> > Date: Thu, 21 Jan 2016 05:16:37 -0800
> > Subject: [PATCH] mkfs.f2fs: adjust current segments for total usable blocks
> > 
> > When calculating total number of user blocks, we should reserve the current
> > segments.
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> > ---
> >  mkfs/f2fs_format.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index 2c81ecc..b25a490 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -474,7 +474,12 @@ static int f2fs_write_check_point_pack(void)
> > 
> >  	/* main segments - reserved segments - (node + data segments) */
> >  	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
> > -	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
> > +	if (get_cp(free_segment_count) <= get_cp(overprov_segment_count)) {
> > +		MSG(0, "Error: Too small size\n");
> > +		goto free_sum_compact;
> > +	}
> > +
> > +	set_cp(user_block_count, ((get_cp(free_segment_count) -
> >  			get_cp(overprov_segment_count)) * config.blks_per_seg));
> >  	/* cp page (2), data summaries (1), node summaries (3) */
> >  	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
> > --
> > 2.6.3
> 

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140

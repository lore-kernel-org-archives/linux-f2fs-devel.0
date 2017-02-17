From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC] add ovp valid_blocks check for bg gc victim to
 fg_gc
Date: Fri, 17 Feb 2017 12:17:32 -0800
Message-ID: <20170217201732.GE2951@jaegeuk.local>
References: <20170216123431.14811-1-houpengyang@huawei.com>
	<20170216234813.GA64229@jaegeuk.local>
	<58A660F2.1070201@huawei.com>
	<20170217025411.GA79127@jaegeuk.local>
	<58A685A7.3000601@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ceoyL-0004wW-Pf
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 20:17:41 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ceoyK-0001xg-M7
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 17 Feb 2017 20:17:41 +0000
Content-Disposition: inline
In-Reply-To: <58A685A7.3000601@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

On 02/17, Hou Pengyang wrote:

...

> > > On 2017/2/17 7:48, Jaegeuk Kim wrote:
> > > > +	ovp_count = SM_I(sbi)->ovp_segments << sbi->log_blocks_per_seg;
> > > 
> > > About the ovp_count calculation,
> > > 
> > > in mkfs.f2fs, we get ovp_segment by
> > > 
> > >      set_cp(overprov_segment_count, (get_sb(segment_count_main) -
> > >             get_cp(rsvd_segment_count)) *
> > >              config.overprovision / 100);
> > > 
> > >      set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
> > >              get_cp(rsvd_segment_count));
> > > 
> > > where the overprov calculation is based on the space excluding the
> > > rsvd segment, and the final overprov_segment is sum of the REAL
> > > overprov segments and the rsvd ones.
> > > 
> > > So, when to calculate the overprov ratio, the rsvd segments should
> > > be subtracted from the ckpt->overprov_semgents?
> > 
> > I just got calculation from fresh mounted image. What I could confirm was that
> > user can see (main_segments - ovp_segments).
> 
> I add some log into mkfs.f2fs, and get the config.overprovision,
> rsvd/ovrp segments, user_block_count, and use the mkfs.f2fs to formatting a
> 512M disk, where:
> 
> config.overprovision: 10
> 
> ovrp : 50 segments(25600 blocks)
> rsvd : 28 segments(14336 blocks)
> user_block_count: 101376 blocks
> 
> Use ovrp/rsvd/user_block_count to get the ovrp ratio info reversely :
> 
> 1) user_block_count/(user_block_count + ovrp blocks)
> 
>   101376/(101376+25600) = 79%
> 
> 2) user_block_count/(user_block_count + ovrp_blocks - rsvd_blocks)
> 
>   101376/(101376+25600-14336) = 90% = 1-10%
> 
> By 2), 1-90%, we can get the original config.overprovion when mkfs.f2fs
> So I think we should use 2) to calculate ovrp ratio. Anything I miss
> in 2)?

Yup, indeed 2) is correct, which I found my calcuation was wrong, and tried
to verify with:

threshold = (main_segments - ovp_segments) / (main_segments - reserved_segments)
            ------------------------------    ---------------------------------
                User-visible space                  F2FS-writable space
              (user_block_count) / (user_block_count + ovp_blocks - rsvd_blocks)

For example,

1. 8GB
 ovp reported by mkfs = 2.22%
 main_segments = 4065
 ovp_segments = 186
 reserved_segments = 98
 threshold = 500 (mine) vs. 502 (yours)

 -> Actual ovp = (512-500) / 512 = 2.34%
 -> reserved segments = 98 / 2 = 49 can cover 2.34%

2. 64GB
 ovp reported by mkfs = 0.78%
 main_segments = 32581
 ovp_segments = 516
 reserved_segments = 264
 threshold = 508 (mine) vs. 512 (yours)

 -> Actual ovp = (512-508) / 512 = 0.78%
 -> reserved segments = 264 / 2 = 132 can cover 0.78%

Thanks,

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

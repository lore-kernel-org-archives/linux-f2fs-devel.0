From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: fix overflow bug of start_sector
 when computing zone_align_start_offset
Date: Tue, 29 May 2018 19:33:57 -0700
Message-ID: <20180530023357.GB39056@jaegeuk-macbookpro.roam.corp.google.com>
References: <1527322189-114752-1-git-send-email-yunlong.song@huawei.com>
 <a6732361-57a7-249b-ba75-3dd5e5bb18a2@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1fNqwA-0002lm-H2
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 02:34:06 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fNqw8-00768k-Ms
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 30 May 2018 02:34:06 +0000
Content-Disposition: inline
In-Reply-To: <a6732361-57a7-249b-ba75-3dd5e5bb18a2@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: yunlong.song@icloud.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

On 05/28, Chao Yu wrote:
> On 2018/5/26 16:09, Yunlong Song wrote:
> > zone_align_start_offset should be u64, but config.start_sector is u32,
> > so it may be overflow when computing zone_align_start_offset.
> 
> Could you rebase this patch on top of "f2fs-tools: fix to match with the
> start_sector"?

Yes, please. I updated dev-test. :P

> 
> Thanks,
> 
> > 
> > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> > ---
> >  fsck/resize.c      | 7 ++++---
> >  mkfs/f2fs_format.c | 4 ++--
> >  2 files changed, 6 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fsck/resize.c b/fsck/resize.c
> > index d285dd7..8ac7d45 100644
> > --- a/fsck/resize.c
> > +++ b/fsck/resize.c
> > @@ -11,7 +11,8 @@
> >  
> >  static int get_new_sb(struct f2fs_super_block *sb)
> >  {
> > -	u_int32_t zone_size_bytes, zone_align_start_offset;
> > +	u_int32_t zone_size_bytes;
> > +	u_int64_t zone_align_start_offset;
> >  	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
> >  	u_int32_t sit_segments, nat_segments, diff, total_meta_segments;
> >  	u_int32_t total_valid_blks_available;
> > @@ -27,10 +28,10 @@ static int get_new_sb(struct f2fs_super_block *sb)
> >  
> >  	zone_size_bytes = segment_size_bytes * segs_per_zone;
> >  	zone_align_start_offset =
> > -		(c.start_sector * c.sector_size +
> > +		((u_int64_t) c.start_sector * c.sector_size +
> >  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> >  		zone_size_bytes * zone_size_bytes -
> > -		c.start_sector * c.sector_size;
> > +		(u_int64_t) c.start_sector * c.sector_size;
> >  
> >  	set_sb(segment_count, (c.target_sectors * c.sector_size -
> >  				zone_align_start_offset) / segment_size_bytes /
> > diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> > index 0a99a77..f045e23 100644
> > --- a/mkfs/f2fs_format.c
> > +++ b/mkfs/f2fs_format.c
> > @@ -212,10 +212,10 @@ static int f2fs_prepare_super_block(void)
> >  	set_sb(block_count, c.total_sectors >> log_sectors_per_block);
> >  
> >  	zone_align_start_offset =
> > -		(c.start_sector * c.sector_size +
> > +		((u_int64_t) c.start_sector * c.sector_size +
> >  		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> >  		zone_size_bytes * zone_size_bytes -
> > -		c.start_sector * c.sector_size;
> > +		(u_int64_t) c.start_sector * c.sector_size;
> >  
> >  	if (c.start_sector % c.sectors_per_blk) {
> >  		MSG(1, "\t%s: Align start sector number to the page unit\n",
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

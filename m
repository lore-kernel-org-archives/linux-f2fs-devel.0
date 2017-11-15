From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: check sit bitmap under sentry_lock
Date: Wed, 15 Nov 2017 08:30:40 -0800
Message-ID: <20171115163040.GD33528@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171113095439.49897-1-yuchao0@huawei.com>
 <126ac734-9ff4-8b27-ea0b-386f0caaff55@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-1.v28.ch3.sourceforge.com ([172.29.28.191]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1eF0aO-0002dF-ML
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Nov 2017 16:30:48 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1eF0aN-0008Tf-S7
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 15 Nov 2017 16:30:48 +0000
Content-Disposition: inline
In-Reply-To: <126ac734-9ff4-8b27-ea0b-386f0caaff55@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 11/15, Chao Yu wrote:
> Hi Jaegeuk,
> 
> Please drop this patch first, as it still can trigger deadlock as below, sorry
> about this mistake.

Got it. Thank you.

> 
> - f2fs_put_super
>  - f2fs_wait_discard_bios
>   - __issue_discard_cmd
>    - lock(&dcc->cmd_lock);		A
>    - __check_sit_bitmap
>     - down_read(&sit_i->sentry_lock)	B
> 
> - do_write_page
>  - allocate_data_block
>   - down_write(&sit_i->sentry_lock)	B
>   - locate_dirty_segment
>    - lock(&dirty_i->seglist_lock)	C
> 
> - write_checkpoint
>  - clear_prefree_segments
>   - lock(&dirty_i->seglist_lock)	C
>    - f2fs_issue_discard
>     - __issue_discard_async
>      - __queue_discard_cmd
>       - __update_discard_tree_range
>        - lock(&dcc->cmd_lock)		A
> 
> Thanks,
> 
> On 2017/11/13 17:54, Chao Yu wrote:
> > This patch protects sit bitmap accessing in __check_sit_bitmap with
> > sentry_lock, meanwhile, in allocate_data_block, f2fs_wait_discard_bio
> > will not access/update sit cache, let's exclude it from sentry_lock's
> > region.>
> > Signed-off-by: Chao Yu <yuchao0@huawei.com>
> > ---
> >  fs/f2fs/segment.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> > 
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index c117e0913f2a..464696b1612a 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -894,6 +894,8 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> >  	unsigned long offset, size, max_blocks = sbi->blocks_per_seg;
> >  	unsigned long *map;
> >  
> > +	down_read(&SIT_I(sbi)->sentry_lock);
> > +
> >  	while (blk < end) {
> >  		segno = GET_SEGNO(sbi, blk);
> >  		sentry = get_seg_entry(sbi, segno);
> > @@ -908,6 +910,8 @@ void __check_sit_bitmap(struct f2fs_sb_info *sbi,
> >  		f2fs_bug_on(sbi, offset != size);
> >  		blk = START_BLOCK(sbi, segno + 1);
> >  	}
> > +
> > +	up_read(&SIT_I(sbi)->sentry_lock);
> >  #endif
> >  }
> >  
> > @@ -2527,12 +2531,13 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >  	down_read(&SM_I(sbi)->curseg_lock);
> >  
> >  	mutex_lock(&curseg->curseg_mutex);
> > -	down_write(&sit_i->sentry_lock);
> >  
> >  	*new_blkaddr = NEXT_FREE_BLKADDR(sbi, curseg);
> >  
> >  	f2fs_wait_discard_bio(sbi, *new_blkaddr);
> >  
> > +	down_write(&sit_i->sentry_lock);
> > +
> >  	/*
> >  	 * __add_sum_entry should be resided under the curseg_mutex
> >  	 * because, this function updates a summary entry in the
> > 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

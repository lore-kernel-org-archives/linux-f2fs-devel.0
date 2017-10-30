From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 RESEND] Revert "f2fs: handle dirty segments inside
 refresh_sit_entry"
Date: Mon, 30 Oct 2017 02:39:08 -0700
Message-ID: <20171030093908.GC26880@jaegeuk-macbookpro.roam.corp.google.com>
References: <20171028115709.4622-1-chao@kernel.org>
 <1509327221-159302-1-git-send-email-yunlong.song@huawei.com>
 <043afe52-6c41-933f-9382-07cee10f447f@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <043afe52-6c41-933f-9382-07cee10f447f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: Yunlong Song <yunlong.song@huawei.com>, yunlong.song@icloud.com, chao@kernel.org, miaoxie@huawei.com, bintian.wang@huawei.com, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 10/30, Chao Yu wrote:
> On 2017/10/30 9:33, Yunlong Song wrote:
> > This reverts commit 5e443818fa0b2a2845561ee25bec181424fb2889
> > 
> > The commit should be reverted because call sequence of below two parts
> > of code must be kept:
> > a. update sit information, it needs to be updated before segment
> > allocation since latter allocation may trigger SSR, and SSR allocation
> > needs latest valid block information of all segments.
> > b. update segment status, it needs to be updated after segment allocation
> > since we can skip updating current opened segment status.
> > 
> > Fixes: 5e443818fa0b ("f2fs: handle dirty segments inside refresh_sit_entry")
> > Suggested-by: Chao Yu <yuchao0@huawei.com>
> > Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> 
> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> 
> Thanks,
> 
> > ---
> >  fs/f2fs/f2fs.h    |  1 -
> >  fs/f2fs/segment.c | 20 +++++++++++++-------
> >  2 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> > index 13a96b8..f166112 100644
> > --- a/fs/f2fs/f2fs.h
> > +++ b/fs/f2fs/f2fs.h
> > @@ -2567,7 +2567,6 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
> >  bool is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
> >  void init_discard_policy(struct discard_policy *dpolicy, int discard_type,
> >  						unsigned int granularity);
> > -void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new);
> >  void stop_discard_thread(struct f2fs_sb_info *sbi);
> >  bool f2fs_wait_discard_bios(struct f2fs_sb_info *sbi);
> >  void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc);
> > diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> > index 46dfbca..a3509e9 100644
> > --- a/fs/f2fs/segment.c
> > +++ b/fs/f2fs/segment.c
> > @@ -1884,14 +1884,11 @@ static void update_sit_entry(struct f2fs_sb_info *sbi, block_t blkaddr, int del)
> >  		get_sec_entry(sbi, segno)->valid_blocks += del;
> >  }
> >  
> > -void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)
> > +static void refresh_sit_entry(struct f2fs_sb_info *sbi, block_t old, block_t new)

IMO, we don't even need this function, and insteda, do update_sit_entry work
directly below. Merged with it, so let me know, if you have any concern.

Thanks,

> >  {
> >  	update_sit_entry(sbi, new, 1);
> >  	if (GET_SEGNO(sbi, old) != NULL_SEGNO)
> >  		update_sit_entry(sbi, old, -1);
> > -
> > -	locate_dirty_segment(sbi, GET_SEGNO(sbi, old));
> > -	locate_dirty_segment(sbi, GET_SEGNO(sbi, new));
> >  }
> >  
> >  void invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr)
> > @@ -2529,13 +2526,22 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
> >  
> >  	stat_inc_block_count(sbi, curseg);
> >  
> > +	/*
> > +	 * SIT information should be updated before segment allocation,
> > +	 * since SSR needs latest valid block information.
> > +	 */
> > +	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
> > +
> >  	if (!__has_curseg_space(sbi, type))
> >  		sit_i->s_ops->allocate_segment(sbi, type, false);
> > +
> >  	/*
> > -	 * SIT information should be updated after segment allocation,
> > -	 * since we need to keep dirty segments precisely under SSR.
> > +	 * segment dirty status should be updated after segment allocation,
> > +	 * so we just need to update status only one time after previous
> > +	 * segment being closed.
> >  	 */
> > -	refresh_sit_entry(sbi, old_blkaddr, *new_blkaddr);
> > +	locate_dirty_segment(sbi, GET_SEGNO(sbi, old_blkaddr));
> > +	locate_dirty_segment(sbi, GET_SEGNO(sbi, *new_blkaddr));
> >  
> >  	mutex_unlock(&sit_i->sentry_lock);
> >  
> > 

From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2 1/3] f2fs: introduce replace_block() for reuse
Date: Thu, 30 Apr 2015 11:03:40 -0700
Message-ID: <20150430180340.GA23431@jaegeuk-mac02.mot.com>
References: <025501d0832e$24f33fc0$6ed9bf40$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <025501d0832e$24f33fc0$6ed9bf40$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Thu, Apr 30, 2015 at 06:11:35PM +0800, Chao Yu wrote:
> Introduce a generic function replace_block base on recover_data_page,
> and export it. So wit it we can operate file's meta data which is in
> CP/SSA area when we invoke fallocate with FALLOC_FL_COLLAPSE_RANGE flag.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/f2fs.h     |  4 ++--
>  fs/f2fs/recovery.c |  2 +-
>  fs/f2fs/segment.c  | 33 ++++++++++++++++++++++++++-------
>  3 files changed, 29 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 8be6cab..7ab06e8 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1560,8 +1560,8 @@ void write_node_page(struct f2fs_sb_info *, struct page *,
>  void write_data_page(struct page *, struct dnode_of_data *,
>  			struct f2fs_io_info *);
>  void rewrite_data_page(struct page *, struct f2fs_io_info *);
> -void recover_data_page(struct f2fs_sb_info *, struct page *,
> -				struct f2fs_summary *, block_t, block_t);
> +void replace_block(struct f2fs_sb_info *, struct f2fs_summary *,
> +					block_t, block_t, bool);
>  void allocate_data_block(struct f2fs_sb_info *, struct page *,
>  		block_t, block_t *, struct f2fs_summary *, int);
>  void f2fs_wait_on_page_writeback(struct page *, enum page_type);
> diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
> index b80d9d4..703ab2f 100644
> --- a/fs/f2fs/recovery.c
> +++ b/fs/f2fs/recovery.c
> @@ -412,7 +412,7 @@ static int do_recover_data(struct f2fs_sb_info *sbi, struct inode *inode,
>  			set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
>  
>  			/* write dummy data page */
> -			recover_data_page(sbi, NULL, &sum, src, dest);
> +			replace_block(sbi, &sum, src, dest, true);

	It's a little bit confusing.
	The recover_data_page wants not to recover curseg, right?

	So, does it need to call replace_block(.., false);

>  			dn.data_blkaddr = dest;
>  			set_data_blkaddr(&dn);
>  			f2fs_update_extent_cache(&dn);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index f939660..3db92fe 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -1258,26 +1258,34 @@ void rewrite_data_page(struct page *page, struct f2fs_io_info *fio)
>  	f2fs_submit_page_mbio(F2FS_P_SB(page), page, fio);
>  }
>  
> -void recover_data_page(struct f2fs_sb_info *sbi,
> -			struct page *page, struct f2fs_summary *sum,
> -			block_t old_blkaddr, block_t new_blkaddr)
> +void replace_block(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,

How about f2fs_replace_block()?

> +				block_t old_blkaddr, block_t new_blkaddr,
> +				bool recover_curseg)
>  {
>  	struct sit_info *sit_i = SIT_I(sbi);
>  	struct curseg_info *curseg;
>  	unsigned int segno, old_cursegno;
>  	struct seg_entry *se;
>  	int type;
> +	unsigned short old_blkoff;
>  
>  	segno = GET_SEGNO(sbi, new_blkaddr);
>  	se = get_seg_entry(sbi, segno);
>  	type = se->type;
>  
> -	if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
> -		if (old_blkaddr == NULL_ADDR)
> -			type = CURSEG_COLD_DATA;
> -		else
> +	if (recover_curseg) {

	if (!recover_curseg) { ?

> +		/* for recovery flow */
> +		if (se->valid_blocks == 0 && !IS_CURSEG(sbi, segno)) {
> +			if (old_blkaddr == NULL_ADDR)
> +				type = CURSEG_COLD_DATA;
> +			else
> +				type = CURSEG_WARM_DATA;
> +		}
> +	} else {
> +		if (!IS_CURSEG(sbi, segno))
>  			type = CURSEG_WARM_DATA;
>  	}
> +
>  	curseg = CURSEG_I(sbi, type);
>  
>  	mutex_lock(&curseg->curseg_mutex);
> @@ -1289,6 +1297,10 @@ void recover_data_page(struct f2fs_sb_info *sbi,
>  	if (segno != curseg->segno) {
>  		curseg->next_segno = segno;
>  		change_curseg(sbi, type, true);
> +		recover_curseg = true;

		   ^---- Why ?

> +	} else {

	} else if {recover_curseg) {

> +		old_blkoff = curseg->next_blkoff;
> +		recover_curseg = false;

		   ^---- Ditto

>  	}
>  
>  	curseg->next_blkoff = GET_BLKOFF_FROM_SEG0(sbi, new_blkaddr);
> @@ -1297,6 +1309,13 @@ void recover_data_page(struct f2fs_sb_info *sbi,
>  	refresh_sit_entry(sbi, old_blkaddr, new_blkaddr);
>  	locate_dirty_segment(sbi, old_cursegno);
>  
> +	if (recover_curseg) {
> +		cureg->next_segno = old_cursegno;
> +		change_curseg(sbi, type, true);
> +	} else {
> +		curseg->next_blkoff = old_blkoff;
> +	}

	Do we have to do like this?

	if (recover_curseg) {
		cureg->next_segno = old_cursegno;
		change_curseg(sbi, type, true);
		curseg->next_blkoff = old_blkoff;
	}

	Thanks,

> +
>  	mutex_unlock(&sit_i->sentry_lock);
>  	mutex_unlock(&curseg->curseg_mutex);
>  }
> -- 
> 2.3.3

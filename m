From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: speed up gc_urgent mode with SSR and more discard
 commands
Date: Sat, 9 Sep 2017 12:19:12 -0700
Message-ID: <20170909191912.GA81339@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170909181730.78225-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170909181730.78225-1-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It turns out it doesn't need to change discarding policy below.
I submitted another patch to modify SSR mode only.

Thanks,

On 09/09, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> This patch activates SSR and issuing more discard commands in gc_urgent mode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@google.com>
> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 19 ++++++++++++++++++-
>  fs/f2fs/segment.h | 13 -------------
>  3 files changed, 19 insertions(+), 14 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 7a467fcd4bcd..3fbf55e41694 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2517,6 +2517,7 @@ void destroy_node_manager_caches(void);
>  /*
>   * segment.c
>   */
> +bool need_SSR(struct f2fs_sb_info *sbi);
>  void register_inmem_page(struct inode *inode, struct page *page);
>  void drop_inmem_pages(struct inode *inode);
>  void drop_inmem_page(struct inode *inode, struct page *page);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9e708e525ba8..d6e0c160a268 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -168,6 +168,21 @@ static unsigned long __find_rev_next_zero_bit(const unsigned long *addr,
>  	return result - size + __reverse_ffz(tmp);
>  }
>  
> +bool need_SSR(struct f2fs_sb_info *sbi)
> +{
> +	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> +	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> +	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> +
> +	if (test_opt(sbi, LFS))
> +		return false;
> +	if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
> +		return true;
> +
> +	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> +						2 * reserved_sections(sbi));
> +}
> +
>  void register_inmem_page(struct inode *inode, struct page *page)
>  {
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
> @@ -1203,6 +1218,7 @@ static int issue_discard_thread(void *data)
>  	wait_queue_head_t *q = &dcc->discard_wait_queue;
>  	unsigned int wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
>  	int issued;
> +	bool urgent = false;
>  
>  	set_freezable();
>  
> @@ -1218,13 +1234,14 @@ static int issue_discard_thread(void *data)
>  
>  		if (dcc->discard_wake) {
>  			dcc->discard_wake = 0;
> +			urgent = sbi->gc_thread && sbi->gc_thread->gc_urgent;
>  			if (sbi->gc_thread && sbi->gc_thread->gc_urgent)
>  				mark_discard_range_all(sbi);
>  		}
>  
>  		sb_start_intwrite(sbi->sb);
>  
> -		issued = __issue_discard_cmd(sbi, true);
> +		issued = __issue_discard_cmd(sbi, !urgent);
>  		if (issued) {
>  			__wait_discard_cmd(sbi, true);
>  			wait_ms = DEF_MIN_DISCARD_ISSUE_TIME;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index 613b2fa7b1c1..e0a6cc23ace3 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -497,19 +497,6 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
>  	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
>  }
>  
> -static inline bool need_SSR(struct f2fs_sb_info *sbi)
> -{
> -	int node_secs = get_blocktype_secs(sbi, F2FS_DIRTY_NODES);
> -	int dent_secs = get_blocktype_secs(sbi, F2FS_DIRTY_DENTS);
> -	int imeta_secs = get_blocktype_secs(sbi, F2FS_DIRTY_IMETA);
> -
> -	if (test_opt(sbi, LFS))
> -		return false;
> -
> -	return free_sections(sbi) <= (node_secs + 2 * dent_secs + imeta_secs +
> -						2 * reserved_sections(sbi));
> -}
> -
>  static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
>  					int freed, int needed)
>  {
> -- 
> 2.14.0.rc1.383.gd1ce394fe2-goog

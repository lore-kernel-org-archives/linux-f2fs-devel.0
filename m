From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: speed up gc_urgent mode with SSR
Date: Mon, 11 Sep 2017 18:27:07 +0800
Message-ID: <93658b33-9401-3cc6-01eb-140193ca27ec@huawei.com>
References: <20170909191710.81288-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20170909191710.81288-1-jaegeuk@kernel.org>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@google.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2017/9/10 3:17, Jaegeuk Kim wrote:
> From: Jaegeuk Kim <jaegeuk@google.com>
> 
> This patch activates SSR in gc_urgent mode.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/f2fs.h    |  1 +
>  fs/f2fs/segment.c | 15 +++++++++++++++
>  fs/f2fs/segment.h | 13 -------------
>  3 files changed, 16 insertions(+), 13 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c0803b1873b3..9a7c90386947 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2511,6 +2511,7 @@ void destroy_node_manager_caches(void);
>  /*
>   * segment.c
>   */
> +bool need_SSR(struct f2fs_sb_info *sbi);
>  void register_inmem_page(struct inode *inode, struct page *page);
>  void drop_inmem_pages(struct inode *inode);
>  void drop_inmem_page(struct inode *inode, struct page *page);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 9e708e525ba8..f96e61e8ddf7 100644
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
> 

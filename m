From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] staging: erofs: clean up
 erofs_map_blocks_iter
Date: Wed, 9 Jan 2019 17:59:59 +0800
Message-ID: <a3f3223b-b375-0757-d590-39ac56b3ce16@huawei.com>
References: <20190109094654.39285-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1ghAel-0004FZ-II
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 10:00:15 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1ghAef-005yHs-1O
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 09 Jan 2019 10:00:15 +0000
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D60734471A54C3517BBA
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Jan 2019 18:00:01 +0800 (CST)
In-Reply-To: <20190109094654.39285-1-yuchao0@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-f2fs-devel@lists.sourceforge.net

So sorry for the noise, I didn't take care of my git-send-email script.

Please ignore this email. :(

On 2019/1/9 17:46, Chao Yu wrote:
> This patch cleans up erofs_map_blocks* function and structure family,
> just simply the code, no logic change.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  drivers/staging/erofs/data.c      | 40 +++++++------------------------
>  drivers/staging/erofs/internal.h  | 16 ++++++-------
>  drivers/staging/erofs/unzip_vle.c | 30 +++++++++++------------
>  3 files changed, 31 insertions(+), 55 deletions(-)
> 
> diff --git a/drivers/staging/erofs/data.c b/drivers/staging/erofs/data.c
> index 5a55f0bfdfbb..1baa59cf11b5 100644
> --- a/drivers/staging/erofs/data.c
> +++ b/drivers/staging/erofs/data.c
> @@ -165,43 +165,19 @@ static int erofs_map_blocks_flatmode(struct inode *inode,
>  	return err;
>  }
>  
> -#ifdef CONFIG_EROFS_FS_ZIP
> -extern int z_erofs_map_blocks_iter(struct inode *,
> -				   struct erofs_map_blocks *,
> -				   struct page **, int);
> -#endif
> -
> -int erofs_map_blocks_iter(struct inode *inode,
> -			  struct erofs_map_blocks *map,
> -			  struct page **mpage_ret, int flags)
> -{
> -	/* by default, reading raw data never use erofs_map_blocks_iter */
> -	if (unlikely(!is_inode_layout_compression(inode))) {
> -		if (*mpage_ret)
> -			put_page(*mpage_ret);
> -		*mpage_ret = NULL;
> -
> -		return erofs_map_blocks(inode, map, flags);
> -	}
> -
> -#ifdef CONFIG_EROFS_FS_ZIP
> -	return z_erofs_map_blocks_iter(inode, map, mpage_ret, flags);
> -#else
> -	/* data compression is not available */
> -	return -ENOTSUPP;
> -#endif
> -}
> -
>  int erofs_map_blocks(struct inode *inode,
>  		     struct erofs_map_blocks *map, int flags)
>  {
>  	if (unlikely(is_inode_layout_compression(inode))) {
> -		struct page *mpage = NULL;
> -		int err;
> +		int err = -ENOTSUPP;
>  
> -		err = erofs_map_blocks_iter(inode, map, &mpage, flags);
> -		if (mpage)
> -			put_page(mpage);
> +#ifdef CONFIG_EROFS_FS_ZIP
> +		map->mpage = NULL;
> +
> +		err = z_erofs_map_blocks_iter(inode, map, flags);
> +#endif
> +		if (map->mpage)
> +			put_page(map->mpage);
>  		return err;
>  	}
>  	return erofs_map_blocks_flatmode(inode, map, flags);
> diff --git a/drivers/staging/erofs/internal.h b/drivers/staging/erofs/internal.h
> index e049d00c087a..740961fc565f 100644
> --- a/drivers/staging/erofs/internal.h
> +++ b/drivers/staging/erofs/internal.h
> @@ -461,8 +461,16 @@ struct erofs_map_blocks {
>  	u64 m_plen, m_llen;
>  
>  	unsigned int m_flags;
> +
> +	struct page *mpage;
>  };
>  
> +#ifdef CONFIG_EROFS_FS_ZIP
> +extern int z_erofs_map_blocks_iter(struct inode *,
> +				   struct erofs_map_blocks *,
> +				   int);
> +#endif
> +
>  /* Flags used by erofs_map_blocks() */
>  #define EROFS_GET_BLOCKS_RAW    0x0001
>  
> @@ -522,14 +530,6 @@ static inline struct page *erofs_get_meta_page_nofail(struct super_block *sb,
>  }
>  
>  extern int erofs_map_blocks(struct inode *, struct erofs_map_blocks *, int);
> -extern int erofs_map_blocks_iter(struct inode *, struct erofs_map_blocks *,
> -	struct page **, int);
> -
> -struct erofs_map_blocks_iter {
> -	struct erofs_map_blocks map;
> -	struct page *mpage;
> -};
> -
>  
>  static inline struct page *
>  erofs_get_inline_page(struct inode *inode,
> diff --git a/drivers/staging/erofs/unzip_vle.c b/drivers/staging/erofs/unzip_vle.c
> index 4ac1099a39c6..30340afaa504 100644
> --- a/drivers/staging/erofs/unzip_vle.c
> +++ b/drivers/staging/erofs/unzip_vle.c
> @@ -636,7 +636,7 @@ struct z_erofs_vle_frontend {
>  	struct inode *const inode;
>  
>  	struct z_erofs_vle_work_builder builder;
> -	struct erofs_map_blocks_iter m_iter;
> +	struct erofs_map_blocks map;
>  
>  	z_erofs_vle_owned_workgrp_t owned_head;
>  
> @@ -647,8 +647,9 @@ struct z_erofs_vle_frontend {
>  
>  #define VLE_FRONTEND_INIT(__i) { \
>  	.inode = __i, \
> -	.m_iter = { \
> -		{ .m_llen = 0, .m_plen = 0 }, \
> +	.map = { \
> +		.m_llen = 0, \
> +		.m_plen = 0, \
>  		.mpage = NULL \
>  	}, \
>  	.builder = VLE_WORK_BUILDER_INIT(), \
> @@ -681,8 +682,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
>  {
>  	struct super_block *const sb = fe->inode->i_sb;
>  	struct erofs_sb_info *const sbi __maybe_unused = EROFS_SB(sb);
> -	struct erofs_map_blocks_iter *const m = &fe->m_iter;
> -	struct erofs_map_blocks *const map = &m->map;
> +	struct erofs_map_blocks *const map = &fe->map;
>  	struct z_erofs_vle_work_builder *const builder = &fe->builder;
>  	const loff_t offset = page_offset(page);
>  
> @@ -715,7 +715,7 @@ static int z_erofs_do_read_page(struct z_erofs_vle_frontend *fe,
>  
>  	map->m_la = offset + cur;
>  	map->m_llen = 0;
> -	err = erofs_map_blocks_iter(fe->inode, map, &m->mpage, 0);
> +	err = erofs_map_blocks(fe->inode, map, 0);
>  	if (unlikely(err))
>  		goto err_out;
>  
> @@ -1484,8 +1484,8 @@ static int z_erofs_vle_normalaccess_readpage(struct file *file,
>  
>  	z_erofs_submit_and_unzip(&f, &pagepool, true);
>  out:
> -	if (f.m_iter.mpage)
> -		put_page(f.m_iter.mpage);
> +	if (f.map.mpage)
> +		put_page(f.map.mpage);
>  
>  	/* clean up the remaining free pages */
>  	put_pages_list(&pagepool);
> @@ -1555,8 +1555,8 @@ static int z_erofs_vle_normalaccess_readpages(struct file *filp,
>  
>  	z_erofs_submit_and_unzip(&f, &pagepool, sync);
>  
> -	if (f.m_iter.mpage)
> -		put_page(f.m_iter.mpage);
> +	if (f.map.mpage)
> +		put_page(f.map.mpage);
>  
>  	/* clean up the remaining free pages */
>  	put_pages_list(&pagepool);
> @@ -1701,14 +1701,14 @@ vle_get_logical_extent_head(const struct vle_map_blocks_iter_ctx *ctx,
>  
>  int z_erofs_map_blocks_iter(struct inode *inode,
>  	struct erofs_map_blocks *map,
> -	struct page **mpage_ret, int flags)
> +	int flags)
>  {
>  	void *kaddr;
>  	const struct vle_map_blocks_iter_ctx ctx = {
>  		.inode = inode,
>  		.sb = inode->i_sb,
>  		.clusterbits = EROFS_I_SB(inode)->clusterbits,
> -		.mpage_ret = mpage_ret,
> +		.mpage_ret = &map->mpage,
>  		.kaddr_ret = &kaddr
>  	};
>  	const unsigned int clustersize = 1 << ctx.clusterbits;
> @@ -1722,7 +1722,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  
>  	/* initialize `pblk' to keep gcc from printing foolish warnings */
>  	erofs_blk_t mblk, pblk = 0;
> -	struct page *mpage = *mpage_ret;
> +	struct page *mpage = map->mpage;
>  	struct z_erofs_vle_decompressed_index *di;
>  	unsigned int cluster_type, logical_cluster_ofs;
>  	int err = 0;
> @@ -1758,7 +1758,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  			err = PTR_ERR(mpage);
>  			goto out;
>  		}
> -		*mpage_ret = mpage;
> +		map->mpage = mpage;
>  	} else {
>  		lock_page(mpage);
>  		DBG_BUGON(!PageUptodate(mpage));
> @@ -1818,7 +1818,7 @@ int z_erofs_map_blocks_iter(struct inode *inode,
>  		/* get the correspoinding first chunk */
>  		err = vle_get_logical_extent_head(&ctx, lcn, &ofs,
>  						  &pblk, &map->m_flags);
> -		mpage = *mpage_ret;
> +		mpage = map->mpage;
>  
>  		if (unlikely(err)) {
>  			if (mpage)
> 

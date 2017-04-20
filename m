From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: improve definition of statistic macros
Date: Thu, 20 Apr 2017 09:13:57 +0800
Message-ID: <f87ccc24-ca03-a962-0ff0-3efe213c6b73@huawei.com>
References: <20170419173841.3885833-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d10fw-0002lQ-EH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 01:14:24 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d10ft-0002it-Lv
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 20 Apr 2017 01:14:24 +0000
In-Reply-To: <20170419173841.3885833-1-arnd@arndb.de>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc: DongOh Shin <doscode.kr@gmail.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/4/20 1:38, Arnd Bergmann wrote:
> With a recent addition of f2fs_lookup_extent_tree(), we get a warning about
> the use of empty macros:
> 
> fs/f2fs/extent_cache.c: In function 'f2fs_lookup_extent_tree':
> fs/f2fs/extent_cache.c:358:32: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]
>    stat_inc_rbtree_node_hit(sbi);
> 
> A good way to avoid the warning and make the code more robust is to define
> all no-op macros as 'do { } while (0)'.
> 
> Fixes: 54c2258cd63a ("f2fs: extract rb-tree operation infrastructure")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Thank you for the fix. :)

Reivewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h | 58 +++++++++++++++++++++++++++++-----------------------------
>  1 file changed, 29 insertions(+), 29 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 18bb86ac0f33..cdd33af74e01 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -2464,35 +2464,35 @@ void f2fs_destroy_stats(struct f2fs_sb_info *sbi);
>  int __init f2fs_create_root_stats(void);
>  void f2fs_destroy_root_stats(void);
>  #else
> -#define stat_inc_cp_count(si)
> -#define stat_inc_bg_cp_count(si)
> -#define stat_inc_call_count(si)
> -#define stat_inc_bggc_count(si)
> -#define stat_inc_dirty_inode(sbi, type)
> -#define stat_dec_dirty_inode(sbi, type)
> -#define stat_inc_total_hit(sb)
> -#define stat_inc_rbtree_node_hit(sb)
> -#define stat_inc_largest_node_hit(sbi)
> -#define stat_inc_cached_node_hit(sbi)
> -#define stat_inc_inline_xattr(inode)
> -#define stat_dec_inline_xattr(inode)
> -#define stat_inc_inline_inode(inode)
> -#define stat_dec_inline_inode(inode)
> -#define stat_inc_inline_dir(inode)
> -#define stat_dec_inline_dir(inode)
> -#define stat_inc_atomic_write(inode)
> -#define stat_dec_atomic_write(inode)
> -#define stat_update_max_atomic_write(inode)
> -#define stat_inc_volatile_write(inode)
> -#define stat_dec_volatile_write(inode)
> -#define stat_update_max_volatile_write(inode)
> -#define stat_inc_seg_type(sbi, curseg)
> -#define stat_inc_block_count(sbi, curseg)
> -#define stat_inc_inplace_blocks(sbi)
> -#define stat_inc_seg_count(sbi, type, gc_type)
> -#define stat_inc_tot_blk_count(si, blks)
> -#define stat_inc_data_blk_count(sbi, blks, gc_type)
> -#define stat_inc_node_blk_count(sbi, blks, gc_type)
> +#define stat_inc_cp_count(si)				do { } while (0)
> +#define stat_inc_bg_cp_count(si)			do { } while (0)
> +#define stat_inc_call_count(si)				do { } while (0)
> +#define stat_inc_bggc_count(si)				do { } while (0)
> +#define stat_inc_dirty_inode(sbi, type)			do { } while (0)
> +#define stat_dec_dirty_inode(sbi, type)			do { } while (0)
> +#define stat_inc_total_hit(sb)				do { } while (0)
> +#define stat_inc_rbtree_node_hit(sb)			do { } while (0)
> +#define stat_inc_largest_node_hit(sbi)			do { } while (0)
> +#define stat_inc_cached_node_hit(sbi)			do { } while (0)
> +#define stat_inc_inline_xattr(inode)			do { } while (0)
> +#define stat_dec_inline_xattr(inode)			do { } while (0)
> +#define stat_inc_inline_inode(inode)			do { } while (0)
> +#define stat_dec_inline_inode(inode)			do { } while (0)
> +#define stat_inc_inline_dir(inode)			do { } while (0)
> +#define stat_dec_inline_dir(inode)			do { } while (0)
> +#define stat_inc_atomic_write(inode)			do { } while (0)
> +#define stat_dec_atomic_write(inode)			do { } while (0)
> +#define stat_update_max_atomic_write(inode)		do { } while (0)
> +#define stat_inc_volatile_write(inode)			do { } while (0)
> +#define stat_dec_volatile_write(inode)			do { } while (0)
> +#define stat_update_max_volatile_write(inode)		do { } while (0)
> +#define stat_inc_seg_type(sbi, curseg)			do { } while (0)
> +#define stat_inc_block_count(sbi, curseg)		do { } while (0)
> +#define stat_inc_inplace_blocks(sbi)			do { } while (0)
> +#define stat_inc_seg_count(sbi, type, gc_type)		do { } while (0)
> +#define stat_inc_tot_blk_count(si, blks)		do { } while (0)
> +#define stat_inc_data_blk_count(sbi, blks, gc_type)	do { } while (0)
> +#define stat_inc_node_blk_count(sbi, blks, gc_type)	do { } while (0)
>  
>  static inline int f2fs_build_stats(struct f2fs_sb_info *sbi) { return 0; }
>  static inline void f2fs_destroy_stats(struct f2fs_sb_info *sbi) { }
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

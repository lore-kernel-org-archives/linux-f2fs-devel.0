From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: avoid GC causing encrypted file corrupted
Date: Tue, 18 Sep 2018 11:17:05 -0700
Message-ID: <20180918181705.GG91945@jaegeuk-macbookpro.roam.corp.google.com>
References: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1537274393-78441-1-git-send-email-yunlong.song@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yunlong Song <yunlong.song@huawei.com>
Cc: chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, miaoxie@huawei.com, bintian.wang@huawei.com, shengyong1@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 09/18, Yunlong Song wrote:
> The encrypted file may be corrupted by GC in following case:
> 
> Time 1: | segment 1 blkaddr = A |  GC -> | segment 2 blkaddr = B |
> Encrypted block 1 is moved from blkaddr A of segment 1 to blkaddr B of
> segment 2,
> 
> Time 2: | segment 1 blkaddr = B |  GC -> | segment 3 blkaddr = C |

            segment 2 blkaddr = B?

> 
> Before page 1 is written back and if segment 2 become a victim, then
> page 1 is moved from blkaddr B of segment 2 to blkaddr Cof segment 3,

                                                         C of ?

> during the GC process of Time 2, f2fs should wait for page 1 written back
> before reading it, or move_data_block will read a garbage block from
> blkaddr B since page is not written back to blkaddr B yet.

move_data_block() checks PageUptodate() so it won't get garbage, yes?
So, does ra_data_block need to check PageUptodate?

> 
> Commit 6aa58d8a ("f2fs: readahead encrypted block during GC") introduce
> ra_data_block to read encrypted block, but it forgets to add
> f2fs_wait_on_page_writeback to avoid racing between GC and flush.
> 
> Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
> ---
>  fs/f2fs/gc.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index a4c1a41..c55fb62 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -641,6 +641,14 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
>  	fio.page = page;
>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>  
> +	/*
> +	 * don't cache encrypted data into meta inode until previous dirty
> +	 * data were writebacked to avoid racing between GC and flush.
> +	 */
> +	f2fs_wait_on_page_writeback(page, DATA, true);
> +
> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +
>  	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(sbi),
>  					dn.data_blkaddr,
>  					FGP_LOCK | FGP_CREAT, GFP_NOFS);
> @@ -723,6 +731,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
>  	 */
>  	f2fs_wait_on_page_writeback(page, DATA, true);
>  
> +	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
> +
>  	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni);
>  	if (err)
>  		goto put_out;
> -- 
> 1.8.5.2

From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 04/28] f2fs: replace a build-time warning with
 runtime WARN_ON
Date: Wed, 26 Oct 2016 22:05:00 +0800
Message-ID: <c23b0800-c9db-d62c-fc05-d6f2208c01ff@kernel.org>
References: <20161017220342.1627073-1-arnd@arndb.de>
 <20161017220557.1688282-4-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161017220557.1688282-4-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Weichao Guo <guoweichao@huawei.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Arnd,

On 2016/10/18 6:05, Arnd Bergmann wrote:
> gcc is unsure about the use of last_ofs_in_node, which might happen
> without a prior initialization:
> 
> fs/f2fs//git/arm-soc/fs/f2fs/data.c: In function ‘f2fs_map_blocks’:
> fs/f2fs/data.c:799:54: warning: ‘last_ofs_in_node’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {

In each round of dnode block traverse, we will init 'prealloc' and then update
'prealloc' and 'last_ofs_in_node' together in below lines of f2fs_map_blocks:
			if (flag == F2FS_GET_BLOCK_PRE_AIO) {
				if (blkaddr == NULL_ADDR) {
					prealloc++;
					last_ofs_in_node = dn.ofs_in_node;
				}
			}

Then in below codes, it is safe to use 'last_ofs_in_node' since we will check
'prealloc' firstly, so if 'prealloc' is non-zero, 'last_ofs_in_node' must be valid.
	if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {

So I think we should not add WARN_ON there.

Thanks,

> 
> I'm not sure about it either, so to shut up the warning I initialize
> it to a known invalid -1u and later check for this, so we get a
> runtime warning if we ever hit the uninitialized case.
> 
> It would be much better to reorganize the code in some form that
> made it obvious to both the compiler and the reader that this
> variable use it ok.
> 
> Since I only see the warning with gcc-4.9 but not any later version,
> it's possible that the compiler is actually smarter than I am here
> and has learned to see the code as correct, in which case this
> patch could just be disregarded. It would certainly be helpful
> to get an opinion from the maintainers on the matter.
> 
> Fixes: 46008c6d4232 ("f2fs: support in batch multi blocks preallocation")
> Cc: Chao Yu <yuchao0@huawei.com>
> Cc: Jaegeuk Kim <jaegeuk@kernel.org>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/f2fs/data.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 9ae194f..1b17de2 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -696,6 +696,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  		goto out;
>  	}
>  
> +	/*
> +	 * FIXME: without this, we get "warning: ‘last_ofs_in_node’ may be
> +	 * used uninitialized". It's not clear whether that can actually
> +	 * happen, so there is now a WARN_ON() checking for this.
> +	 */
> +	last_ofs_in_node = -1u;
>  next_dnode:
>  	if (create)
>  		f2fs_lock_op(sbi);
> @@ -796,6 +802,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  		allocated = dn.node_changed;
>  
>  		map->m_len += dn.ofs_in_node - ofs_in_node;
> +		WARN_ON(last_ofs_in_node == -1u);
>  		if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
>  			err = -ENOSPC;
>  			goto sync_out;
> 

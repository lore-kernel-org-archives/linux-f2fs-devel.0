From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: hide a maybe-uninitialized warning
Date: Wed, 2 Nov 2016 09:34:39 -0700
Message-ID: <20161102163439.GA48728@jaegeuk>
References: <20161102135226.2753644-1-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20161102135226.2753644-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Chao Yu <yuchao0@huawei.com>, Fan Li <fanofcode.li@samsung.com>, Weichao Guo <guoweichao@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Replaced with this.
Thanks, Arnd & Chao, ;)

On Wed, Nov 02, 2016 at 02:52:15PM +0100, Arnd Bergmann wrote:
> gcc is unsure about the use of last_ofs_in_node, which might happen
> without a prior initialization:
> 
> fs/f2fs//git/arm-soc/fs/f2fs/data.c: In function ‘f2fs_map_blocks’:
> fs/f2fs/data.c:799:54: warning: ‘last_ofs_in_node’ may be used uninitialized in this function [-Wmaybe-uninitialized]
>    if (prealloc && dn.ofs_in_node != last_ofs_in_node + 1) {
> 
> As pointed out by Chao Yu, the code is actually correct as 'prealloc'
> is only set if the last_ofs_in_node has been set, the two always
> get updated together.
> 
> This initializes last_ofs_in_node to dn.ofs_in_node for each
> new dnode at the start of the 'next_block' loop, which at that
> point is a correct initialization as well. I assume that compilers
> that correctly track the contents of the variables and do not
> warn about the condition also figure out that they can eliminate
> the extra assignment here.
> 
> Fixes: 46008c6d4232 ("f2fs: support in batch multi blocks preallocation")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/f2fs/data.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index a59ea8e60040..6f01aaddfce9 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -719,7 +719,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	}
>  
>  	prealloc = 0;
> -	ofs_in_node = dn.ofs_in_node;
> +	last_ofs_in_node = ofs_in_node = dn.ofs_in_node;
>  	end_offset = ADDRS_PER_PAGE(dn.node_page, inode);
>  
>  next_block:
> -- 
> 2.9.0

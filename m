From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 1/5] f2fs: do retry operations with cond_resched
Date: Mon, 08 Dec 2014 17:29:53 +0800
Message-ID: <002101d012c9$a1d85460$e588fd20$@samsung.com>
References: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Sunday, December 07, 2014 3:56 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH 1/5] f2fs: do retry operations with cond_resched
> 
> This patch revists retrial paths in f2fs.
> The basic idea is to use cond_resched instead of retrying from the very early
> stage.
> 
> Suggested-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

> ---
>  fs/f2fs/f2fs.h    |  7 +++++++
>  fs/f2fs/gc.c      |  5 ++---
>  fs/f2fs/node.c    | 41 +++++++++--------------------------------
>  fs/f2fs/segment.c |  5 ++---
>  4 files changed, 20 insertions(+), 38 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index c873140..c787fe3 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1021,6 +1021,13 @@ retry:
>  	return entry;
>  }
> 
> +static inline void f2fs_radix_tree_insert(struct radix_tree_root *root,
> +				unsigned long index, void *item)
> +{
> +	while (radix_tree_insert(root, index, item))
> +		cond_resched();
> +}
> +
>  #define RAW_IS_INODE(p)	((p)->footer.nid == (p)->footer.ino)
> 
>  static inline bool IS_INODE(struct page *page)
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 2c58c58..eec0933 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -356,12 +356,11 @@ static void add_gc_inode(struct gc_inode_list *gc_list, struct inode
> *inode)
>  		iput(inode);
>  		return;
>  	}
> -retry:
>  	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
>  	new_ie->inode = inode;
> -
> +retry:
>  	if (radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie)) {
> -		kmem_cache_free(winode_slab, new_ie);
> +		cond_resched();
>  		goto retry;
>  	}

use f2fs_radix_tree_insert instead?

Thanks,
Yu

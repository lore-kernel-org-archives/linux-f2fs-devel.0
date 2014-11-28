From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH] f2fs: more fast lookup for gc_inode list
Date: Thu, 27 Nov 2014 20:24:21 -0800
Message-ID: <20141128042421.GA59574@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <1417079511-29479-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1417079511-29479-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Changman Lee <cm224.lee@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi,

On Thu, Nov 27, 2014 at 06:11:51PM +0900, Changman Lee wrote:
> If there are many inodes that have data blocks in victim segment,
> it takes long time to find a inode in gc_inode list.
> Let's use radix_tree to reduce lookup time.
> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/gc.c | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 29fc7e5..fc765c1 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -24,6 +24,7 @@
>  #include "gc.h"
>  #include <trace/events/f2fs.h>
>  
> +RADIX_TREE(gc_inode_root, GFP_ATOMIC);

How about adding a radix tree locally along with ilist?

>  static struct kmem_cache *winode_slab;
>  
>  static int gc_thread_func(void *data)
> @@ -338,13 +339,13 @@ static const struct victim_selection default_v_ops = {
>  	.get_victim = get_victim_by_default,
>  };
>  
> -static struct inode *find_gc_inode(nid_t ino, struct list_head *ilist)
> +static struct inode *find_gc_inode(nid_t ino)
>  {
>  	struct inode_entry *ie;
>  
> -	list_for_each_entry(ie, ilist, list)
> -		if (ie->inode->i_ino == ino)
> -			return ie->inode;
> +	ie = radix_tree_lookup(&gc_inode_root, ino);
> +	if (ie)
> +		return ie->inode;
>  	return NULL;
>  }
>  
> @@ -352,13 +353,19 @@ static void add_gc_inode(struct inode *inode, struct list_head *ilist)
>  {
>  	struct inode_entry *new_ie;
>  
> -	if (inode == find_gc_inode(inode->i_ino, ilist)) {
> +	new_ie = radix_tree_lookup(&gc_inode_root, inode->i_ino);
> +	if (new_ie) {
>  		iput(inode);
>  		return;
>  	}
>  
>  	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
>  	new_ie->inode = inode;
> +
> +	if (radix_tree_insert(&gc_inode_root, inode->i_ino, new_ie)) {
> +		kmem_cache_free(winode_slab, new_ie);
> +		return;
> +	}

The add_gc_inode should succeed all the tiem.
It seems that we need a sort of loop to avoid that.

>  	list_add_tail(&new_ie->list, ilist);
>  }
>  
> @@ -367,7 +374,7 @@ static void put_gc_inode(struct list_head *ilist)
>  	struct inode_entry *ie, *next_ie;
>  	list_for_each_entry_safe(ie, next_ie, ilist, list) {
>  		iput(ie->inode);
> -		list_del(&ie->list);

Logically, it'd better remain list_del.

> +		radix_tree_delete(&gc_inode_root, ie->inode->i_ino);

We should not use ie->inode, since it was already put.

>  		kmem_cache_free(winode_slab, ie);
>  	}
>  }
> @@ -614,7 +621,7 @@ next_step:
>  		}
>  
>  		/* phase 3 */
> -		inode = find_gc_inode(dni.ino, ilist);
> +		inode = find_gc_inode(dni.ino);

It needs to pass a local radix tree pointer.

>  		if (inode) {
>  			start_bidx = start_bidx_of_node(nofs,
>  							F2FS_I(inode));
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

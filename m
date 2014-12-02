From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH V2] f2fs: more fast lookup for gc_inode list
Date: Tue, 02 Dec 2014 17:25:24 +0800
Message-ID: <005f01d00e12$02e49780$08adc680$@samsung.com>
References: <1417079511-29479-1-git-send-email-cm224.lee@samsung.com>
 <20141128042421.GA59574@jaegeuk-mac02.hsd1.ca.comcast.net>
 <20141128060057.GA2819@lcm> <20141128071250.GC2819@lcm>
 <20141201215248.GA66900@jaegeuk-mac02.mot.com> <20141202003817.GB7824@lcm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <20141202003817.GB7824@lcm>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@samsung.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Changman,

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Tuesday, December 02, 2014 8:38 AM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: Re: [f2fs-dev] [PATCH V2] f2fs: more fast lookup for gc_inode list
> 
> Hi Jaeguek,
> 
> Thansk for review.
> 
> Changes from V2
>  o rename iradix to iroot
>  o declare gc_inode_list in gc.h
> 
> Changes from V1
>  o introduce gc_inode_list containing ilist and iradix
>  o use local variable
>  o call radix_tree_delete before iput
>  o retry to add inode into radix_tree
>  o call list_del explicitly
> 
> Regards,
> Changman
> 
> --> 8 --
> >From 6c32edfc00aa784c47f5018d10fb8f9b5ab54c8b Mon Sep 17 00:00:00 2001
> From: Changman Lee <cm224.lee@samsung.com>
> Date: Fri, 28 Nov 2014 15:49:40 +0000
> Subject: [PATCH] f2fs: more fast lookup for gc_inode list
> 
> If there are many inodes that have data blocks in victim segment,
> it takes long time to find a inode in gc_inode list.
> Let's use radix_tree to reduce lookup time.
> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/gc.c | 51 ++++++++++++++++++++++++++++++---------------------
>  fs/f2fs/gc.h |  5 +++++
>  2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 29fc7e5..92f706c 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -338,34 +338,41 @@ static const struct victim_selection default_v_ops = {
>  	.get_victim = get_victim_by_default,
>  };
> 
> -static struct inode *find_gc_inode(nid_t ino, struct list_head *ilist)
> +static struct inode *find_gc_inode(struct gc_inode_list *gc_list, nid_t ino)
>  {
>  	struct inode_entry *ie;
> 
> -	list_for_each_entry(ie, ilist, list)
> -		if (ie->inode->i_ino == ino)
> -			return ie->inode;
> +	ie = radix_tree_lookup(&gc_list->iroot, ino);
> +	if (ie)
> +		return ie->inode;
>  	return NULL;
>  }
> 
> -static void add_gc_inode(struct inode *inode, struct list_head *ilist)
> +static void add_gc_inode(struct gc_inode_list *gc_list, struct inode *inode)
>  {
>  	struct inode_entry *new_ie;
> +	int ret;
> +retry:
> +	new_ie = f2fs_kmem_cache_alloc(winode_slab, GFP_NOFS);
> +	new_ie->inode = inode;
> 
> -	if (inode == find_gc_inode(inode->i_ino, ilist)) {

How about keeping the original code structure like below?
	if find_gc_inode succ
		iput and return;
	else
		alloc and insert a new item;
So we can avoid invoking many unneeded kmem_cache_{alloc, free} when most data blocks
in victim section are belong to the same inode.

Thanks,
Yu

> +	ret = radix_tree_insert(&gc_list->iroot, inode->i_ino, new_ie);
> +	if (ret == -EEXIST) {
> +		kmem_cache_free(winode_slab, new_ie);
>  		iput(inode);
>  		return;
> +	} else if (ret) {
> +		kmem_cache_free(winode_slab, new_ie);
> +		goto retry;
>  	}
> -

[snip]


From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: extract rb-tree operation
	infrastructure
Date: Tue, 11 Apr 2017 09:22:53 +0800
Message-ID: <5d10df8a-af53-1be4-8ae9-a2a25dd3bf24@huawei.com>
References: <20170407102946.19068-1-yuchao0@huawei.com>
	<20170411000504.GA12273@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cxkWf-0000FW-NN
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 01:23:21 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188]
	helo=dggrg02-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cxkWa-0006aF-Vj
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Apr 2017 01:23:21 +0000
In-Reply-To: <20170411000504.GA12273@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/4/11 8:05, Jaegeuk Kim wrote:
> Hi Chao,
> 
> On 04/07, Chao Yu wrote:
>> rb-tree lookup/update functions are deeply coupled into extent cache
>> codes, it's very hard to reuse these basic functions, this patch
>> extracts common rb-tree operation infrastructure for latter reusing.
>>
>> Signed-off-by: Chao Yu <yuchao0@huawei.com>
>> ---
>>  fs/f2fs/extent_cache.c | 293 ++++++++++++++++++++++++++++---------------------
>>  fs/f2fs/f2fs.h         |  20 +++-
>>  2 files changed, 182 insertions(+), 131 deletions(-)
>>
>> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
>> index c6934f014e0f..1a353f8c01d9 100644
>> --- a/fs/f2fs/extent_cache.c
>> +++ b/fs/f2fs/extent_cache.c
>> @@ -18,6 +18,147 @@
>>  #include "node.h"
>>  #include <trace/events/f2fs.h>
>>  
>> +static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
>> +							unsigned int ofs)
>> +{
>> +	if (cached_re) {
>> +		if (cached_re->ofs <= ofs &&
>> +				cached_re->ofs + cached_re->len > ofs) {
>> +			return cached_re;
>> +		}
>> +	}
>> +
>> +	return NULL;
>> +}
>> +
>> +static struct rb_entry *__lookup_rb_tree_slow(struct rb_root *root,
>> +							unsigned int ofs)
>> +{
>> +	struct rb_node *node = root->rb_node;
>> +	struct rb_entry *re;
>> +
>> +	while (node) {
>> +		re = rb_entry(node, struct rb_entry, rb_node);
>> +
>> +		if (ofs < re->ofs)
>> +			node = node->rb_left;
>> +		else if (ofs >= re->ofs + re->len)
>> +			node = node->rb_right;
>> +		else
>> +			return re;
>> +	}
>> +	return NULL;
>> +}
>> +
>> +static struct rb_entry *__lookup_rb_tree(struct rb_root *root,
>> +				struct rb_entry *cached_re, unsigned int ofs)
>> +{
>> +	struct rb_entry *re;
>> +
>> +	re = __lookup_rb_tree_fast(cached_re, ofs);
>> +	if (!re)
>> +		return __lookup_rb_tree_slow(root, ofs);
>> +
>> +	return re;
>> +}
>> +
>> +static struct rb_node **__lookup_rb_tree_for_insert(struct f2fs_sb_info *sbi,
>> +				struct rb_root *root, struct rb_node **parent,
>> +				unsigned int ofs)
>> +{
>> +	struct rb_node **p = &root->rb_node;
>> +	struct rb_entry *re;
>> +
>> +	while (*p) {
>> +		*parent = *p;
>> +		re = rb_entry(*parent, struct rb_entry, rb_node);
>> +
>> +		if (ofs < re->ofs)
>> +			p = &(*p)->rb_left;
>> +		else if (ofs >= re->ofs + re->len)
>> +			p = &(*p)->rb_right;
>> +		else
>> +			f2fs_bug_on(sbi, 1);
>> +	}
>> +
>> +	return p;
>> +}
>> +
>> +/*
>> + * lookup rb entry in position of @ofs in rb-tree,
>> + * if hit, return the entry, otherwise, return NULL
>> + * @prev_ex: extent before ofs
>> + * @next_ex: extent after ofs
>> + * @insert_p: insert point for new extent at ofs
>> + * in order to simpfy the insertion after.
>> + * tree must stay unchanged between lookup and insertion.
>> + */
>> +static struct rb_entry *__lookup_rb_tree_ret(struct rb_root *root,
>> +				struct rb_entry *cached_re,
>> +				unsigned int ofs,
>> +				struct rb_entry **prev_entry,
>> +				struct rb_entry **next_entry,
>> +				struct rb_node ***insert_p,
>> +				struct rb_node **insert_parent)
>> +{
>> +	struct rb_node **pnode = &root->rb_node;
>> +	struct rb_node *parent = NULL, *tmp_node;
>> +	struct rb_entry *re = cached_re;
>> +
>> +	*insert_p = NULL;
>> +	*insert_parent = NULL;
>> +	*prev_entry = NULL;
>> +	*next_entry = NULL;
>> +
>> +	if (RB_EMPTY_ROOT(root))
>> +		return NULL;
>> +
>> +	if (re) {
>> +		if (re->ofs <= ofs && re->ofs + re->len > ofs)
>> +			goto lookup_neighbors;
>> +	}
>> +
>> +	while (*pnode) {
>> +		parent = *pnode;
>> +		re = rb_entry(*pnode, struct rb_entry, rb_node);
>> +
>> +		if (ofs < re->ofs)
>> +			pnode = &(*pnode)->rb_left;
>> +		else if (ofs >= re->ofs + re->len)
>> +			pnode = &(*pnode)->rb_right;
>> +		else
>> +			goto lookup_neighbors;
>> +	}
>> +
>> +	*insert_p = pnode;
>> +	*insert_parent = parent;
>> +
>> +	re = rb_entry(parent, struct rb_entry, rb_node);
>> +	tmp_node = parent;
>> +	if (parent && ofs > re->ofs)
>> +		tmp_node = rb_next(parent);
>> +	*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
>> +
>> +	tmp_node = parent;
>> +	if (parent && ofs < re->ofs)
>> +		tmp_node = rb_prev(parent);
>> +	*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
>> +	return NULL;
>> +
>> +lookup_neighbors:
>> +	if (ofs == re->ofs) {
>> +		/* lookup prev node for merging backward later */
>> +		tmp_node = rb_prev(&re->rb_node);
>> +		*prev_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
>> +	}
>> +	if (ofs == re->ofs + re->len - 1) {
>> +		/* lookup next node for merging frontward later */
>> +		tmp_node = rb_next(&re->rb_node);
>> +		*next_entry = rb_entry_safe(tmp_node, struct rb_entry, rb_node);
>> +	}
>> +	return re;
>> +}
>> +
>>  static struct kmem_cache *extent_tree_slab;
>>  static struct kmem_cache *extent_node_slab;
>>  
>> @@ -102,36 +243,6 @@ static struct extent_tree *__grab_extent_tree(struct inode *inode)
>>  	return et;
>>  }
>>  
>> -static struct extent_node *__lookup_extent_tree(struct f2fs_sb_info *sbi,
>> -				struct extent_tree *et, unsigned int fofs)
>> -{
>> -	struct rb_node *node = et->root.rb_node;
>> -	struct extent_node *en = et->cached_en;
>> -
>> -	if (en) {
>> -		struct extent_info *cei = &en->ei;
>> -
>> -		if (cei->fofs <= fofs && cei->fofs + cei->len > fofs) {
>> -			stat_inc_cached_node_hit(sbi);
>> -			return en;
>> -		}
>> -	}
>> -
>> -	while (node) {
>> -		en = rb_entry(node, struct extent_node, rb_node);
>> -
>> -		if (fofs < en->ei.fofs) {
>> -			node = node->rb_left;
>> -		} else if (fofs >= en->ei.fofs + en->ei.len) {
>> -			node = node->rb_right;
>> -		} else {
>> -			stat_inc_rbtree_node_hit(sbi);
>> -			return en;
>> -		}
>> -	}
>> -	return NULL;
>> -}
>> -
>>  static struct extent_node *__init_extent_tree(struct f2fs_sb_info *sbi,
>>  				struct extent_tree *et, struct extent_info *ei)
>>  {
>> @@ -237,17 +348,27 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
>>  		goto out;
>>  	}
>>  
>> -	en = __lookup_extent_tree(sbi, et, pgofs);
>> +	en = (struct extent_node *)__lookup_rb_tree_fast(
>> +				(struct rb_entry *)et->cached_en, pgofs);
>>  	if (en) {
>> -		*ei = en->ei;
>> -		spin_lock(&sbi->extent_lock);
>> -		if (!list_empty(&en->list)) {
>> -			list_move_tail(&en->list, &sbi->extent_list);
>> -			et->cached_en = en;
>> -		}
>> -		spin_unlock(&sbi->extent_lock);
>> -		ret = true;
>> +		stat_inc_cached_node_hit(sbi);
>> +	} else {
>> +		en = (struct extent_node *)__lookup_rb_tree_slow(&et->root,
>> +								pgofs);
>> +		if (en)
>> +			stat_inc_rbtree_node_hit(sbi);
>> +		else
>> +			goto out;
>>  	}
> 
> We can use __lookup_rb_tree() like this?

Agreed, let me merge this and resend the patch. :)

Thanks,

> 
> ---
>  fs/f2fs/extent_cache.c | 18 +++++++-----------
>  1 file changed, 7 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 1a353f8c01d9..9b86d549a829 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -27,7 +27,6 @@ static struct rb_entry *__lookup_rb_tree_fast(struct rb_entry *cached_re,
>  			return cached_re;
>  		}
>  	}
> -
>  	return NULL;
>  }
>  
> @@ -348,18 +347,15 @@ static bool f2fs_lookup_extent_tree(struct inode *inode, pgoff_t pgofs,
>  		goto out;
>  	}
>  
> -	en = (struct extent_node *)__lookup_rb_tree_fast(
> +	en = (struct extent_node *)__lookup_rb_tree(&et->root,
>  				(struct rb_entry *)et->cached_en, pgofs);
> -	if (en) {
> +	if (!en)
> +		goto out;
> +
> +	if (en == et->cached_en)
>  		stat_inc_cached_node_hit(sbi);
> -	} else {
> -		en = (struct extent_node *)__lookup_rb_tree_slow(&et->root,
> -								pgofs);
> -		if (en)
> -			stat_inc_rbtree_node_hit(sbi);
> -		else
> -			goto out;
> -	}
> +	else
> +		stat_inc_rbtree_node_hit(sbi);
>  
>  	*ei = en->ei;
>  	spin_lock(&sbi->extent_lock);
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: reduce lock overhead of extent node
	releasing
Date: Sat, 4 Jul 2015 00:03:53 -0700
Message-ID: <20150704070353.GE15817@jaegeuk-mac02.hsd1.ca.comcast.net>
References: <COL402-EAS176E0D9A5A44C7C97F55904AB970@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZBHUY-0000V7-36
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 07:04:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZBHUX-0001UR-0W for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 04 Jul 2015 07:04:02 +0000
Content-Disposition: inline
In-Reply-To: <COL402-EAS176E0D9A5A44C7C97F55904AB970@phx.gbl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchaochina@hotmail.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Thu, Jul 02, 2015 at 08:40:12PM +0800, Chao Yu wrote:
> >From e5c6600d01c4462c4e1ee0c70ec1d9319862077d Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Thu, 2 Jul 2015 18:52:46 +0800
> Subject: [PATCH] f2fs: reduce lock overhead of extent node releasing
> 
> Open and close critical section for each extent node when traversing rb-tree
> results in high overhead of cpu, slows thing down.
> 
> This patch alternates to batch mode for removing extent nodes under spin lock.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 28 ++++++++++++++++++++--------
>  1 file changed, 20 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6a706dd..7fb56a0 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -441,19 +441,31 @@ static unsigned int __free_extent_tree(struct f2fs_sb_info *sbi,
>  	struct extent_node *en;
>  	unsigned int count = et->count;
>  
> -	node = rb_first(&et->root);
> -	while (node) {
> -		next = rb_next(node);
> -		en = rb_entry(node, struct extent_node, rb_node);
> +	if (!et->count)
> +		return 0;
> +
> +	/* 1. remove all extent nodes in global lru list */
> +	if (free_all) {
> +		spin_lock(&sbi->extent_lock);
> +		node = rb_first(&et->root);
> +		while (node) {
> +			next = rb_next(node);
> +			en = rb_entry(node, struct extent_node, rb_node);
>  
> -		if (free_all) {
> -			spin_lock(&sbi->extent_lock);
>  			if (!list_empty(&en->list))
>  				list_del_init(&en->list);
> -			spin_unlock(&sbi->extent_lock);
> +			node = next;
>  		}
> +		spin_unlock(&sbi->extent_lock);
> +	}
> +
> +	/* 2. release all extent nodes which are not in global lru list */

Hmm,
Is there any overhead to traverse the rb_tree twice and any spin_lock delay
caused by contention?

Thanks,

> +	node = rb_first(&et->root);
> +	while (node) {
> +		next = rb_next(node);
> +		en = rb_entry(node, struct extent_node, rb_node);
>  
> -		if (free_all || list_empty(&en->list)) {
> +		if (list_empty(&en->list)) {
>  			__detach_extent_node(sbi, et, en);
>  			kmem_cache_free(extent_node_slab, en);
>  		}
> -- 
> 2.4.2

------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: optimize code
	of	f2fs_update_extent_tree_range
Date: Wed, 09 Sep 2015 17:17:19 +0800
Message-ID: <007901d0eae0$6c5666c0$45033440$@samsung.com>
References: <000001d0eaa7$122161c0$36642540$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1ZZbW6-0007j9-F8
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Sep 2015 09:18:10 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1ZZbW4-0007GO-K1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Sep 2015 09:18:10 +0000
Received: from epcpsbgm1new.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7.0.5.31.0 64bit (built May 5
	2014)) with ESMTP id <0NUE02BUBKHWINA0@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Wed, 09 Sep 2015 18:18:00 +0900 (KST)
In-reply-to: <000001d0eaa7$122161c0$36642540$@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Fan Li' <fanofcode.li@samsung.com>, jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net

> -----Original Message-----
> From: Fan Li [mailto:fanofcode.li@samsung.com]
> Sent: Wednesday, September 09, 2015 10:27 AM
> To: jaegeuk@kernel.org
> Cc: linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: optimize code of f2fs_update_extent_tree_range
> 
> 
> Fix two potential problems:
> 1. when largest extent needs to be invalidated, it will be reset in
>    __drop_largest_extent, which makes __is_extent_same after always
>    return false, and largest extent unchanged. Now we update it properly.
> 
> 2. When extent is split and the latter part remains in tree, next_en
>    should be the latter part instead of next extent of original extent.
>    It will cause merge failure if there is in-place update, although
>    there is not, I think this fix will still makes codes less ambiguous.
> 
> This patch also simpfies codes of invalidating extents, and optimizes the
> procedues that split extent into two.
> 
> 
> Signed-off-by: Fan li <fanofcode.li@samsung.com>
> ---
>  fs/f2fs/extent_cache.c |  150
> +++++++++++++++++++-----------------------------
>  1 file changed, 58 insertions(+), 92 deletions(-)
> 
> diff --git a/fs/f2fs/extent_cache.c b/fs/f2fs/extent_cache.c
> index 997ac86..b95cfb3 100644
> --- a/fs/f2fs/extent_cache.c
> +++ b/fs/f2fs/extent_cache.c
> @@ -399,7 +399,7 @@ unsigned int f2fs_update_extent_tree_range(struct inode
> *inode,
>  {
>  	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>  	struct extent_tree *et = F2FS_I(inode)->extent_tree;
> -	struct extent_node *en = NULL, *en1 = NULL, *en2 = NULL, *en3 =
> NULL;

This patch is out of format, I guess your email client was set with
"auto line wrap" option. Can you fix and resend the patch?

> +	struct extent_node *en = NULL, *en1 = NULL;
>  	struct extent_node *prev_en = NULL, *next_en = NULL;
>  	struct extent_info ei, dei, prev;
>  	struct rb_node **insert_p = NULL, *insert_parent = NULL;
> @@ -419,9 +419,6 @@ unsigned int f2fs_update_extent_tree_range(struct inode
> *inode,
>  	prev = et->largest;
>  	dei.len = 0;
> 
> -	/* we do not guarantee that the largest extent is cached all the
> time */
> -	__drop_largest_extent(inode, fofs);

I think we should keep this, since in shrink flow, we will not update largest
info in inode's extent tree, that means largest extent will be remained if
related extent node has been shrunk. So here if we do not drop largest extent
when fofs located in largest extent, our mapping info in dnode page and largest
extent in cache will be consistent. How do you think?

Thanks,



------------------------------------------------------------------------------
Monitor Your Dynamic Infrastructure at Any Scale With Datadog!
Get real-time metrics from all of your servers, apps and tools
in one place.
SourceForge users - Click here to start your Free Trial of Datadog now!
http://pubads.g.doubleclick.net/gampad/clk?id=241902991&iu=/4140

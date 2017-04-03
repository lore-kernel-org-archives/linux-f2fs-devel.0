From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix a infinite loop in gc_node_segment
Date: Mon, 3 Apr 2017 10:39:00 -0700
Message-ID: <20170403173900.GA1076@jaegeuk.local>
References: <20170331105325.22040-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cv5wf-0007Ih-2Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Apr 2017 17:39:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cv5wd-0006Zh-Ij
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 03 Apr 2017 17:39:13 +0000
Content-Disposition: inline
In-Reply-To: <20170331105325.22040-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

On 03/31, Yunlei He wrote:
> Similar as this problem:
> 	f2fs: relax node version check for victim data in gc
> 
> But this patch fix wrong SSA nid.

What was the problem and how does this fix it?

> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index c52656c..1d0fd04 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -499,6 +499,25 @@ static void gc_node_segment(struct f2fs_sb_info *sbi,
>  		get_node_info(sbi, nid, &ni);
>  		if (ni.blk_addr != start_addr + off) {
>  			f2fs_put_page(node_page, 1);
> +			node_page = pagecache_get_page(META_MAPPING(sbi), start_addr + off,
> +								FGP_LOCK | FGP_CREAT, GFP_NOFS);

Why do you think node_page can be cached in meta_inode?

> +			if (!node_page)
> +				continue;
> +
> +			lock_page(node_page);

Locking the page again? Since FGP_LOCK gave a locked page.

Thanks,

> +			if (unlikely(node_page->mapping != META_MAPPING(sbi))
> +							|| unlikely(!PageUptodate(node_page))) {
> +				f2fs_put_page(node_page, 1);
> +				continue;
> +			}
> +
> +			get_node_info(sbi, nid_of_node(node_page), &ni);
> +			if (ni.blk_addr == start_addr + off) {
> +				entry->nid = cpu_to_le32(ni.nid);
> +			else
> +				f2fs_bug_on(sbi, 1);
> +
> +			f2fs_put_page(node_page, 1);
>  			continue;
>  		}
>  
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

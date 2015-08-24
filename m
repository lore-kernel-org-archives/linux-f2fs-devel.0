From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] fs/f2fs: replace open coded nofail
 allocation in __add_ino_entry
Date: Sun, 23 Aug 2015 21:56:25 -0700
Message-ID: <20150824045625.GB2837@jaegeuk-mac02.mot-mobility.com>
References: <1440386638-40325-1-git-send-email-zhenzhang.zhang@huawei.com>
	<55DA920B.9040706@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ZTjo9-0001b7-LI
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 04:56:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZTjo8-0006kA-Lu for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 24 Aug 2015 04:56:33 +0000
Content-Disposition: inline
In-Reply-To: <55DA920B.9040706@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Zhang Zhen <zhenzhang.zhang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Zhang,

On Mon, Aug 24, 2015 at 11:39:55AM +0800, Zhang Zhen wrote:
> __add_ino_entry is looping around the allocation request and minics
> __GFP_NOFAIL behavior without any allocation fallback strategy.
> Here remove the open coded loop and replace it with __GFP_NOFAIL.
> 
> Signed-off-by: Zhang Zhen <zhenzhang.zhang@huawei.com>
> ---
>  fs/f2fs/checkpoint.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index b70bbe1..d62363b 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -337,12 +337,7 @@ retry:
> 
>  	e = radix_tree_lookup(&im->ino_root, ino);
>  	if (!e) {
> -		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC);
> -		if (!e) {
> -			spin_unlock(&im->ino_lock);
> -			radix_tree_preload_end();
> -			goto retry;
> -		}
> +		e = kmem_cache_alloc(ino_entry_slab, GFP_ATOMIC|__GFP_NOFAIL);

I submitted a patch to replace GFP_ATOMIC with GFP_NOFS.
We can avoid to use GFP_ATOMIC here, right?

Thanks,

>  		if (radix_tree_insert(&im->ino_root, ino, e)) {
>  			spin_unlock(&im->ino_lock);
>  			kmem_cache_free(ino_entry_slab, e);
> -- 
> 1.9.1
> 
> 
> .
> 
> 
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------

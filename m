From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 5/7] f2fs: exclude free nids building and
	allocation
Date: Tue, 11 Oct 2016 10:25:40 -0700
Message-ID: <20161011172540.GD82199@jaegeuk>
References: <20161011143136.2107-1-chao@kernel.org>
	<20161011143136.2107-5-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1bu0oL-0001ZB-BD
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:25:53 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bu0oK-0007Ro-IE
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 11 Oct 2016 17:25:53 +0000
Content-Disposition: inline
In-Reply-To: <20161011143136.2107-5-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Applied.

Thanks,

On Tue, Oct 11, 2016 at 10:31:34PM +0800, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> During nid allocation, it needs to exclude building and allocating flow
> of free nids, this is because while building free nid cache, there are two
> steps: a) load free nids from unused nat entries in NAT pages, b) update
> free nid cache by checking nat journal. The two steps should be atomical,
> otherwise an used nid can be allocated as free one after a) and before b).
> 
> This patch adds missing lock which covers build_free_nids in
> unlock_operation and f2fs_balance_fs_bg to avoid that.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/node.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 92c9aa4..c68e92d 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1824,7 +1824,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
>  	}
>  }
>  
> -void build_free_nids(struct f2fs_sb_info *sbi)
> +void __build_free_nids(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_nm_info *nm_i = NM_I(sbi);
>  	struct curseg_info *curseg = CURSEG_I(sbi, CURSEG_HOT_DATA);
> @@ -1878,6 +1878,13 @@ void build_free_nids(struct f2fs_sb_info *sbi)
>  					nm_i->ra_nid_pages, META_NAT, false);
>  }
>  
> +void build_free_nids(struct f2fs_sb_info *sbi)
> +{
> +	mutex_lock(&NM_I(sbi)->build_lock);
> +	__build_free_nids(sbi);
> +	mutex_unlock(&NM_I(sbi)->build_lock);
> +}
> +
>  /*
>   * If this function returns success, caller can obtain a new nid
>   * from second parameter of this function.
> @@ -1913,9 +1920,7 @@ retry:
>  	spin_unlock(&nm_i->free_nid_list_lock);
>  
>  	/* Let's scan nat pages and its caches to get free nids */
> -	mutex_lock(&nm_i->build_lock);
>  	build_free_nids(sbi);
> -	mutex_unlock(&nm_i->build_lock);
>  	goto retry;
>  }
>  
> -- 
> 2.10.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

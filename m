From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: fix wrong memory footprint statistics
 in debugfs
Date: Tue, 6 Jan 2015 11:48:34 -0800
Message-ID: <20150106194834.GC54001@jaegeuk-mac02>
References: <009c01d0298c$946435e0$bd2ca1a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1Y8a7R-0001X1-Ki
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:48:45 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Y8a7Q-0001pk-FD for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 06 Jan 2015 19:48:45 +0000
Content-Disposition: inline
In-Reply-To: <009c01d0298c$946435e0$bd2ca1a0$@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Jan 06, 2015 at 04:40:49PM +0800, Chao Yu wrote:
> Our value of memory footprint statistics showed in debugfs is not calculated
> correctly. Fix it in this patch.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/debug.c | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/f2fs/debug.c b/fs/f2fs/debug.c
> index dd7835b..6aeaf46 100644
> --- a/fs/f2fs/debug.c
> +++ b/fs/f2fs/debug.c
> @@ -125,7 +125,7 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	int i;
>  
>  	if (si->base_mem)
> -		goto get_cache;
> +		goto get_dynamic_cache;
>  
>  	si->base_mem = sizeof(struct f2fs_sb_info) + sbi->sb->s_blocksize;
>  	si->base_mem += 2 * sizeof(struct f2fs_inode_info);
> @@ -161,13 +161,18 @@ static void update_mem_info(struct f2fs_sb_info *sbi)
>  	si->base_mem += sizeof(struct f2fs_nm_info);
>  	si->base_mem += __bitmap_size(sbi, NAT_BITMAP);
>  
> +get_dynamic_cache:
>  	/* build gc */
> -	si->base_mem += sizeof(struct f2fs_gc_kthread);
> +	if (sbi->gc_thread)
> +		si->base_mem += sizeof(struct f2fs_gc_kthread);
> +
> +	/* build merge flush thread */
> +	if (SM_I(sbi)->cmd_control_info)
> +		si->base_mem += sizeof(struct flush_cmd_control);

It seems base_mem increases repeatedly?

>  
> -get_cache:
>  	/* free nids */
> -	si->cache_mem = NM_I(sbi)->fcnt;
> -	si->cache_mem += NM_I(sbi)->nat_cnt;
> +	si->cache_mem = NM_I(sbi)->fcnt * sizeof(struct free_nid);
> +	si->cache_mem += NM_I(sbi)->nat_cnt * sizeof(struct nat_entry);

Oh, nice catch.

>  	npages = NODE_MAPPING(sbi)->nrpages;
>  	si->cache_mem += npages << PAGE_CACHE_SHIFT;
>  	npages = META_MAPPING(sbi)->nrpages;
> -- 
> 2.2.1

------------------------------------------------------------------------------
Dive into the World of Parallel Programming! The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net

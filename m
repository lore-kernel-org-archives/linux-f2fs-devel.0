From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/3] f2fs: skip dirty bitmap scanning when no
 dirty segments
Date: Thu, 23 Feb 2017 11:03:03 -0800
Message-ID: <20170223190303.GC2026@jaegeuk.local>
References: <20170223091807.36175-1-houpengyang@huawei.com>
	<20170223091807.36175-3-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1cgyfZ-0001Q0-BP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 19:03:13 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1cgyfY-0000MC-14
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 23 Feb 2017 19:03:13 +0000
Content-Disposition: inline
In-Reply-To: <20170223091807.36175-3-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Pengyang,

On 02/23, Hou Pengyang wrote:
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> ---
>  fs/f2fs/gc.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 6c996e3..eaf9e68 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -293,13 +293,22 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  	unsigned int secno, last_victim;
>  	unsigned int last_segment = MAIN_SEGS(sbi);
>  	unsigned int nsearched = 0;
> +	int nr_dirty;
>  
>  	mutex_lock(&dirty_i->seglist_lock);
>  
>  	p.alloc_mode = alloc_mode;
> -	select_policy(sbi, gc_type, type, &p);
> -
>  	p.min_segno = NULL_SEGNO;
> +
> +	if (alloc_mode == SSR)
> +		nr_dirty = dirty_i->nr_dirty[type];
> +	else
> +		nr_dirty = dirty_i->nr_dirty[DIRTY];
> +
> +	if (!nr_dirty)
> +		goto out;
> +
> +	select_policy(sbi, gc_type, type, &p);
>  	p.min_cost = get_max_cost(sbi, &p);
>  
>  	if (p.max_search == 0)

Here, max_search will return if there is no candidate.

Thanks,

> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, SlashDot.org! http://sdm.link/slashdot

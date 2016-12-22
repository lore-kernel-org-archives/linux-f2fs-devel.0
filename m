From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v4] f2fs: fix a missing discard prefree
	segments
Date: Thu, 22 Dec 2016 16:36:24 +0800
Message-ID: <a228570b-8f06-2702-99b1-16e09ec0afb9@huawei.com>
References: <20161222034624.31418-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cJysu-00069A-8h
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Dec 2016 08:37:56 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cJysq-0003Mx-6X
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Dec 2016 08:37:56 +0000
In-Reply-To: <20161222034624.31418-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org
Cc: heyunlei@huwei.com

On 2016/12/22 11:46, Yunlei He wrote:
> If userspace issue a fstrim with a range not involve prefree segments,
> it will reuse these segments without discard. This patch fix it.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 0738f48..30cd445 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -916,9 +916,13 @@ void clear_prefree_segments(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  
>  		dirty_i->nr_dirty[PRE] -= end - start;
>  
> -		if (force || !test_opt(sbi, DISCARD))
> +		if (!test_opt(sbi, DISCARD))
>  			continue;
>  
> +		if (force && start >= cpc->trim_start &&
> +					(end -1) <= cpc->trim_end)

Coding style:  (end - 1)

> +				continue;
> +
>  		if (!test_opt(sbi, LFS) || sbi->segs_per_sec == 1) {
>  			f2fs_issue_discard(sbi, START_BLOCK(sbi, start),
>  				(end - start) << sbi->log_blocks_per_seg);
> @@ -2263,8 +2267,11 @@ void flush_sit_entries(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  	f2fs_bug_on(sbi, sit_i->dirty_sentries);
>  out:
>  	if (cpc->reason == CP_DISCARD) {
> +		__u64 trim_start = cpc->trim_start;
>  		for (; cpc->trim_start <= cpc->trim_end; cpc->trim_start++)
>  			add_discard_addrs(sbi, cpc);
> +
> +		cpc->trim_start = trim_start;
>  	}
>  	mutex_unlock(&sit_i->sentry_lock);
>  
> 


------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today.http://sdm.link/intel

From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: continue to do fg_gc even if beyond
 max_victim_search
Date: Thu, 22 Sep 2016 18:55:43 +0800
Message-ID: <2915cf37-0a28-984f-a9ee-b9ddb1146235@huawei.com>
References: <1474516111-942-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bn1fi-000536-1M
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:56:06 +0000
Received: from szxga03-in.huawei.com ([119.145.14.66])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bn1fe-0005hk-0D
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 22 Sep 2016 10:56:06 +0000
In-Reply-To: <1474516111-942-1-git-send-email-heyunlei@huawei.com>
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

On 2016/9/22 11:48, Yunlei He wrote:
> For forground gc, if can't find a victim in one max_victim_search,
> try it again.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 23 ++++++++++++-----------
>  1 file changed, 12 insertions(+), 11 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 24acbbb..19e51a5 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -916,24 +916,25 @@ gc_more:
>  		goto stop;
>  	}
>  
> -	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, sec_freed, 0)) {
> -		gc_type = FG_GC;
> +	if (gc_type == BG_GC && has_not_enough_free_secs(sbi, 0, 0)) {
>  		/*
>  		 * If there is no victim and no prefree segment but still not
>  		 * enough free sections, we should flush dent/node blocks and do
>  		 * garbage collections.
>  		 */
> -		if (__get_victim(sbi, &segno, gc_type) ||
> -						prefree_segments(sbi)) {
> -			write_checkpoint(sbi, &cpc);
> -			segno = NULL_SEGNO;
> -		} else if (has_not_enough_free_secs(sbi, 0, 0)) {
> -			write_checkpoint(sbi, &cpc);
> -		}
> +		gc_type = FG_GC;
> +		write_checkpoint(sbi, &cpc);
>  	}
>  
> -	if (segno == NULL_SEGNO && !__get_victim(sbi, &segno, gc_type))
> -		goto stop;
> +	if (!__get_victim(sbi, &segno, gc_type)) {
> +		if (sync)
> +			goto stop;
> +		else if (gc_type == FG_GC
> +				&& has_not_enough_free_secs(sbi, sec_freed, 0))
> +			goto gc_more;

Will we deadloop here?

Thanks,

> +		else
> +			goto stop;
> +	}
>  	ret = 0;
>  
>  	if (do_garbage_collect(sbi, segno, &gc_list, gc_type) &&
> 


------------------------------------------------------------------------------

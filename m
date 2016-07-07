From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH] f2fs: avoid mismatching block range for
 discard
Date: Thu, 7 Jul 2016 12:38:30 +0800
Message-ID: <38242f7e-9e09-1176-8d37-8c65d28b7ff9@kernel.org>
References: <1467864813-3556-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bL15H-0003tv-KP
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:38:43 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bL15G-0005QK-Je
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 07 Jul 2016 04:38:43 +0000
In-Reply-To: <1467864813-3556-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, yuchao@huawei.com
Cc: heyunlei@huwei.com

On 2016/7/7 12:13, Yunlei He wrote:
> This patch skip discard block range smaller than trim_minlen,
> and can not be merged by neighbour
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Looks good to me, it reduces memory footprint during fstrim.

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/segment.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 6d16ecf..9e13db0 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -672,6 +672,10 @@ static void add_discard_addrs(struct f2fs_sb_info *sbi, struct cp_control *cpc)
>  			break;
>  
>  		end = __find_rev_next_zero_bit(dmap, max_blocks, start + 1);
> +		if (force && start && end != max_blocks
> +					&& (end - start) < cpc->trim_minlen)
> +			continue;
> +
>  		__add_discard_entry(sbi, cpc, se, start, end);
>  	}
>  }
> 

------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape

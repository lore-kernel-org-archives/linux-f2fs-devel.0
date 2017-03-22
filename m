From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: fix a last_victim overflow problem
Date: Wed, 22 Mar 2017 14:41:00 +0800
Message-ID: <0075730f-795b-bc14-e839-d5a7b9eeb775@huawei.com>
References: <20170322025400.14274-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cqZxW-0002My-OJ
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:41:26 +0000
Received: from [45.249.212.187] (helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cqZxV-0003dW-M1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 22 Mar 2017 06:41:26 +0000
In-Reply-To: <20170322025400.14274-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Yunlei,

Have sent a patch for fixing this issue.

[PATCH 2/2] f2fs: fix recording invalid last_victim

Thanks,

On 2017/3/22 10:54, Yunlei He wrote:
> This patch fix a last_victim overflow problem
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 418fd98..3b5e799a 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -361,6 +361,8 @@ static int get_victim_by_default(struct f2fs_sb_info *sbi,
>  				sbi->last_victim[p.gc_mode] = last_victim + 1;
>  			else
>  				sbi->last_victim[p.gc_mode] = segno + 1;
> +
> +			sbi->last_victim[p.gc_mode] %= MAIN_SEGS(sbi);
>  			break;
>  		}
>  	}
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

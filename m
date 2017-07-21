From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: let background GC being aware of
 freezing
Date: Fri, 21 Jul 2017 13:54:18 -0700
Message-ID: <20170721205418.GA14361@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170721033635.6277-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <jaegeuk@kernel.org>) id 1dYewM-0001tM-DA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jul 2017 20:54:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1dYewL-0000tx-Bt
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 21 Jul 2017 20:54:26 +0000
Content-Disposition: inline
In-Reply-To: <20170721033635.6277-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On 07/21, Chao Yu wrote:
> When ->freeze_fs is called from lvm for doing snapshot, it needs to
> make sure there will be no more changes in filesystem's data, however,
> previously, background GC wasn't aware of freezing, so in environment
> with active background GC thread, data of snapshot becomes unstable.

What about flush/discard threads?

Thanks,

> 
> This patch fixes this issue by adding sb_{start,end}_intwrite in GC
> flow.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/gc.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 76ad2c3d88db..1c0117f60083 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -55,6 +55,8 @@ static int gc_thread_func(void *data)
>  		}
>  #endif
>  
> +		sb_start_intwrite(sbi->sb);
> +
>  		/*
>  		 * [GC triggering condition]
>  		 * 0. GC is not conducted currently.
> @@ -69,12 +71,12 @@ static int gc_thread_func(void *data)
>  		 * So, I'd like to wait some time to collect dirty segments.
>  		 */
>  		if (!mutex_trylock(&sbi->gc_mutex))
> -			continue;
> +			goto next;
>  
>  		if (!is_idle(sbi)) {
>  			increase_sleep_time(gc_th, &wait_ms);
>  			mutex_unlock(&sbi->gc_mutex);
> -			continue;
> +			goto next;
>  		}
>  
>  		if (has_enough_invalid_blocks(sbi))
> @@ -93,6 +95,8 @@ static int gc_thread_func(void *data)
>  
>  		/* balancing f2fs's metadata periodically */
>  		f2fs_balance_fs_bg(sbi);
> +next:
> +		sb_end_intwrite(sbi->sb);
>  
>  	} while (!kthread_should_stop());
>  	return 0;
> -- 
> 2.13.1.388.g69e6b9b4f4a9

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

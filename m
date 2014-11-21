From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: fix wrong data structure when create slab
Date: Fri, 21 Nov 2014 15:10:39 +0800
Message-ID: <004301d0055a$6b5f2f20$421d8d60$@samsung.com>
References: <1416552127-15899-1-git-send-email-cm224.lee@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1416552127-15899-1-git-send-email-cm224.lee@samsung.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Changman Lee' <cm224.lee@samsung.com>, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi, Changman

> -----Original Message-----
> From: Changman Lee [mailto:cm224.lee@samsung.com]
> Sent: Friday, November 21, 2014 2:42 PM
> To: linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: fix wrong data structure when create slab
> 
> It used nat_entry_set when create slab for sit_entry_set.

Oh, sorry, that's my mistake, thank you for fixing this!

Reviewed-by: Chao Yu <chao2.yu@samsung.com>

Regards,
Yu

> 
> Signed-off-by: Changman Lee <cm224.lee@samsung.com>
> ---
>  fs/f2fs/segment.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index e094675..9de857f 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2231,7 +2231,7 @@ int __init create_segment_manager_caches(void)
>  		goto fail;
> 
>  	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
> -			sizeof(struct nat_entry_set));
> +			sizeof(struct sit_entry_set));
>  	if (!sit_entry_set_slab)
>  		goto destory_discard_entry;
> 
> --
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
> from Actuate! Instantly Supercharge Your Business Reports and Dashboards
> with Interactivity, Sharing, Native Excel Exports, App Integration & more
> Get technology previously reserved for billion-dollar corporations, FREE
> http://pubads.g.doubleclick.net/gampad/clk?id=157005751&iu=/4140/ostg.clktrk
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


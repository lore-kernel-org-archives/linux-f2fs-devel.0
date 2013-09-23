From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH] f2fs: avoid allocating failure in bio_alloc
Date: Mon, 23 Sep 2013 09:50:47 +0800
Message-ID: <523F9E77.4010304@cn.fujitsu.com>
References: <000001ceb768$9478ce70$bd6a6b50$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VNvNV-0004jm-KD
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Sep 2013 01:55:57 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VNvNT-0002Vv-UL for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 23 Sep 2013 01:55:57 +0000
In-Reply-To: <000001ceb768$9478ce70$bd6a6b50$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, =?GB2312?B?zLfmrQ==?= <shu.tan@samsung.com>, linux-f2fs-devel@lists.sourceforge.net

On 09/22/2013 03:50 PM, Chao Yu wrote:

> This patch add macro MAX_BIO_BLOCKS to limit value of npages in
> f2fs_bio_alloc, it can avoid allocating failure in bio_alloc caused by
> npages is larger than BIO_MAX_PAGES.
> 
> Signed-off-by: Yu Chao <chao2.yu@samsung.com>


Reviewed-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

> ---
>  fs/f2fs/segment.c |    4 +++-
>  fs/f2fs/segment.h |    2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 09af9c7..bd79bbe 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -657,6 +657,7 @@ static void submit_write_page(struct f2fs_sb_info *sbi,
> struct page *page,
>  				block_t blk_addr, enum page_type type)
>  {
>  	struct block_device *bdev = sbi->sb->s_bdev;
> +	int bio_blocks;
>  
>  	verify_block_addr(sbi, blk_addr);
>  
> @@ -676,7 +677,8 @@ retry:
>  			goto retry;
>  		}
>  
> -		sbi->bio[type] = f2fs_bio_alloc(bdev, max_hw_blocks(sbi));
> +		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +		sbi->bio[type] = f2fs_bio_alloc(bdev, bio_blocks);
>  		sbi->bio[type]->bi_sector = SECTOR_FROM_BLOCK(sbi,
> blk_addr);
>  		sbi->bio[type]->bi_private = priv;
>  		/*
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index bdd10ea..7f94d78 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -90,6 +90,8 @@
>  	(blk_addr << ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
>  #define SECTOR_TO_BLOCK(sbi, sectors)					\
>  	(sectors >> ((sbi)->log_blocksize - F2FS_LOG_SECTOR_SIZE))
> +#define MAX_BIO_BLOCKS(max_hw_blocks)					\
> +	(min((int)max_hw_blocks, BIO_MAX_PAGES))
>  
>  /* during checkpoint, bio_private is used to synchronize the last bio */
>  struct bio_private {
> ---
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



------------------------------------------------------------------------------
LIMITED TIME SALE - Full Year of Microsoft Training For Just $49.99!
1,500+ hours of tutorials including VisualStudio 2012, Windows 8, SharePoint
2013, SQL 2012, MVC 4, more. BEST VALUE: New Multi-Library Power Pack includes
Mobile, Cloud, Java, and UX Design. Lowest price ever! Ends 9/20/13. 
http://pubads.g.doubleclick.net/gampad/clk?id=58041151&iu=/4140/ostg.clktrk

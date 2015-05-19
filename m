From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: avoid duplicated code by reusing
 f2fs_read_end_io
Date: Tue, 19 May 2015 10:48:51 -0700
Message-ID: <20150519174851.GC42970@jaegeuk-mac02.mot.com>
References: <005d01d09217$c0df57f0$429e07d0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YuldW-0004Ig-Km
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 17:49:02 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YuldU-0007az-Od for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 19 May 2015 17:49:02 +0000
Content-Disposition: inline
In-Reply-To: <005d01d09217$c0df57f0$429e07d0$@samsung.com>
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

On Tue, May 19, 2015 at 05:38:56PM +0800, Chao Yu wrote:
> This patch tries to clean up code as part code of f2fs_read_end_io
> and mpage_end_io are the same, so it's better to merge and reuse them.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 35 +++++------------------------------
>  1 file changed, 5 insertions(+), 30 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8d04e24..5173d0f 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -34,40 +34,16 @@ static void f2fs_read_end_io(struct bio *bio, int err)
>  	struct bio_vec *bvec;
>  	int i;
>  
> -	bio_for_each_segment_all(bvec, bio, i) {
> -		struct page *page = bvec->bv_page;
> -
> -		if (!err) {
> -			SetPageUptodate(page);
> -		} else {
> -			ClearPageUptodate(page);
> -			SetPageError(page);
> -		}
> -		unlock_page(page);
> -	}
> -	bio_put(bio);
> -}
> -
> -/*
> - * I/O completion handler for multipage BIOs.
> - * copied from fs/mpage.c
> - */
> -static void mpage_end_io(struct bio *bio, int err)
> -{
> -	struct bio_vec *bv;
> -	int i;
> -
>  	if (f2fs_bio_encrypted(bio)) {
>  		if (err) {
>  			f2fs_release_crypto_ctx(bio->bi_private);
>  		} else {
> -			f2fs_end_io_crypto_work(bio->bi_private, bio);
> -			return;
> +			return f2fs_end_io_crypto_work(bio->bi_private, bio);

IMO, it'd better remain the previous one to make clear that
f2fs_en_io_crypto_work defines a void return.
How about that?

Thanks,

>  		}
>  	}
>  
> -	bio_for_each_segment_all(bv, bio, i) {
> -		struct page *page = bv->bv_page;
> +	bio_for_each_segment_all(bvec, bio, i) {
> +		struct page *page = bvec->bv_page;
>  
>  		if (!err) {
>  			SetPageUptodate(page);
> @@ -77,7 +53,6 @@ static void mpage_end_io(struct bio *bio, int err)
>  		}
>  		unlock_page(page);
>  	}
> -
>  	bio_put(bio);
>  }
>  
> @@ -122,7 +97,7 @@ static struct bio *__bio_alloc(struct f2fs_sb_info *sbi, block_t blk_addr,
>  	bio->bi_bdev = sbi->sb->s_bdev;
>  	bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(blk_addr);
>  	bio->bi_end_io = is_read ? f2fs_read_end_io : f2fs_write_end_io;
> -	bio->bi_private = sbi;
> +	bio->bi_private = is_read ? NULL : sbi;
>  
>  	return bio;
>  }
> @@ -1584,7 +1559,7 @@ submit_and_realloc:
>  			}
>  			bio->bi_bdev = bdev;
>  			bio->bi_iter.bi_sector = SECTOR_FROM_BLOCK(block_nr);
> -			bio->bi_end_io = mpage_end_io;
> +			bio->bi_end_io = f2fs_read_end_io;
>  			bio->bi_private = ctx;
>  		}
>  
> -- 
> 2.3.3

------------------------------------------------------------------------------
One dashboard for servers and applications across Physical-Virtual-Cloud 
Widest out-of-the-box monitoring support with 50+ applications
Performance metrics, stats and reports that give you Actionable Insights
Deep dive visibility with transaction tracing using APM Insight.
http://ad.doubleclick.net/ddm/clk/290420510;117567292;y

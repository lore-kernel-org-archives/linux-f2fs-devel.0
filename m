From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH] f2fs: use BIO_MAX_PAGES for bio allocation
Date: Thu, 27 Oct 2016 18:28:04 +0800
Message-ID: <51e0b1df-e19e-bd42-4120-638bcbde6c19@huawei.com>
References: <20161018184836.12886-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1bzhvq-00009T-23
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Oct 2016 10:29:10 +0000
Received: from szxga02-in.huawei.com ([119.145.14.65])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1bzhvm-0005yD-52
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Oct 2016 10:29:10 +0000
In-Reply-To: <20161018184836.12886-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2016/10/19 2:48, Jaegeuk Kim wrote:
> We don't need to allocate bio partially in order to maximize sequential writes.

We are going to allocate bio with max size supposing that there will be more
opportunity to merge small IOs into one bio. Otherwise, if MAX_BIO_BLOCKS is
smaller than BIO_MAX_PAGES, less IOs can be merged. Is my understanding correct?

Thanks,

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c |  2 +-
>  fs/f2fs/data.c       |  4 +---
>  fs/f2fs/node.c       |  3 +--
>  fs/f2fs/segment.c    |  4 ++--
>  fs/f2fs/segment.h    | 17 +++--------------
>  5 files changed, 8 insertions(+), 22 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 654f5d7..157b7fd 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -228,7 +228,7 @@ void ra_meta_pages_cond(struct f2fs_sb_info *sbi, pgoff_t index)
>  	f2fs_put_page(page, 0);
>  
>  	if (readahead)
> -		ra_meta_pages(sbi, index, MAX_BIO_BLOCKS(sbi), META_POR, true);
> +		ra_meta_pages(sbi, index, BIO_MAX_PAGES, META_POR, true);
>  }
>  
>  static int f2fs_write_meta_page(struct page *page,
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 77cd9ac..fe8ce5a 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -307,10 +307,8 @@ void f2fs_submit_page_mbio(struct f2fs_io_info *fio)
>  		__submit_merged_bio(io);
>  alloc_new:
>  	if (io->bio == NULL) {
> -		int bio_blocks = MAX_BIO_BLOCKS(sbi);
> -
>  		io->bio = __bio_alloc(sbi, fio->new_blkaddr,
> -						bio_blocks, is_read);
> +						BIO_MAX_PAGES, is_read);
>  		io->fio = *fio;
>  	}
>  
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 69c42e2..285e2a5 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -2101,7 +2101,6 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
>  	struct f2fs_node *rn;
>  	struct f2fs_summary *sum_entry;
>  	block_t addr;
> -	int bio_blocks = MAX_BIO_BLOCKS(sbi);
>  	int i, idx, last_offset, nrpages;
>  
>  	/* scan the node segment */
> @@ -2110,7 +2109,7 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
>  	sum_entry = &sum->entries[0];
>  
>  	for (i = 0; i < last_offset; i += nrpages, addr += nrpages) {
> -		nrpages = min(last_offset - i, bio_blocks);
> +		nrpages = min(last_offset - i, BIO_MAX_PAGES);
>  
>  		/* readahead node pages */
>  		ra_meta_pages(sbi, addr, nrpages, META_POR, true);
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 7a7e3f1..a21a1a3 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -2355,10 +2355,10 @@ static void build_sit_entries(struct f2fs_sb_info *sbi)
>  	int sit_blk_cnt = SIT_BLK_CNT(sbi);
>  	unsigned int i, start, end;
>  	unsigned int readed, start_blk = 0;
> -	int nrpages = MAX_BIO_BLOCKS(sbi) * 8;
>  
>  	do {
> -		readed = ra_meta_pages(sbi, start_blk, nrpages, META_SIT, true);
> +		readed = ra_meta_pages(sbi, start_blk, BIO_MAX_PAGES,
> +							META_SIT, true);
>  
>  		start = start_blk * sit_i->sents_per_block;
>  		end = (start_blk + readed) * sit_i->sents_per_block;
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index a6efb5c..d8ff069 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -102,8 +102,6 @@
>  	(((sector_t)blk_addr) << F2FS_LOG_SECTORS_PER_BLOCK)
>  #define SECTOR_TO_BLOCK(sectors)					\
>  	(sectors >> F2FS_LOG_SECTORS_PER_BLOCK)
> -#define MAX_BIO_BLOCKS(sbi)						\
> -	((int)min((int)max_hw_blocks(sbi), BIO_MAX_PAGES))
>  
>  /*
>   * indicate a block allocation direction: RIGHT and LEFT.
> @@ -698,13 +696,6 @@ static inline bool sec_usage_check(struct f2fs_sb_info *sbi, unsigned int secno)
>  	return false;
>  }
>  
> -static inline unsigned int max_hw_blocks(struct f2fs_sb_info *sbi)
> -{
> -	struct block_device *bdev = sbi->sb->s_bdev;
> -	struct request_queue *q = bdev_get_queue(bdev);
> -	return SECTOR_TO_BLOCK(queue_max_sectors(q));
> -}
> -
>  /*
>   * It is very important to gather dirty pages and write at once, so that we can
>   * submit a big bio without interfering other data writes.
> @@ -722,7 +713,7 @@ static inline int nr_pages_to_skip(struct f2fs_sb_info *sbi, int type)
>  	else if (type == NODE)
>  		return 8 * sbi->blocks_per_seg;
>  	else if (type == META)
> -		return 8 * MAX_BIO_BLOCKS(sbi);
> +		return 8 * BIO_MAX_PAGES;
>  	else
>  		return 0;
>  }
> @@ -739,11 +730,9 @@ static inline long nr_pages_to_write(struct f2fs_sb_info *sbi, int type,
>  		return 0;
>  
>  	nr_to_write = wbc->nr_to_write;
> -
> +	desired = BIO_MAX_PAGES;
>  	if (type == NODE)
> -		desired = 2 * max_hw_blocks(sbi);
> -	else
> -		desired = MAX_BIO_BLOCKS(sbi);
> +		desired <<= 1;
>  
>  	wbc->nr_to_write = desired;
>  	return desired - nr_to_write;
> 


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik

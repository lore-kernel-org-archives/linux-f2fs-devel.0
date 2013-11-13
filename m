From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [PATCH 1/2] f2fs: add a new function to support for
 merging contiguous read
Date: Wed, 13 Nov 2013 11:39:24 +0800
Message-ID: <5282F46C.5040403@cn.fujitsu.com>
References: <000001cedf66$46a9bb70$d3fd3250$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VgROo-0004GC-L1
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Nov 2013 03:45:50 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VgROm-0006iD-RD for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 13 Nov 2013 03:45:50 +0000
In-Reply-To: <000001cedf66$46a9bb70$d3fd3250$@samsung.com>
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 11/12/2013 01:15 PM, Chao Yu wrote:

> For better read performance, we add a new function to support for merging contiguous read as the one for write.

Nice shot!

> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>

Acked-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

> ---
>  fs/f2fs/data.c |   45 +++++++++++++++++++++++++++++++++++++++++++++
>  fs/f2fs/f2fs.h |    2 ++
>  2 files changed, 47 insertions(+)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index aa3438c..f30060b 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -404,6 +404,51 @@ int f2fs_readpage(struct f2fs_sb_info *sbi, struct page *page,
>  	return 0;
>  }
>  
> +void f2fs_submit_read_bio(struct f2fs_sb_info *sbi, int rw)
> +{
> +	down_read(&sbi->bio_sem);
> +	if (sbi->read_bio) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio = NULL;
> +	}
> +	up_read(&sbi->bio_sem);
> +}
> +
> +void submit_read_page(struct f2fs_sb_info *sbi, struct page *page,
> +					block_t blk_addr, int rw)
> +{
> +	struct block_device *bdev = sbi->sb->s_bdev;
> +	int bio_blocks;
> +
> +	verify_block_addr(sbi, blk_addr);
> +
> +	down_read(&sbi->bio_sem);
> +
> +	if (sbi->read_bio && sbi->last_read_block != blk_addr - 1) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio = NULL;
> +	}
> +
> +alloc_new:
> +	if (sbi->read_bio == NULL) {
> +		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +		sbi->read_bio = f2fs_bio_alloc(bdev, bio_blocks);
> +		sbi->read_bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
> +		sbi->read_bio->bi_end_io = read_end_io;
> +	}
> +
> +	if (bio_add_page(sbi->read_bio, page, PAGE_CACHE_SIZE, 0) <
> +							PAGE_CACHE_SIZE) {
> +		submit_bio(rw, sbi->read_bio);
> +		sbi->read_bio = NULL;
> +		goto alloc_new;
> +	}
> +
> +	sbi->last_read_block = blk_addr;
> +
> +	up_read(&sbi->bio_sem);
> +}
> +
>  /*
>   * This function should be used by the data read flow only where it
>   * does not check the "create" flag that indicates block allocation.
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 89dc750..0afdcec 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -359,6 +359,8 @@ struct f2fs_sb_info {
>  
>  	/* for segment-related operations */
>  	struct f2fs_sm_info *sm_info;		/* segment manager */
> +	struct bio *read_bio;			/* read bios to merge */
> +	sector_t last_read_block;		/* last read block number */
>  	struct bio *bio[NR_PAGE_TYPE];		/* bios to merge */
>  	sector_t last_block_in_bio[NR_PAGE_TYPE];	/* last block number */
>  	struct rw_semaphore bio_sem;		/* IO semaphore */



------------------------------------------------------------------------------
DreamFactory - Open Source REST & JSON Services for HTML5 & Native Apps
OAuth, Users, Roles, SQL, NoSQL, BLOB Storage and External API Access
Free app hosting. Or install the open source package on any LAMP server.
Sign up and see examples for AngularJS, jQuery, Sencha Touch and Native!
http://pubads.g.doubleclick.net/gampad/clk?id=63469471&iu=/4140/ostg.clktrk

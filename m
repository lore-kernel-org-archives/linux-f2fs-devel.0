From: Chao Yu <chao2.yu@samsung.com>
Subject: Re: [PATCH] f2fs: refactor bio-related operations
Date: Mon, 02 Dec 2013 12:47:11 +0800
Message-ID: <000101ceef19$ae149b50$0a3dd1f0$@samsung.com>
References: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VnLQi-0006cD-OF
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 04:48:20 +0000
Received: from mailout2.samsung.com ([203.254.224.25])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VnLQg-0000Xd-Ex
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 04:48:20 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout2.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MX5004DIXC52Y50@mailout2.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 02 Dec 2013 13:48:05 +0900 (KST)
In-reply-to: <1385792739-31405-1-git-send-email-jaegeuk.kim@samsung.com>
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: 'Jaegeuk Kim' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi,

Some comments as following.

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk.kim@samsung.com]
> Sent: Saturday, November 30, 2013 2:26 PM
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH] f2fs: refactor bio-related operations
> 

[snip]

> +void f2fs_submit_page_mbio(struct f2fs_sb_info *sbi, struct page *page,
> +			block_t blk_addr, enum page_type type, int rw)
> +{
> +	enum page_type btype = PAGE_TYPE_OF_BIO(type);
> +	struct block_device *bdev = sbi->sb->s_bdev;
> +	struct f2fs_bio_info *io;
> +	int bio_blocks;
> +
> +	io = is_read_io(rw) ? &sbi->read_io : &sbi->write_io[btype];
> +
> +	verify_block_addr(sbi, blk_addr);
> +
> +	mutex_lock(&io->io_mutex);
> +
> +	if (!is_read_io(rw))
> +		inc_page_count(sbi, F2FS_WRITEBACK);
> +
> +	if (io->bio && io->last_block_in_bio != blk_addr - 1)
> +		__submit_merged_bio(sbi, io, type, true, rw);
> +alloc_new:
> +	if (io->bio == NULL) {
> +		bio_blocks = MAX_BIO_BLOCKS(max_hw_blocks(sbi));
> +		io->bio = __bio_alloc(bdev, bio_blocks);
> +		io->bio->bi_sector = SECTOR_FROM_BLOCK(sbi, blk_addr);
> +		io->bio->bi_end_io = is_read_io(rw) ? f2fs_read_end_io :
> +							f2fs_write_end_io;
> +		/*
> +		 * The end_io will be assigned at the sumbission phase.
> +		 * Until then, let bio_add_page() merge consecutive IOs as much
> +		 * as possible.
> +		 */
> +	}
> +
> +	if (bio_add_page(io->bio, page, PAGE_CACHE_SIZE, 0) <
> +							PAGE_CACHE_SIZE) {
> +		__submit_merged_bio(sbi, io, type, true, rw);
> +		io->bio = NULL;

We should remove the redundant code " io->bio = NULL;" here,
because __submit_merged_bio does the same job.

[snip]

>  /*
>   * data.c
>   */
> +void f2fs_submit_merged_bio(struct f2fs_sb_info *, enum page_type, bool, int);
> +int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *, block_t, int);

Redundant to the following code.

> +void f2fs_submit_page_mbio(struct f2fs_sb_info *, struct page *, block_t,
> +							enum page_type, int);
>  int reserve_new_block(struct dnode_of_data *);
>  int f2fs_reserve_block(struct dnode_of_data *, pgoff_t);
>  void update_extent_cache(block_t, struct dnode_of_data *);
>  struct page *find_data_page(struct inode *, pgoff_t, bool);
>  struct page *get_lock_data_page(struct inode *, pgoff_t);
>  struct page *get_new_data_page(struct inode *, struct page *, pgoff_t, bool);
> -int f2fs_readpage(struct f2fs_sb_info *, struct page *, block_t, int);
> -void f2fs_submit_read_bio(struct f2fs_sb_info *, int);
> -void submit_read_page(struct f2fs_sb_info *, struct page *, block_t, int);
> +int f2fs_submit_page_bio(struct f2fs_sb_info *, struct page *, block_t, int);

Here.

[snip]


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349351&iu=/4140/ostg.clktrk

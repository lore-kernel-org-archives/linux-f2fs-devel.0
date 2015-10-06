From: Chao Yu <yuchaochina@hotmail.com>
Subject: RE: [f2fs-dev] [PATCH] f2fs: merge meta writes as many possible
Date: Tue, 6 Oct 2015 22:54:12 +0800
Message-ID: <COL402-EAS4024BEB16A6A59FCB1671A9AB370@phx.gbl>
References: <1443804470-2541-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1443804470-2541-1-git-send-email-jaegeuk@kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> Sent: Saturday, October 03, 2015 12:48 AM
> To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> linux-fsdevel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Cc: Jaegeuk Kim; Jaegeuk Kim
> Subject: [f2fs-dev] [PATCH] f2fs: merge meta writes as many possible
> 
> This patch tries to merge IOs as many as possible when background flusher
> conducts flushing the dirty meta pages.
> 
> [Before]
> 
> ...
> 2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124320, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124560, size = 32768
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 95720, size = 987136
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123928, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123944, size = 8192
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123968, size = 45056
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124064, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 97648, size = 1007616
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123776, size = 8192
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123800, size = 32768
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 124624, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 99616, size = 921600
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123608, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123624, size = 77824
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123792, size = 4096
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 123864, size = 32768
> ...
> 
> [After]
> 
> ...
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 92168, size = 892928
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 93912, size = 753664
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 95384, size = 716800
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 96784, size = 712704
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 104160, size = 364544
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 104872, size = 356352
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 105568, size = 278528
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 106112, size = 319488
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 106736, size = 258048
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 107240, size = 270336
> f2fs_submit_write_bio: dev = (8,18), WRITE_SYNC(MP), META, sector = 107768, size = 180224
> ...
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/checkpoint.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index ff53405..da5ee7e 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -257,7 +257,7 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>  						long nr_to_write)
>  {
>  	struct address_space *mapping = META_MAPPING(sbi);
> -	pgoff_t index = 0, end = LONG_MAX;
> +	pgoff_t index = 0, end = LONG_MAX, prev = LONG_MAX;
>  	struct pagevec pvec;
>  	long nwritten = 0;
>  	struct writeback_control wbc = {
> @@ -277,6 +277,11 @@ long sync_meta_pages(struct f2fs_sb_info *sbi, enum page_type type,
>  		for (i = 0; i < nr_pages; i++) {
>  			struct page *page = pvec.pages[i];
> 
> +			if (prev == LONG_MAX)
> +				prev = page->index - 1;
> +			if (nr_to_write != LONG_MAX && page->index != prev + 1)

Does this mean we only writeback consecutive meta page of SSA region? If these meta
pages are updated randomly (in collapse range or insert range case), we will writeback
very few meta pages in one round of flush, it may cause low performance since FTL will
do the force GC on our meta page update region if we writeback meta pages in one segment
repeatly.

IMO, when the distribution of dirty SSA pages are random, at least we should writeback
all dirty meta pages in SSA region which align to our segment size under block plug.

One more thing is that I found in xfstest tests/generic/019 always cause inconsistent
between ssa info and meta info of inode (i_blocks != total_blk_cnt). The reason of the
problem is in ->falloc::collapse, we will update ssa meta page and node page info
together, however, unfortunately ssa meta page is writeback by kworker, node page will
no longer be persisted since fail_make_request made f2fs flagged as CP_ERROR_FLAG.

So writeback SSA pages leads the potential risk of producing consistent issue. I think
there are some ways can fix this:
1) don't writeback SSA pages in kworker, but side-effect is more memory will be cost
since cp is executed, of course, periodical cp can fix the memory cost issue.
2) add some tag in somewhere, we can recover the ssa info with dnode page, but this is
really a big change.

How do you think? Any better idea?

Thanks,

> +				break;
> +
>  			lock_page(page);
> 
>  			if (unlikely(page->mapping != mapping)) {
> @@ -297,6 +302,7 @@ continue_unlock:
>  				break;
>  			}
>  			nwritten++;
> +			prev = page->index;
>  			if (unlikely(nwritten >= nr_to_write))
>  				break;
>  		}
> --
> 2.1.1
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

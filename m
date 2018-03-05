From: Sahitya Tummala <stummala@codeaurora.org>
Subject: Re: [PATCH v2] f2fs: check blkaddr more accuratly before
 issue a bio
Date: Mon, 5 Mar 2018 15:54:04 +0530
Message-ID: <20180305102404.GD4311@codeaurora.org>
References: <1520233626-2330-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <stummala@codeaurora.org>) id 1esnI2-002HbX-Lo
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Mar 2018 10:24:18 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=smtp.codeaurora.org)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1esnHx-001GWz-De
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 05 Mar 2018 10:24:15 +0000
Content-Disposition: inline
In-Reply-To: <1520233626-2330-1-git-send-email-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Mon, Mar 05, 2018 at 03:07:06PM +0800, Yunlei He wrote:
> This patch check blkaddr more accuratly before issue a
> write or read bio.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/checkpoint.c |  2 ++
>  fs/f2fs/data.c       |  5 +++--
>  fs/f2fs/f2fs.h       |  1 +
>  fs/f2fs/segment.h    | 29 +++++++++++++++++++++++++----
>  4 files changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 5b2db75..bf77946 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -68,6 +68,7 @@ static struct page *__get_meta_page(struct f2fs_sb_info *sbi, pgoff_t index,
>  		.old_blkaddr = index,
>  		.new_blkaddr = index,
>  		.encrypted_page = NULL,
> +		.is_meta = is_meta,
>  	};
>  
>  	if (unlikely(!is_meta))
> @@ -162,6 +163,7 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages,
>  		.op_flags = sync ? (REQ_META | REQ_PRIO) : REQ_RAHEAD,
>  		.encrypted_page = NULL,
>  		.in_list = false,
> +		.is_meta = (type != META_POR),
>  	};
>  	struct blk_plug plug;
>  
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 6c3c978..de036e8 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -383,6 +383,7 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
>  	struct page *page = fio->encrypted_page ?
>  			fio->encrypted_page : fio->page;
>  
> +	verify_block_addr(fio, fio->new_blkaddr);
>  	trace_f2fs_submit_page_bio(page, fio);
>  	f2fs_trace_ios(fio, 0);
>  
> @@ -428,8 +429,8 @@ int f2fs_submit_page_write(struct f2fs_io_info *fio)
>  	}
>  
>  	if (fio->old_blkaddr != NEW_ADDR)
> -		verify_block_addr(sbi, fio->old_blkaddr);
> -	verify_block_addr(sbi, fio->new_blkaddr);
> +		verify_block_addr(fio, fio->old_blkaddr);
> +	verify_block_addr(fio, fio->new_blkaddr);
>  
>  	bio_page = fio->encrypted_page ? fio->encrypted_page : fio->page;
>  
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f6dc706..842adea 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -980,6 +980,7 @@ struct f2fs_io_info {
>  	bool submitted;		/* indicate IO submission */
>  	int need_lock;		/* indicate we need to lock cp_rwsem */
>  	bool in_list;		/* indicate fio is in io_list */
> +	bool is_meta;		/* indicate borrow meta inode mapping or not */
>  	enum iostat_type io_type;	/* io type */
>  	struct writeback_control *io_wbc; /* writeback control */
>  };
> diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
> index dbb774aa..dabe400 100644
> --- a/fs/f2fs/segment.h
> +++ b/fs/f2fs/segment.h
> @@ -632,10 +632,31 @@ static inline void check_seg_range(struct f2fs_sb_info *sbi, unsigned int segno)
>  	f2fs_bug_on(sbi, segno > TOTAL_SEGS(sbi) - 1);
>  }
>  
> -static inline void verify_block_addr(struct f2fs_sb_info *sbi, block_t blk_addr)
> -{
> -	BUG_ON(blk_addr < SEG0_BLKADDR(sbi)
> -			|| blk_addr >= MAX_BLKADDR(sbi));
> +static inline void verify_block_addr(struct f2fs_io_info *fio, block_t blk_addr)
> +{
> +	struct f2fs_sb_info *sbi = fio->sbi;
> +	enum page_type btype = PAGE_TYPE_OF_BIO(fio->type);
> +	struct f2fs_super_block *raw_super = F2FS_RAW_SUPER(sbi);
> +	block_t seg0_blkaddr = le32_to_cpu(raw_super->segment0_blkaddr);
> +	block_t main_blkaddr = le32_to_cpu(raw_super->main_blkaddr);
> +	block_t max_blkaddr = (le32_to_cpu(raw_super->segment_count)
> +				<< sbi->log_blocks_per_seg) + seg0_blkaddr;

Why not use the existing macros - MAIN_BLKADDR, SEG0_BLKADDR and MAX_BLKADDR?

> +
> +	if (is_read_io(fio->op)) {
> +		if (btype == META && fio->is_meta)
> +			BUG_ON(blk_addr < seg0_blkaddr
> +				|| blk_addr >= main_blkaddr);
> +		else
> +			BUG_ON(blk_addr < main_blkaddr
> +				|| blk_addr >= max_blkaddr);
> +	} else {
> +		if (btype == META)
> +			BUG_ON(blk_addr < seg0_blkaddr
> +				|| blk_addr >= main_blkaddr);
> +		else
> +			BUG_ON(blk_addr < main_blkaddr
> +				|| blk_addr >= max_blkaddr);
> +	}
>  }
>  
>  /*
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

-- 
--
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

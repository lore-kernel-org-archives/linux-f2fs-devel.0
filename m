From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3] f2fs: fix get stale meta pages when build free nids
Date: Sun, 8 Mar 2015 21:18:47 -0700
Message-ID: <20150309041847.GC4472@jaegeuk-mac02>
References: <1425870055-27694-1-git-send-email-wanpeng.li@linux.intel.com>
 <1425870055-27694-2-git-send-email-wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1425870055-27694-2-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Wanpeng Li <wanpeng.li@linux.intel.com>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

On Mon, Mar 09, 2015 at 11:00:54AM +0800, Wanpeng Li wrote:
> The blocks of nat pages to be scanned will be readahead when build free 
> nids. The start blkno will be adjusted to 0 when the intended range over 
> max_nids, then function ra_meta_pages readahead the right blkno, however, 
> function get_current_nat_page which is called in build_free_nids still 
> get the meta pages w/ stale blkno, this patch fix it by adjusting the nid 
> and the blkno which will be readahead in avdance in order to readahead and 
> get the right meta pages.
> 
> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
> ---
>  fs/f2fs/checkpoint.c | 3 ---
>  fs/f2fs/node.c       | 9 ++++++++-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index 53bc328..aedb441 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -129,9 +129,6 @@ int ra_meta_pages(struct f2fs_sb_info *sbi, block_t start, int nrpages, int type
>  
>  		switch (type) {
>  		case META_NAT:
> -			if (unlikely(blkno >=
> -					NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
> -				blkno = 0;
>  			/* get nat block addr */
>  			fio.blk_addr = current_nat_addr(sbi,
>  					blkno * NAT_ENTRY_PER_BLOCK);
> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
> index 1a7e925..8751375 100644
> --- a/fs/f2fs/node.c
> +++ b/fs/f2fs/node.c
> @@ -1509,13 +1509,20 @@ static void build_free_nids(struct f2fs_sb_info *sbi)
>  	struct f2fs_summary_block *sum = curseg->sum_blk;
>  	int i = 0;
>  	nid_t nid = nm_i->next_scan_nid;
> +	block_t blkno = NAT_BLOCK_OFFSET(nid);
>  
>  	/* Enough entries */
>  	if (nm_i->fcnt > NAT_ENTRY_PER_BLOCK)
>  		return;
>  
> +	if (unlikely(blkno >=
> +			NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid))) {
> +		blkno = 0;
> +		nid = 0;
> +	}

The assumption here is that the nid does not exceeed max_nid, since the
previous call already set next_scan_nid to 0, if it exceeds max_nid.
So, we don't need to do like this.

BTW, even if ra_meta_pages doesn't get the below condition,
		if (unlikely(blkno >=
				NAT_BLOCK_OFFSET(NM_I(sbi)->max_nid)))
			blkno = 0;
IMO, it is still worth to remain that to avoid any bugs due to further code
changes. It makes sense that unlikely was used for this too.

Thanks,

> +
>  	/* readahead nat pages to be scanned */
> -	ra_meta_pages(sbi, NAT_BLOCK_OFFSET(nid), FREE_NID_PAGES, META_NAT);
> +	ra_meta_pages(sbi, blkno, FREE_NID_PAGES, META_NAT);
>  
>  	while (1) {
>  		struct page *page = get_current_nat_page(sbi, nid);
> -- 
> 1.9.1

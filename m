From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/4] f2fs: lookup extent cache first under
 IPU scenario
Date: Tue, 25 Apr 2017 14:35:59 -0700
Message-ID: <20170425213559.GC1568@jaegeuk.local>
References: <20170425124515.160446-1-houpengyang@huawei.com>
	<20170425124515.160446-3-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d3882-00068X-2G
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:36:10 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d3880-0007gW-L2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 21:36:10 +0000
Content-Disposition: inline
In-Reply-To: <20170425124515.160446-3-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Hou Pengyang <houpengyang@huawei.com>
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Pengyang,

On 04/25, Hou Pengyang wrote:
> If a page is cold, NOT atomit written and need_ipu now, there is
> a high probability that IPU should be adapted. For IPU, we try to
> check extent tree to get the block index first, instead of reading
> the dnode page, where may lead to an useless dnode IO, since no need to
> update the dnode index for IPU.
> 
> Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/data.c    | 11 ++++++++++-
>  fs/f2fs/gc.c      |  1 +
>  fs/f2fs/segment.c |  1 +
>  3 files changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 02400b0..183a426 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -1346,21 +1346,29 @@ int do_write_data_page(struct f2fs_io_info *fio)
>  	struct page *page = fio->page;
>  	struct inode *inode = page->mapping->host;
>  	struct dnode_of_data dn;
> +	struct extent_info ei = {0,0,0};
>  	int err = 0;
>  
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> +	if (need_inplace_update(fio) &&
> +			f2fs_lookup_extent_cache(inode, page->index, &ei)) {
> +		fio->old_blkaddr = ei.blk + page->index - ei.fofs;
> +		if (fio->old_blkaddr != NULL_ADDR &&
> +				fio->old_blkaddr != NEW_ADDR)

			ipu_force = true;

I added one variable to do below ipu explicitly.

Thanks,

> +			goto got_it;
> +	}
>  	err = get_dnode_of_data(&dn, page->index, LOOKUP_NODE);
>  	if (err)
>  		return err;
>  
>  	fio->old_blkaddr = dn.data_blkaddr;
> -
>  	/* This page is already truncated */
>  	if (fio->old_blkaddr == NULL_ADDR) {
>  		ClearPageUptodate(page);
>  		goto out_writepage;
>  	}
>  
> +got_it:
>  	err = encrypt_one_page(fio);
>  	if (err)
>  		goto out_writepage;
> @@ -1408,6 +1416,7 @@ static int __write_data_page(struct page *page, bool *submitted,
>  		.type = DATA,
>  		.op = REQ_OP_WRITE,
>  		.op_flags = wbc_to_write_flags(wbc),
> +		.old_blkaddr = NULL_ADDR,
>  		.page = page,
>  		.encrypted_page = NULL,
>  		.submitted = false,
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 499a43f..e034857 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -712,6 +712,7 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
>  			.type = DATA,
>  			.op = REQ_OP_WRITE,
>  			.op_flags = REQ_SYNC,
> +			.old_blkaddr = NULL_ADDR,
>  			.page = page,
>  			.encrypted_page = NULL,
>  		};
> diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
> index 2a95535..9f86b98 100644
> --- a/fs/f2fs/segment.c
> +++ b/fs/f2fs/segment.c
> @@ -291,6 +291,7 @@ static int __commit_inmem_pages(struct inode *inode,
>  		.type = DATA,
>  		.op = REQ_OP_WRITE,
>  		.op_flags = REQ_SYNC | REQ_PRIO,
> +		.old_blkaddr = NULL_ADDR,
>  		.encrypted_page = NULL,
>  	};
>  	pgoff_t last_idx = ULONG_MAX;
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

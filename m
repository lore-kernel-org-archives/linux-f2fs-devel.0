From: Chao Yu <chao@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 5/5] f2fs crypto: fix incorrect positioning for
 GCing encrypted data page
Date: Mon, 22 Feb 2016 22:39:27 +0800
Message-ID: <56CB1D9F.9070505@kernel.org>
References: <004b01d16d5d$34e95cb0$9ebc1610$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <004b01d16d5d$34e95cb0$9ebc1610$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2016/2/22 18:38, Chao Yu wrote:
> For now, flow of GCing an encrypted data page will be:
> 1) try to grab meta page in meta inode's mapping with index of old block
> address of that data page
> 2) load data of ciphertext into meta page
> 3) allocate new block address
> 4) write the meta page into new block address
> 5) update block address pointer in direct node page.
> 
> Other reader/writer will use f2fs_wait_on_encrypted_page_writeback to
> check and wait on GCed encrypted data cached in meta page writebacked
> in order to avoid inconsistence among data page cache, meta page cache
> and data on-disk when updating.
> 
> However, we will use new block address updated in step 5) as an index to
> lookup meta page in inner bio buffer. That would be wrong, and we will
> never find the GCing meta page, since we use the old block address as
> index of that page in step 1).
> 
> This patch fixes the issue by adjust the order of step 1) and step 3),
> and in step 1) grab page with index generated in step 3).
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/gc.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 4af3d80..428159b 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -549,6 +549,7 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  	struct f2fs_summary sum;
>  	struct node_info ni;
>  	struct page *page;
> +	block_t newaddr;
>  	int err;
>  
>  	/* do not read out */
> @@ -579,12 +580,13 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  	fio.page = page;
>  	fio.new_blkaddr = fio.old_blkaddr = dn.data_blkaddr;
>  
> -	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi),
> -					fio.new_blkaddr,
> -					FGP_LOCK|FGP_CREAT,
> -					GFP_NOFS);
> +	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
> +							&sum, CURSEG_COLD_DATA);
> +
> +	fio.encrypted_page = pagecache_get_page(META_MAPPING(fio.sbi), newaddr,
> +					FGP_LOCK | FGP_CREAT, GFP_NOFS);
>  	if (!fio.encrypted_page)
> -		goto put_out;
> +		goto invalid_block;
>  
>  	err = f2fs_submit_page_bio(&fio);
>  	if (err)
> @@ -607,9 +609,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  
>  	/* allocate block address */
>  	f2fs_wait_on_page_writeback(dn.node_page, NODE, true);
> -	allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &fio.new_blkaddr,
> -							&sum, CURSEG_COLD_DATA);
> +
>  	fio.rw = WRITE_SYNC;
> +	fio.new_blkaddr = newaddr;
>  	f2fs_submit_page_mbio(&fio);
>  
>  	dn.data_blkaddr = fio.new_blkaddr;
> @@ -620,6 +622,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  		set_inode_flag(F2FS_I(inode), FI_FIRST_BLOCK_WRITTEN);
>  put_page_out:
>  	f2fs_put_page(fio.encrypted_page, 1);
> +invalid_block:
> +	invalidate_blocks(fio.sbi, newaddr);

Need to recover old blkaddr here rather than just invalidate new blkaddr. I will
fix this and resend the patch tomorrow. Sorry for the noise.

Thanks,

>  put_out:
>  	f2fs_put_dnode(&dn);
>  out:
> 

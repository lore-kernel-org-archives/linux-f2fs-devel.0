From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v2] f2fs:return directly if block has been
 removed from the victim
Date: Wed, 2 Nov 2016 11:05:11 -0700
Message-ID: <20161102180511.GD48728@jaegeuk>
References: <20161102104150.29358-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1c1zuh-0000Zs-9I
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 18:05:27 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1c1zuf-0001fe-TF
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 02 Nov 2016 18:05:27 +0000
Content-Disposition: inline
In-Reply-To: <20161102104150.29358-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>
Cc: heyunlei@huwei.com, linux-f2fs-devel@lists.sourceforge.net

On Wed, Nov 02, 2016 at 06:41:50PM +0800, Yunlei He wrote:
> If one block has been to written to a new place, just return
> in move data process. This patch check it again with holding
> page lock.
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>
> ---
>  fs/f2fs/gc.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
> index 9c18917..131e0fe 100644
> --- a/fs/f2fs/gc.c
> +++ b/fs/f2fs/gc.c
> @@ -544,7 +544,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  	return true;
>  }
>  
> -static void move_encrypted_block(struct inode *inode, block_t bidx)
> +static void move_encrypted_block(struct inode *inode, block_t bidx,
> +							unsigned int segno, int off)
>  {
>  	struct f2fs_io_info fio = {
>  		.sbi = F2FS_I_SB(inode),
> @@ -579,6 +580,9 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  	 * don't cache encrypted data into meta inode until previous dirty
>  	 * data were writebacked to avoid racing between GC and flush.
>  	 */
> +	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> +		goto out;

goto put_out;

> +
>  	f2fs_wait_on_page_writeback(page, DATA, true);
>  
>  	get_node_info(fio.sbi, dn.nid, &ni);
> @@ -645,7 +649,8 @@ static void move_encrypted_block(struct inode *inode, block_t bidx)
>  	f2fs_put_page(page, 1);
>  }
>  
> -static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
> +static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
> +							unsigned int segno, int off)
>  {
>  	struct page *page;
>  
> @@ -670,6 +675,9 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
>  		bool is_dirty = PageDirty(page);
>  		int err;
>  
> +		if (!check_valid_map(F2FS_I_SB(inode), segno, off))
> +			goto out;

Agreed with Chao.

Thanks,

> +
>  retry:
>  		set_page_dirty(page);
>  		f2fs_wait_on_page_writeback(page, DATA, true);
> @@ -796,9 +804,9 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
>  			start_bidx = start_bidx_of_node(nofs, inode)
>  								+ ofs_in_node;
>  			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
> -				move_encrypted_block(inode, start_bidx);
> +				move_encrypted_block(inode, start_bidx, segno, off);
>  			else
> -				move_data_page(inode, start_bidx, gc_type);
> +				move_data_page(inode, start_bidx, gc_type, segno, off);
>  
>  			if (locked) {
>  				up_write(&fi->dio_rwsem[WRITE]);
> -- 
> 2.10.1
> 
> 
> ------------------------------------------------------------------------------
> Developer Access Program for Intel Xeon Phi Processors
> Access to Intel Xeon Phi processor-based developer platforms.
> With one year of Intel Parallel Studio XE.
> Training and support from Colfax.
> Order your platform today. http://sdm.link/xeonphi
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Developer Access Program for Intel Xeon Phi Processors
Access to Intel Xeon Phi processor-based developer platforms.
With one year of Intel Parallel Studio XE.
Training and support from Colfax.
Order your platform today. http://sdm.link/xeonphi

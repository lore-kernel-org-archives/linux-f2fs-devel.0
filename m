From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 2/4] f2fs: remove the needless point-cast
Date: Wed, 25 Jun 2014 09:55:19 +0800
Message-ID: <002e01cf9018$9f793790$de6ba6b0$@samsung.com>
References: <53A950BB.2030703@cn.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <53A950BB.2030703@cn.fujitsu.com>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: 'Gu Zheng' <guz.fnst@cn.fujitsu.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: 'fsdevel' <linux-fsdevel@vger.kernel.org>, 'f2fs' <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Gu,

I found kaddr in f2fs_delete_entry is unneeded, maybe this trivial problem
could be fixed in this patch together. :)

Thanks.

> -----Original Message-----
> From: Gu Zheng [mailto:guz.fnst@cn.fujitsu.com]
> Sent: Tuesday, June 24, 2014 6:20 PM
> To: Jaegeuk Kim
> Cc: fsdevel; f2fs
> Subject: [f2fs-dev] [PATCH 2/4] f2fs: remove the needless point-cast
> 
> Signed-off-by: Gu Zheng <guz.fnst@cn.fujitsu.com>
> ---
>  fs/f2fs/dir.c |   14 ++++++--------
>  1 files changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 087b03d..3edd561 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -298,14 +298,13 @@ static int make_empty_dir(struct inode *inode,
>  	struct page *dentry_page;
>  	struct f2fs_dentry_block *dentry_blk;
>  	struct f2fs_dir_entry *de;
> -	void *kaddr;
> 
>  	dentry_page = get_new_data_page(inode, page, 0, true);
>  	if (IS_ERR(dentry_page))
>  		return PTR_ERR(dentry_page);
> 
> -	kaddr = kmap_atomic(dentry_page);
> -	dentry_blk = (struct f2fs_dentry_block *)kaddr;
> +
> +	dentry_blk = kmap_atomic(dentry_page);
> 
>  	de = &dentry_blk->dentry[0];
>  	de->name_len = cpu_to_le16(1);
> @@ -323,7 +322,7 @@ static int make_empty_dir(struct inode *inode,
> 
>  	test_and_set_bit_le(0, &dentry_blk->dentry_bitmap);
>  	test_and_set_bit_le(1, &dentry_blk->dentry_bitmap);
> -	kunmap_atomic(kaddr);
> +	kunmap_atomic(dentry_blk);
> 
>  	set_page_dirty(dentry_page);
>  	f2fs_put_page(dentry_page, 1);
> @@ -632,7 +631,6 @@ bool f2fs_empty_dir(struct inode *dir)
>  	unsigned long nblock = dir_blocks(dir);
> 
>  	for (bidx = 0; bidx < nblock; bidx++) {
> -		void *kaddr;
>  		dentry_page = get_lock_data_page(dir, bidx);
>  		if (IS_ERR(dentry_page)) {
>  			if (PTR_ERR(dentry_page) == -ENOENT)
> @@ -641,8 +639,8 @@ bool f2fs_empty_dir(struct inode *dir)
>  				return false;
>  		}
> 
> -		kaddr = kmap_atomic(dentry_page);
> -		dentry_blk = (struct f2fs_dentry_block *)kaddr;
> +
> +		dentry_blk = kmap_atomic(dentry_page);
>  		if (bidx == 0)
>  			bit_pos = 2;
>  		else
> @@ -650,7 +648,7 @@ bool f2fs_empty_dir(struct inode *dir)
>  		bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
>  						NR_DENTRY_IN_BLOCK,
>  						bit_pos);
> -		kunmap_atomic(kaddr);
> +		kunmap_atomic(dentry_blk);
> 
>  		f2fs_put_page(dentry_page, 1);
> 
> --
> 1.7.7
> 
> 
> ------------------------------------------------------------------------------
> Open source business process management suite built on Java and Eclipse
> Turn processes into business applications with Bonita BPM Community Edition
> Quickly connect people, data, and systems into organized workflows
> Winner of BOSSIE, CODIE, OW2 and Gartner awards
> http://p.sf.net/sfu/Bonitasoft
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


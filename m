From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH 3/3] f2fs:use enum dentrt_ptr type to replace
 constant use
Date: Mon, 09 Mar 2015 14:52:29 +0800
Message-ID: <000201d05a35$b84bdb50$28e391f0$@samsung.com>
References: <1592448705.458641425723017011.JavaMail.weblogic@epmlwas08b>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1592448705.458641425723017011.JavaMail.weblogic@epmlwas08b>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: yuan.mark.zhong@samsung.com, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Yuan,

> -----Original Message-----
> From: Yuan Zhong [mailto:yuan.mark.zhong@samsung.com]
> Sent: Saturday, March 07, 2015 6:10 PM
> To: Jaegeuk Kim
> Cc: linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org;
> linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH 3/3] f2fs:use enum dentrt_ptr type to replace constant use
> 
> The function make_dentry_ptr has an argument 'int type'.
> This argument is used to distinguish 'block dentry' and
> 'inline dentry'. We used 1 and 2 as the type. To make
> code more readable, we use enum type to replace constant
> use.
> 
> Signed-off-by: Yuan Zhong <yuan.mark.zhong@samsung.com>
> ---
>  fs/f2fs/dir.c    |    8 ++++----
>  fs/f2fs/f2fs.h   |    8 +++++++-
>  fs/f2fs/inline.c |    8 ++++----
>  3 files changed, 15 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
> index 590aeef..c39a18f 100644
> --- a/fs/f2fs/dir.c
> +++ b/fs/f2fs/dir.c
> @@ -99,7 +99,7 @@ static struct f2fs_dir_entry *find_in_block(struct page *dentry_page,
> 
>  	dentry_blk = (struct f2fs_dentry_block *)kmap(dentry_page);
> 
> -	make_dentry_ptr(&d, (void *)dentry_blk, 1);
> +	make_dentry_ptr(&d, (void *)dentry_blk, DENTRY_PTR_TYPE_BLOCK);
>  	de = find_target_dentry(name, max_slots, &d);
> 
>  	if (de)
> @@ -360,7 +360,7 @@ static int make_empty_dir(struct inode *inode,
> 
>  	dentry_blk = kmap_atomic(dentry_page);
> 
> -	make_dentry_ptr(&d, (void *)dentry_blk, 1);
> +	make_dentry_ptr(&d, (void *)dentry_blk, DENTRY_PTR_TYPE_BLOCK);
>  	do_make_empty_dir(inode, parent, &d);
> 
>  	kunmap_atomic(dentry_blk);
> @@ -571,7 +571,7 @@ add_dentry:
>  		goto fail;
>  	}
> 
> -	make_dentry_ptr(&d, (void *)dentry_blk, 1);
> +	make_dentry_ptr(&d, (void *)dentry_blk, DENTRY_PTR_TYPE_BLOCK);
>  	f2fs_update_dentry(inode, &d, name, dentry_hash, bit_pos);
> 
>  	set_page_dirty(dentry_page);
> @@ -782,7 +782,7 @@ static int f2fs_readdir(struct file *file, struct dir_context *ctx)
> 
>  		dentry_blk = kmap(dentry_page);
> 
> -		make_dentry_ptr(&d, (void *)dentry_blk, 1);
> +		make_dentry_ptr(&d, (void *)dentry_blk, DENTRY_PTR_TYPE_BLOCK);
> 
>  		if (f2fs_fill_dentries(ctx, &d, n * NR_DENTRY_IN_BLOCK))
>  			goto stop;
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 511d6cd..31b440e 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -236,10 +236,16 @@ struct f2fs_dentry_ptr {
>  	int max;
>  };
> 
> +enum {
> +	DENTRY_PTR_TYPE_BLOCK = 1,
> +	DENTRY_PTR_TYPE_INLNE,
> +	DENTRY_PTR_TYPE_MAX
> +};

How do you think of using below enum?

enum dentry_type {
	REGULAR_DENTRY = 1,
	INLINE_DENTRY,
};



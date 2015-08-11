From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 3/4] f2fs: handle error of f2fs_iget correctly
Date: Tue, 11 Aug 2015 11:35:30 -0700
Message-ID: <20150811183530.GB14784@jaegeuk-mac02.mot.com>
References: <018001d0d0fd$a8f47240$fadd56c0$@samsung.com>
 <20150810193201.GB3815@jaegeuk-mac02.mot.com>
 <008c01d0d422$88810dc0$99832940$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <008c01d0d422$88810dc0$99832940$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Aug 11, 2015 at 06:42:19PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Tuesday, August 11, 2015 3:32 AM
> > To: Chao Yu
> > Cc: linux-f2fs-devel@lists.sourceforge.net; linux-kernel@vger.kernel.org;
> > linux-fsdevel@vger.kernel.org
> > Subject: Re: [PATCH 3/4] f2fs: handle error of f2fs_iget correctly
> > 
> > Hi Chao,
> > 
> > On Fri, Aug 07, 2015 at 06:41:02PM +0800, Chao Yu wrote:
> > > In recover_orphan_inode, if f2fs_iget failed, we change to report the
> > > error number to its caller instead of bug_on.
> > 
> > Let's keep this in order to catch any bugs.
> > Or, is there another issue on this?
> 
> f2fs_iget can fail due to a lot of reason, like out of memory, IMO,
> it's better to report such error number to user instead of make kernel
> panic. So how about keeping bug_on when finding no entry for orphan
> inode, otherwise reporting error to caller?

Much better. :)
Thanks,

> 
> >From 05068a0068a9d0a60296c492967ef2433ad0e35f Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Fri, 7 Aug 2015 17:58:43 +0800
> Subject: [PATCH v2 3/4] f2fs: handle error of f2fs_iget correctly
> 
> In recover_orphan_inode, whenever f2fs_iget fail, we will make kernel panic,
> but it's not reasonable, because f2fs_iget can fail due to a lot of reasons
> including out of memory.
> 
> So we change error handling method as below:
> a) when finding no entry for the orphan inode, bug_on for catching bugs;
> b) for other reasons, report it to caller.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/checkpoint.c | 31 ++++++++++++++++++++++++-------
>  fs/f2fs/f2fs.h       |  2 +-
>  fs/f2fs/super.c      |  4 +++-
>  3 files changed, 28 insertions(+), 9 deletions(-)
> 
> diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
> index c311176..0958c83 100644
> --- a/fs/f2fs/checkpoint.c
> +++ b/fs/f2fs/checkpoint.c
> @@ -468,22 +468,34 @@ void remove_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  	__remove_ino_entry(sbi, ino, ORPHAN_INO);
>  }
>  
> -static void recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
> +static int recover_orphan_inode(struct f2fs_sb_info *sbi, nid_t ino)
>  {
> -	struct inode *inode = f2fs_iget(sbi->sb, ino);
> -	f2fs_bug_on(sbi, IS_ERR(inode));
> +	struct inode *inode;
> +
> +	inode = f2fs_iget(sbi->sb, ino);
> +	if (IS_ERR(inode)) {
> +		/*
> +		 * there should be a bug that we can't find the entry
> +		 * to orphan inode.
> +		 */
> +		f2fs_bug_on(sbi, PTR_ERR(inode) == -ENOENT);
> +		return PTR_ERR(inode);
> +	}
> +
>  	clear_nlink(inode);
>  
>  	/* truncate all the data during iput */
>  	iput(inode);
> +	return 0;
>  }
>  
> -void recover_orphan_inodes(struct f2fs_sb_info *sbi)
> +int recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  {
>  	block_t start_blk, orphan_blocks, i, j;
> +	int err;
>  
>  	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
> -		return;
> +		return 0;
>  
>  	set_sbi_flag(sbi, SBI_POR_DOING);
>  
> @@ -499,14 +511,19 @@ void recover_orphan_inodes(struct f2fs_sb_info *sbi)
>  		orphan_blk = (struct f2fs_orphan_block *)page_address(page);
>  		for (j = 0; j < le32_to_cpu(orphan_blk->entry_count); j++) {
>  			nid_t ino = le32_to_cpu(orphan_blk->ino[j]);
> -			recover_orphan_inode(sbi, ino);
> +			err = recover_orphan_inode(sbi, ino);
> +			if (err) {
> +				f2fs_put_page(page, 1);
> +				clear_sbi_flag(sbi, SBI_POR_DOING);
> +				return err;
> +			}
>  		}
>  		f2fs_put_page(page, 1);
>  	}
>  	/* clear Orphan Flag */
>  	clear_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG);
>  	clear_sbi_flag(sbi, SBI_POR_DOING);
> -	return;
> +	return 0;
>  }
>  
>  static void write_orphan_inodes(struct f2fs_sb_info *sbi, block_t start_blk)
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f18d31e..d0e9b70 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -1748,7 +1748,7 @@ int acquire_orphan_inode(struct f2fs_sb_info *);
>  void release_orphan_inode(struct f2fs_sb_info *);
>  void add_orphan_inode(struct f2fs_sb_info *, nid_t);
>  void remove_orphan_inode(struct f2fs_sb_info *, nid_t);
> -void recover_orphan_inodes(struct f2fs_sb_info *);
> +int recover_orphan_inodes(struct f2fs_sb_info *);
>  int get_valid_checkpoint(struct f2fs_sb_info *);
>  void update_dirty_page(struct inode *, struct page *);
>  void add_dirty_dir_inode(struct inode *);
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a79b6b5..4db5cd9 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1245,7 +1245,9 @@ try_onemore:
>  	f2fs_join_shrinker(sbi);
>  
>  	/* if there are nt orphan nodes free them */
> -	recover_orphan_inodes(sbi);
> +	err = recover_orphan_inodes(sbi);
> +	if (err)
> +		goto free_node_inode;
>  
>  	/* read root inode and dentry */
>  	root = f2fs_iget(sb, F2FS_ROOT_INO(sbi));
> -- 
> 2.4.2

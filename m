From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node
 was changed
Date: Wed, 23 Dec 2015 11:13:38 -0800
Message-ID: <20151223191338.GD30505@jaegeuk.local>
References: <1450832388-29118-1-git-send-email-jaegeuk@kernel.org>
 <1450832388-29118-4-git-send-email-jaegeuk@kernel.org>
 <010b01d13d66$f85f2ac0$e91d8040$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <010b01d13d66$f85f2ac0$e91d8040$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

On Wed, Dec 23, 2015 at 05:46:59PM +0800, Chao Yu wrote:
> Hi Jaegeuk,
> 
> > -----Original Message-----
> > From: Jaegeuk Kim [mailto:jaegeuk@kernel.org]
> > Sent: Wednesday, December 23, 2015 9:00 AM
> > To: linux-kernel@vger.kernel.org; linux-fsdevel@vger.kernel.org;
> > linux-f2fs-devel@lists.sourceforge.net
> > Cc: Jaegeuk Kim
> > Subject: [f2fs-dev] [PATCH 4/4] f2fs: call f2fs_balance_fs only when node was changed
> > 
> > If user tries to update or read data, we don't need to call f2fs_balance_fs
> > which triggers f2fs_gc, which increases unnecessary long latency.
> 
> One missing case is get_data_block_dio, how about also covering it based on
> following patch?

It makes sense.
I'll submit v2.

Thanks,

> 
> 
> >From 7175efac7473e7a04285055c69edfb7432f8ca4e Mon Sep 17 00:00:00 2001
> From: Chao Yu <chao2.yu@samsung.com>
> Date: Wed, 23 Dec 2015 17:11:43 +0800
> Subject: [PATCH] f2fs: reduce covered region of sbi->cp_rwsem in
>  f2fs_map_blocks
> 
> Only cover sbi->cp_rwsem on one dnode page's allocation and modification
> instead of multiple's in f2fs_map_blocks, it can reduce the covered region
> of cp_rwsem, then we can avoid potential long time delay for concurrent
> checkpointer.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
>  fs/f2fs/data.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> index 8f8f8b0..3c83b16 100644
> --- a/fs/f2fs/data.c
> +++ b/fs/f2fs/data.c
> @@ -594,7 +594,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
>  	}
>  
>  	if (create)
> -		f2fs_lock_op(F2FS_I_SB(inode));
> +		f2fs_lock_op(sbi);
>  
>  	/* When reading holes, we need its node page */
>  	set_new_dnode(&dn, inode, NULL, NULL, 0);
> @@ -651,6 +651,11 @@ get_next:
>  		allocated = false;
>  		f2fs_put_dnode(&dn);
>  
> +		if (create) {
> +			f2fs_unlock_op(sbi);
> +			f2fs_lock_op(sbi);
> +		}
> +
>  		set_new_dnode(&dn, inode, NULL, NULL, 0);
>  		err = get_dnode_of_data(&dn, pgofs, mode);
>  		if (err) {
> @@ -706,7 +711,7 @@ put_out:
>  	f2fs_put_dnode(&dn);
>  unlock_out:
>  	if (create)
> -		f2fs_unlock_op(F2FS_I_SB(inode));
> +		f2fs_unlock_op(sbi);
>  out:
>  	trace_f2fs_map_blocks(inode, map, err);
>  	return err;
> -- 
> 2.6.3
> 

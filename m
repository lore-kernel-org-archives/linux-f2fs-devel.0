From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: fix to avoid quota inode leak in ->put_super
Date: Sat, 18 Aug 2018 08:16:00 -0700
Message-ID: <20180818151600.GA84798@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180817091840.50792-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180817091840.50792-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 08/17, Chao Yu wrote:
> generic/019 reports below error:
> 
>  __quota_error: 1160 callbacks suppressed
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  Quota error (device zram1): write_blk: dquota write failed
>  Quota error (device zram1): qtree_write_dquot: Error -28 occurred while creating quota
>  VFS: Busy inodes after unmount of zram1. Self-destruct in 5 seconds.  Have a nice day...
> 
> If we failed in below path due to fail to write dquot block, we will miss
> to release quota inode, fix it.
> 
> - f2fs_put_super
>  - f2fs_quota_off_umount
>   - f2fs_quota_off
>    - f2fs_quota_sync   <-- failed
>    - dquot_quota_off   <-- missed to call
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/super.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index a5df9fbc6355..9647bbcdfd2b 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -1977,10 +1977,12 @@ void f2fs_quota_off_umount(struct super_block *sb)
>  	for (type = 0; type < MAXQUOTAS; type++) {
>  		err = f2fs_quota_off(sb, type);
>  		if (err) {
> +			int ret = dquot_quota_off(sb, type);
> +

Could you check the mainline version?

>  			f2fs_msg(sb, KERN_ERR,
>  				"Fail to turn off disk quota "
> -				"(type: %d, err: %d), Please "
> -				"run fsck to fix it.", type, err);
> +				"(type: %d, err: %d, ret:%d), Please "
> +				"run fsck to fix it.", type, err, ret);
>  			set_sbi_flag(F2FS_SB(sb), SBI_NEED_FSCK);
>  		}
>  	}
> -- 
> 2.18.0.rc1

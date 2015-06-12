From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [f2fs-dev] [PATCH v2] f2fs: do not trim preallocated blocks when
 truncating after i_size
Date: Fri, 12 Jun 2015 08:30:09 +0800
Message-ID: <00e401d0a4a7$11d8a9d0$3589fd70$@samsung.com>
References: <007b01d0a25b$ff2a99d0$fd7fcd70$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <007b01d0a25b$ff2a99d0$fd7fcd70$@samsung.com>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,

> -----Original Message-----
> From: Chao Yu [mailto:chao2.yu@samsung.com]
> Sent: Tuesday, June 09, 2015 10:28 AM
> To: Jaegeuk Kim; Changman Lee
> Cc: linux-kernel@vger.kernel.org; linux-f2fs-devel@lists.sourceforge.net
> Subject: [f2fs-dev] [PATCH v2] f2fs: do not trim preallocated blocks when truncating after i_size
> 
> When we perform generic/092 in xfstests, output is like below:
> 
>      XXX Bytes, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
>      0: [0..10239]: data
>      0: [0..10239]: data
>     -1: [10240..20479]: unwritten
>     +1: [10240..14335]: unwritten
> 
> This is because with this testcase, we redefine the regulation for
> truncate in perallocated space past i_size as below:
> 
> "There was some confused about what the fs was supposed to do when you
> truncate at i_size with preallocated space past i_size. We decided on the
> following things.
> 
> 1) truncate(i_size) will trim all blocks past i_size.
> 2) truncate(x) where x > i_size will not trim all blocks past i_size.
> "
> 
> This method is used in xfs, and then ext4/btrfs will follow the rule.
> 
> This patch fixes to follow the new rule for f2fs.
> 
> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
> ---
> v2:
>  * adjust code style pointed out by Jaegeuk Kim.
> 
>  fs/f2fs/file.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4d42d66..ec47c4a 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -651,16 +651,15 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  				f2fs_get_encryption_info(inode))
>  			return -EACCES;
> 
> -		if (attr->ia_size != i_size_read(inode)) {
> -			truncate_setsize(inode, attr->ia_size);
> +		truncate_setsize(inode, attr->ia_size);
> +
> +		/*
> +		 * do not trim all preallocated blocks after i_size if target
> +		 * size is larger than i_size.
> +		 */
> +		if (attr->ia_size <= i_size_read(inode)) {

It's wrong implementation here, because we have set i_size in inode with
attr->ia_size, so that we will always go into this "truncate smaller size"
branch.

Please ignore this patch, sorry for my mistake.

Jaegeuk, I'd like to use v1 patch, how do you think?

Thanks,

>  			f2fs_truncate(inode);
>  			f2fs_balance_fs(F2FS_I_SB(inode));
> -		} else {
> -			/*
> -			 * giving a chance to truncate blocks past EOF which
> -			 * are fallocated with FALLOC_FL_KEEP_SIZE.
> -			 */
> -			f2fs_truncate(inode);
>  		}
>  	}
> 
> --
> 2.4.2
> 
> 
> 
> ------------------------------------------------------------------------------
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

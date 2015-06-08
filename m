From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs: do not trim preallocated blocks when truncating
 after i_size
Date: Mon, 8 Jun 2015 11:06:43 -0700
Message-ID: <20150608180643.GA59258@jaegeuk-mac02.mot.com>
References: <000101d09f7b$4a2559e0$de700da0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000101d09f7b$4a2559e0$de700da0$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jun 05, 2015 at 06:34:02PM +0800, Chao Yu wrote:
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
>  fs/f2fs/file.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 4d42d66..85f97af 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -651,16 +651,16 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  				f2fs_get_encryption_info(inode))
>  			return -EACCES;
>  
> -		if (attr->ia_size != i_size_read(inode)) {
> +		if (attr->ia_size <= i_size_read(inode)) {
>  			truncate_setsize(inode, attr->ia_size);
>  			f2fs_truncate(inode);
>  			f2fs_balance_fs(F2FS_I_SB(inode));
>  		} else {
>  			/*
> -			 * giving a chance to truncate blocks past EOF which
> -			 * are fallocated with FALLOC_FL_KEEP_SIZE.
> +			 * do not trim all blocks after i_size if target size is
> +			 * larger than i_size.
>  			 */
> -			f2fs_truncate(inode);
> +			truncate_setsize(inode, attr->ia_size);

So, we can do:
		truncate_setsize();

		if (attr->ia_size <= i_size_read(inode)) {
			f2fs_truncate(inode);
			f2fs_balance_fs();
		}
	
Right?

>  		}
>  	}
>  
> -- 
> 2.4.2

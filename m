From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [PATCH 1/3] fscrypto: use dget_parent() in fscrypt_d_revalidate()
Date: Tue, 12 Apr 2016 23:33:03 +0100
Message-ID: <20160412223303.GQ25498@ZenIV.linux.org.uk>
References: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1460482042-14011-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, Theodore Ts'o <tytso@mit.edu>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Apr 12, 2016 at 10:27:20AM -0700, Jaegeuk Kim wrote:
> This patch updates fscrypto along with the below ext4 crypto change.
> 
> Fixes: 3d43bcfef5f0 ("ext4 crypto: use dget_parent() in ext4_d_revalidate()")

>  static int fscrypt_d_revalidate(struct dentry *dentry, unsigned int flags)
>  {
> -	struct inode *dir = d_inode(dentry->d_parent);
> -	struct fscrypt_info *ci = dir->i_crypt_info;
> +	struct dentry *dir;
> +	struct fscrypt_info *ci;
>  	int dir_has_key, cached_with_key;
>  
> -	if (!dir->i_sb->s_cop->is_encrypted(dir))
> +	dir = dget_parent(dentry);
> +	if (!d_inode(dir)->i_sb->s_cop->is_encrypted(d_inode(dir))) {
> +		dput(dir);

... and as soon as you call it from RCU mode, you are screwed.

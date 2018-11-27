From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH 6/7] f2fs: use IS_VERITY() to check inode's
 fsverity status
Date: Mon, 26 Nov 2018 16:41:12 -0800
Message-ID: <20181127004112.GE11663@gmail.com>
References: <20181119052324.31456-1-chandan@linux.vnet.ibm.com>
 <20181119052324.31456-7-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1gRRRL-0004Dd-3i
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:41:23 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gRRRI-00GYN4-6A
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 27 Nov 2018 00:41:23 +0000
Content-Disposition: inline
In-Reply-To: <20181119052324.31456-7-chandan@linux.vnet.ibm.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org, tytso@mit.edu, linux-f2fs-devel@lists.sourceforge.net

Hi Chandan,

On Mon, Nov 19, 2018 at 10:53:23AM +0530, Chandan Rajendra wrote:
> This commit now uses IS_VERITY() macro to check if fsverity is
> enabled on an inode.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>
> ---
>  fs/f2fs/file.c  | 6 +++---
>  fs/f2fs/inode.c | 4 +++-
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index 6c7ad15000b9..2eb4821d95d1 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -491,7 +491,7 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
>  	if (err)
>  		return err;
>  
> -	if (f2fs_verity_file(inode)) {
> +	if (IS_VERITY(inode)) {
>  		err = fsverity_file_open(inode, filp);
>  		if (err)
>  			return err;
> @@ -701,7 +701,7 @@ int f2fs_getattr(const struct path *path, struct kstat *stat,
>  	struct f2fs_inode *ri;
>  	unsigned int flags;
>  
> -	if (f2fs_verity_file(inode)) {
> +	if (IS_VERITY(inode)) {
>  		/*
>  		 * For fs-verity we need to override i_size with the original
>  		 * data i_size.  This requires I/O to the file which with
> @@ -800,7 +800,7 @@ int f2fs_setattr(struct dentry *dentry, struct iattr *attr)
>  	if (err)
>  		return err;
>  
> -	if (f2fs_verity_file(inode)) {
> +	if (IS_VERITY(inode)) {
>  		err = fsverity_prepare_setattr(dentry, attr);
>  		if (err)
>  			return err;
> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
> index ddef483ad689..02806feed64c 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -45,9 +45,11 @@ void f2fs_set_inode_flags(struct inode *inode)
>  		new_fl |= S_DIRSYNC;
>  	if (f2fs_encrypted_inode(inode))
>  		new_fl |= S_ENCRYPTED;
> +	if (f2fs_verity_file(inode))
> +		new_fl |= S_VERITY;
>  	inode_set_flags(inode, new_fl,
>  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
> -			S_ENCRYPTED);
> +			S_ENCRYPTED|S_VERITY);
>  }
>  
>  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
> -- 
> 2.19.1

Like the ext4 patch, it's missing syncing the verity flag to the VFS inode
during FS_IOC_ENABLE_VERITY:

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 4f58d5840d17..841019d8bc96 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -2207,6 +2207,7 @@ static int f2fs_set_verity(struct inode *inode, loff_t data_i_size)
 		return err;
 
 	file_set_verity(inode);
+	f2fs_set_inode_flags(inode);
 	f2fs_mark_inode_dirty_sync(inode, true);
 	return 0;
 }

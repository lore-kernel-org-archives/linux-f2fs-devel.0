From: Eric Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH V3 6/9] f2fs: use IS_VERITY() to check inode's fsverity
 status
Date: Mon, 10 Dec 2018 10:17:18 -0800
Message-ID: <20181210181718.GF92174@gmail.com>
References: <20181208065144.19486-1-chandan@linux.vnet.ibm.com>
 <20181208065144.19486-7-chandan@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181208065144.19486-7-chandan@linux.vnet.ibm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+gldm-linux-mtd-36=gmane.org@lists.infradead.org
To: Chandan Rajendra <chandan@linux.vnet.ibm.com>
Cc: linux-mips@linux-mips.org, linux-doc@vger.kernel.org, jhogan@kernel.org, yuchao0@huawei.com, heiko.carstens@de.ibm.com, linux-mtd@lists.infradead.org, deanbo422@gmail.com, linux-s390@vger.kernel.org, corbet@lwn.net, richard@nod.at, linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org, green.hu@gmail.com, jaegeuk@kernel.org, tytso@mit.edu, dedekind1@gmail.com, adrian.hunter@intel.com, ralf@linux-mips.org, linux-f2fs-devel@lists.sourceforge.net, paul.burton@mips.com, schwidefsky@de.ibm.com, adilger.kernel@dilger.ca, viro@zeniv.linux.org.uk
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Sat, Dec 08, 2018 at 12:21:41PM +0530, Chandan Rajendra wrote:
> This commit removes the f2fs specific f2fs_verity_file() and makes use
> of the generic IS_VERITY() macro or file_is_verity() to check for the
> verity status of an inode.
> 
> Signed-off-by: Chandan Rajendra <chandan@linux.vnet.ibm.com>

Reviewed-by: Eric Biggers <ebiggers@google.com>

> ---
>  fs/f2fs/f2fs.h  | 7 +------
>  fs/f2fs/file.c  | 6 +++---
>  fs/f2fs/inode.c | 4 +++-
>  fs/f2fs/super.c | 1 +
>  4 files changed, 8 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index f9c8b0afc1de..54bd93c7b630 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -3448,18 +3448,13 @@ static inline void f2fs_set_encrypted_inode(struct inode *inode)
>  #endif
>  }
>  
> -static inline bool f2fs_verity_file(struct inode *inode)
> -{
> -	return file_is_verity(inode);
> -}
> -
>  /*
>   * Returns true if the reads of the inode's data need to undergo some
>   * postprocessing step, like decryption or authenticity verification.
>   */
>  static inline bool f2fs_post_read_required(struct inode *inode)
>  {
> -	return f2fs_encrypted_file(inode) || f2fs_verity_file(inode);
> +	return f2fs_encrypted_file(inode) || IS_VERITY(inode);
>  }
>  
>  #define F2FS_FEATURE_FUNCS(name, flagname) \
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
> index d731d23aedee..ff9126616d65 100644
> --- a/fs/f2fs/inode.c
> +++ b/fs/f2fs/inode.c
> @@ -45,9 +45,11 @@ void f2fs_set_inode_flags(struct inode *inode)
>  		new_fl |= S_DIRSYNC;
>  	if (file_is_encrypt(inode))
>  		new_fl |= S_ENCRYPTED;
> +	if (file_is_verity(inode))
> +		new_fl |= S_VERITY;
>  	inode_set_flags(inode, new_fl,
>  			S_SYNC|S_APPEND|S_IMMUTABLE|S_NOATIME|S_DIRSYNC|
> -			S_ENCRYPTED);
> +			S_ENCRYPTED|S_VERITY);
>  }
>  
>  static void __get_inode_rdev(struct inode *inode, struct f2fs_inode *ri)
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 4287cf348d3c..73320202bd01 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -2207,6 +2207,7 @@ static int f2fs_set_verity(struct inode *inode, loff_t data_i_size)
>  		return err;
>  
>  	file_set_verity(inode);
> +	f2fs_set_inode_flags(inode);
>  	f2fs_mark_inode_dirty_sync(inode, true);
>  	return 0;
>  }
> -- 
> 2.19.1
> 

______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

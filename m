From: Gu Zheng <guz.fnst@cn.fujitsu.com>
Subject: Re: [RFC 1/1] f2fs: don't GC or take an fs_lock from
	f2fs_initxattrs()
Date: Wed, 25 Sep 2013 10:48:05 +0800
Message-ID: <52424EE5.3070807@cn.fujitsu.com>
References: <n> <1380055763-13425-1-git-send-email-rknize@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <guz.fnst@cn.fujitsu.com>) id 1VOfE4-000313-HO
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Sep 2013 02:53:16 +0000
Received: from [222.73.24.84] (helo=song.cn.fujitsu.com)
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1VOfE2-0002lD-Vj for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 25 Sep 2013 02:53:16 +0000
In-Reply-To: <1380055763-13425-1-git-send-email-rknize@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Russ Knize <rknize@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Russ Knize <Russ.Knize@motorola.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 09/25/2013 04:49 AM, Russ Knize wrote:

> From: Russ Knize <Russ.Knize@motorola.com>
> 
> f2fs_initxattrs() is called internally from within F2FS and should
> not call functions that are used by VFS handlers.  This avoids
> certain deadlocks:
> 
> - vfs_create()
>  - f2fs_create() <-- takes an fs_lock
>   - f2fs_add_link()
>    - __f2fs_add_link()
>     - init_inode_metadata()
>      - f2fs_init_security()
>       - security_inode_init_security()
>        - f2fs_initxattrs()
>         - f2fs_setxattr() <-- also takes an fs_lock
> 
> If the caller happens to grab the same fs_lock from the pool in both
> places, they will deadlock.  There are also deadlocks involving
> multiple threads and mutexes:
> 
> - f2fs_write_begin()
>  - f2fs_balance_fs() <-- takes gc_mutex
>   - f2fs_gc()
>    - write_checkpoint()
>     - block_operations()
>      - mutex_lock_all() <-- blocks trying to grab all fs_locks
> 
> - f2fs_mkdir() <-- takes an fs_lock
>  - __f2fs_add_link()
>   - f2fs_init_security()
>    - security_inode_init_security()
>     - f2fs_initxattrs()
>      - f2fs_setxattr()
>       - f2fs_balance_fs() <-- blocks trying to take gc_mutex
> 
> Signed-off-by: Russ Knize <Russ.Knize@motorola.com>

This solution is more thorough.

Reviewed-by: Gu Zheng <guz.fnst@cn.fujitsu.com>

> ---
>  fs/f2fs/xattr.c |   35 +++++++++++++++++++++++++----------
>  1 file changed, 25 insertions(+), 10 deletions(-)
> 
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index 1ac8a5f..3d900ea 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -154,6 +154,9 @@ static int f2fs_xattr_advise_set(struct dentry *dentry, const char *name,
>  }
>  
>  #ifdef CONFIG_F2FS_FS_SECURITY
> +static int __f2fs_setxattr(struct inode *inode, int name_index,
> +			const char *name, const void *value, size_t value_len,
> +			struct page *ipage);
>  static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
>  		void *page)
>  {
> @@ -161,7 +164,7 @@ static int f2fs_initxattrs(struct inode *inode, const struct xattr *xattr_array,
>  	int err = 0;
>  
>  	for (xattr = xattr_array; xattr->name != NULL; xattr++) {
> -		err = f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY,
> +		err = __f2fs_setxattr(inode, F2FS_XATTR_INDEX_SECURITY,
>  				xattr->name, xattr->value,
>  				xattr->value_len, (struct page *)page);
>  		if (err < 0)
> @@ -469,16 +472,15 @@ cleanup:
>  	return error;
>  }
>  
> -int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
> -			const void *value, size_t value_len, struct page *ipage)
> +static int __f2fs_setxattr(struct inode *inode, int name_index,
> +			const char *name, const void *value, size_t value_len,
> +			struct page *ipage)
>  {
> -	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
>  	struct f2fs_inode_info *fi = F2FS_I(inode);
>  	struct f2fs_xattr_entry *here, *last;
>  	void *base_addr;
>  	int found, newsize;
>  	size_t name_len;
> -	int ilock;
>  	__u32 new_hsize;
>  	int error = -ENOMEM;
>  
> @@ -493,10 +495,6 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
>  	if (name_len > F2FS_NAME_LEN || value_len > MAX_VALUE_LEN(inode))
>  		return -ERANGE;
>  
> -	f2fs_balance_fs(sbi);
> -
> -	ilock = mutex_lock_op(sbi);
> -
>  	base_addr = read_all_xattrs(inode, ipage);
>  	if (!base_addr)
>  		goto exit;
> @@ -578,7 +576,24 @@ int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
>  	else
>  		update_inode_page(inode);
>  exit:
> -	mutex_unlock_op(sbi, ilock);
>  	kzfree(base_addr);
>  	return error;
>  }
> +
> +int f2fs_setxattr(struct inode *inode, int name_index, const char *name,
> +			const void *value, size_t value_len, struct page *ipage)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
> +	int ilock;
> +	int err;
> +
> +	f2fs_balance_fs(sbi);
> +
> +	ilock = mutex_lock_op(sbi);
> +
> +	err = __f2fs_setxattr(inode, name_index, name, value, value_len, ipage);
> +
> +	mutex_unlock_op(sbi, ilock);
> +
> +	return err;
> +}



------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60133471&iu=/4140/ostg.clktrk

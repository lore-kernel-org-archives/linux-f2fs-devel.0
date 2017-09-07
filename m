From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH v3] f2fs: avoid race in between read xattr &
 write xattr
Date: Thu, 7 Sep 2017 11:15:39 +0800
Message-ID: <7da703b4-eec1-4af2-f477-ea70a7e1c176@huawei.com>
References: <1504752054-12137-1-git-send-email-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1dpnIA-0004Bm-Hk
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Sep 2017 03:15:46 +0000
Received: from szxga05-in.huawei.com ([45.249.212.191])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1dpnI8-0007fz-VB
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Sep 2017 03:15:46 +0000
In-Reply-To: <1504752054-12137-1-git-send-email-heyunlei@huawei.com>
Content-Language: en-US
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Yunlei He <heyunlei@huawei.com>, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: morgan.wang@huawei.com

On 2017/9/7 10:40, Yunlei He wrote:
> Thread A:					Thread B:
> -f2fs_getxattr
>    -lookup_all_xattrs
>       -xnid = F2FS_I(inode)->i_xattr_nid;
> 						-f2fs_setxattr
> 						    -__f2fs_setxattr
> 						        -write_all_xattrs
> 						            -truncate_xattr_node
> 							          ...  ...
> 						-write_checkpoint
> 								  ...  ...
> 						-alloc_nid   <- nid reuse
>           -get_node_page
>               -f2fs_bug_on  <- nid != node_footer->nid
> 
> It's need a rw_sem to avoid the race
> 
> Signed-off-by: Yunlei He <heyunlei@huawei.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,

> ---
>  fs/f2fs/f2fs.h  | 1 +
>  fs/f2fs/super.c | 1 +
>  fs/f2fs/xattr.c | 6 ++++++
>  3 files changed, 8 insertions(+)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4b99396..12db760 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -589,6 +589,7 @@ struct f2fs_inode_info {
>  	struct extent_tree *extent_tree;	/* cached extent_tree entry */
>  	struct rw_semaphore dio_rwsem[2];/* avoid racing between dio and gc */
>  	struct rw_semaphore i_mmap_sem;
> +	struct rw_semaphore i_xattr_sem; /* avoid racing between reading and changing EAs */
>  
>  	int i_extra_isize;		/* size of extra space located in i_addr */
>  	kprojid_t i_projid;		/* id for project quota */
> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
> index 7730316..89f61eb 100644
> --- a/fs/f2fs/super.c
> +++ b/fs/f2fs/super.c
> @@ -630,6 +630,7 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
>  	init_rwsem(&fi->dio_rwsem[READ]);
>  	init_rwsem(&fi->dio_rwsem[WRITE]);
>  	init_rwsem(&fi->i_mmap_sem);
> +	init_rwsem(&fi->i_xattr_sem);
>  
>  #ifdef CONFIG_QUOTA
>  	memset(&fi->i_dquot, 0, sizeof(fi->i_dquot));
> diff --git a/fs/f2fs/xattr.c b/fs/f2fs/xattr.c
> index ef3a372..7c65540 100644
> --- a/fs/f2fs/xattr.c
> +++ b/fs/f2fs/xattr.c
> @@ -473,8 +473,10 @@ int f2fs_getxattr(struct inode *inode, int index, const char *name,
>  	if (len > F2FS_NAME_LEN)
>  		return -ERANGE;
>  
> +	down_read(&F2FS_I(inode)->i_xattr_sem);
>  	error = lookup_all_xattrs(inode, ipage, index, len, name,
>  				&entry, &base_addr);
> +	up_read(&F2FS_I(inode)->i_xattr_sem);
>  	if (error)
>  		return error;
>  
> @@ -503,7 +505,9 @@ ssize_t f2fs_listxattr(struct dentry *dentry, char *buffer, size_t buffer_size)
>  	int error = 0;
>  	size_t rest = buffer_size;
>  
> +	down_read(&F2FS_I(inode)->i_xattr_sem);
>  	error = read_all_xattrs(inode, NULL, &base_addr);
> +	up_read(&F2FS_I(inode)->i_xattr_sem);
>  	if (error)
>  		return error;
>  
> @@ -686,7 +690,9 @@ int f2fs_setxattr(struct inode *inode, int index, const char *name,
>  	f2fs_lock_op(sbi);
>  	/* protect xattr_ver */
>  	down_write(&F2FS_I(inode)->i_sem);
> +	down_write(&F2FS_I(inode)->i_xattr_sem);
>  	err = __f2fs_setxattr(inode, index, name, value, size, ipage, flags);
> +	up_write(&F2FS_I(inode)->i_xattr_sem);
>  	up_write(&F2FS_I(inode)->i_sem);
>  	f2fs_unlock_op(sbi);
>  
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

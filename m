From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v3] f2fs: add fast symlink support
Date: Mon, 16 Mar 2015 23:09:57 +0000
Message-ID: <20150316230957.GB15296@kernel>
References: <1426228419-11183-1-git-send-email-wanpeng.li@linux.intel.com>
 <002d01d05fe9$ba235200$2e69f600$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <002d01d05fe9$ba235200$2e69f600$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,
On Mon, Mar 16, 2015 at 09:03:30PM +0800, Chao Yu wrote:
>Hi Wanpeng, Jaegeuk,
>
>> -----Original Message-----
>> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
>> Sent: Friday, March 13, 2015 2:34 PM
>> To: Jaegeuk Kim
>> Cc: Changman Lee; Chao Yu; linux-f2fs-devel@lists.sourceforge.net;
>> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org; Wanpeng Li
>> Subject: [PATCH v3] f2fs: add fast symlink support
>> 
>> This patch introduces the improvement fast symlinks to allow storage of
>> the target path within inode, thus symlinks with short target paths are
>> more accessed quickly. It will fall back to using the original slow
>> symlink if the target path exceeds the available inode space.
>> 
>> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>> ---
>> v2 -> v3:
>>  * handle fast symlink in remove_inode_page
>> v1 -> v2:
>>  * set max size of fast symlink according to inline_xattr flag
>> 
>>  fs/f2fs/f2fs.h          | 15 ++++++++++++++
>>  fs/f2fs/file.c          |  2 ++
>>  fs/f2fs/inode.c         |  9 +++++++--
>>  fs/f2fs/namei.c         | 53 +++++++++++++++++++++++++++++++++++++++++++++----
>>  fs/f2fs/node.c          |  5 +++--
>>  include/linux/f2fs_fs.h |  2 ++
>>  6 files changed, 78 insertions(+), 8 deletions(-)
>> 
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index 511d6cd..3012ea0 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -1226,6 +1226,7 @@ enum {
>>  	FI_VOLATILE_FILE,	/* indicate volatile file */
>>  	FI_DROP_CACHE,		/* drop dirty page cache */
>>  	FI_DATA_EXIST,		/* indicate data exists */
>> +	FI_FAST_SYMLINK,        /* indicate fast symlink */
>>  };
>> 
>>  static inline void set_inode_flag(struct f2fs_inode_info *fi, int flag)
>> @@ -1262,6 +1263,8 @@ static inline void get_inline_info(struct f2fs_inode_info *fi,
>>  		set_inode_flag(fi, FI_INLINE_DENTRY);
>>  	if (ri->i_inline & F2FS_DATA_EXIST)
>>  		set_inode_flag(fi, FI_DATA_EXIST);
>> +	if (ri->i_inline & F2FS_FAST_SYMLINK)
>> +		set_inode_flag(fi, FI_FAST_SYMLINK);
>>  }
>> 
>>  static inline void set_raw_inline(struct f2fs_inode_info *fi,
>> @@ -1277,6 +1280,8 @@ static inline void set_raw_inline(struct f2fs_inode_info *fi,
>>  		ri->i_inline |= F2FS_INLINE_DENTRY;
>>  	if (is_inode_flag_set(fi, FI_DATA_EXIST))
>>  		ri->i_inline |= F2FS_DATA_EXIST;
>> +	if (is_inode_flag_set(fi, FI_FAST_SYMLINK))
>> +		ri->i_inline |= F2FS_FAST_SYMLINK;
>>  }
>> 
>>  static inline int f2fs_has_inline_xattr(struct inode *inode)
>> @@ -1370,6 +1375,15 @@ static inline void f2fs_stop_checkpoint(struct f2fs_sb_info *sbi)
>>  	sbi->sb->s_flags |= MS_RDONLY;
>>  }
>> 
>> +/*
>> + * Test whether an inode is a fast symlink.
>> + */
>> +static inline int f2fs_inode_is_fast_symlink(struct inode *inode)
>> +{
>> +	return (S_ISLNK(inode->i_mode) &&
>> +			is_inode_flag_set(F2FS_I(inode), FI_FAST_SYMLINK));
>
>Look at this again, it seems that it's not necessary to introduce FI_FAST_SYMLINK
>& F2FS_FAST_SYNLINK as we waste one bit in i_inline flag, for fast symlink, using
>your original design will be enough until we consider xattr node block case.
>
>static inline int f2fs_inode_is_fast_symlink(struct inode *inode)
>{
>	return (S_ISLNK(inode->i_mode) && !F2FS_HAS_BLOCKS(inode));
>}
>
>Wanpeng, how about waiting for Jaegeuk's opinion?
>
>> +}
>> +
>>  #define get_inode_mode(i) \
>>  	((is_inode_flag_set(F2FS_I(i), FI_ACL_MODE)) ? \
>>  	 (F2FS_I(i)->i_acl_mode) : ((i)->i_mode))
>> @@ -1746,6 +1760,7 @@ extern const struct address_space_operations f2fs_node_aops;
>>  extern const struct address_space_operations f2fs_meta_aops;
>>  extern const struct inode_operations f2fs_dir_inode_operations;
>>  extern const struct inode_operations f2fs_symlink_inode_operations;
>> +extern const struct inode_operations f2fs_fast_symlink_inode_operations;
>>  extern const struct inode_operations f2fs_special_inode_operations;
>>  extern struct kmem_cache *inode_entry_slab;
>> 
>> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
>> index f1341c7..05a3d4f 100644
>> --- a/fs/f2fs/file.c
>> +++ b/fs/f2fs/file.c
>> @@ -546,6 +546,8 @@ void f2fs_truncate(struct inode *inode)
>>  	if (!(S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>>  				S_ISLNK(inode->i_mode)))
>>  		return;
>> +	if (f2fs_inode_is_fast_symlink(inode))
>> +		return;
>> 
>>  	trace_f2fs_truncate(inode);
>> 
>> diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
>> index b508744..ec9ad22 100644
>> --- a/fs/f2fs/inode.c
>> +++ b/fs/f2fs/inode.c
>> @@ -13,6 +13,7 @@
>>  #include <linux/buffer_head.h>
>>  #include <linux/writeback.h>
>>  #include <linux/bitops.h>
>> +#include <linux/namei.h>
>> 
>>  #include "f2fs.h"
>>  #include "node.h"
>> @@ -188,8 +189,12 @@ make_now:
>>  		inode->i_mapping->a_ops = &f2fs_dblock_aops;
>>  		mapping_set_gfp_mask(inode->i_mapping, GFP_F2FS_HIGH_ZERO);
>>  	} else if (S_ISLNK(inode->i_mode)) {
>> -		inode->i_op = &f2fs_symlink_inode_operations;
>> -		inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> +		if (f2fs_inode_is_fast_symlink(inode))
>> +			inode->i_op = &f2fs_fast_symlink_inode_operations;
>> +		else {
>> +			inode->i_op = &f2fs_symlink_inode_operations;
>> +			inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> +		}
>>  	} else if (S_ISCHR(inode->i_mode) || S_ISBLK(inode->i_mode) ||
>>  			S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode)) {
>>  		inode->i_op = &f2fs_special_inode_operations;
>> diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
>> index 1e2ae21..0619909 100644
>> --- a/fs/f2fs/namei.c
>> +++ b/fs/f2fs/namei.c
>> @@ -14,6 +14,7 @@
>>  #include <linux/sched.h>
>>  #include <linux/ctype.h>
>>  #include <linux/dcache.h>
>> +#include <linux/namei.h>
>> 
>>  #include "f2fs.h"
>>  #include "node.h"
>> @@ -247,6 +248,21 @@ fail:
>>  	return err;
>>  }
>> 
>> +static void *f2fs_follow_link(struct dentry *dentry, struct nameidata *nd)
>> +{
>> +	struct page *node_page;
>> +
>> +	node_page = get_node_page(F2FS_I_SB(dentry->d_inode),
>> +				dentry->d_inode->i_ino);
>> +	if (IS_ERR(node_page)) {
>> +		nd_set_link(nd, NULL);
>> +		return NULL;
>> +	}
>> +	nd_set_link(nd, (char *)(F2FS_INODE(node_page)->i_addr));
>> +	f2fs_put_page(node_page, 1);
>> +	return NULL;
>> +}
>
>The only different of i_op for fast symlink and normal symlink is that
>we use different callback function for ->follow_link, if we merge
>page_follow_link_light & f2fs_follow_link into one, we can remove duplicated
>f2fs_fast_symlink_inode_operations. How do you think of it?

I found that ext2/3/4 do the same as mine. ;-)

Regards,
Wanpeng Li 

>
>> +
>>  static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>>  					const char *symname)
>>  {
>> @@ -261,16 +277,31 @@ static int f2fs_symlink(struct inode *dir, struct dentry *dentry,
>>  	if (IS_ERR(inode))
>>  		return PTR_ERR(inode);
>> 
>> -	inode->i_op = &f2fs_symlink_inode_operations;
>> -	inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> -
>>  	f2fs_lock_op(sbi);
>>  	err = f2fs_add_link(dentry, inode);
>>  	if (err)
>>  		goto out;
>>  	f2fs_unlock_op(sbi);
>> 
>> -	err = page_symlink(inode, symname, symlen);
>> +
>> +	if (symlen > MAX_FAST_SYMLINK_SIZE) {
>
>I think we should be pick up max_fast_symlink_size which is introduced in v2.
>
>> +		/* slow symlink */
>> +		inode->i_op = &f2fs_symlink_inode_operations;
>> +		inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> +		err = page_symlink(inode, symname, symlen);
>> +	} else {
>> +		/* fast symlink */
>> +		struct page *node_page;
>> +
>> +		inode->i_op = &f2fs_fast_symlink_inode_operations;
>> +		node_page = get_node_page(sbi, inode->i_ino);
>> +		memcpy((char *)&F2FS_INODE(node_page)->i_addr, symname, symlen);
>> +		set_page_dirty(node_page);
>> +		f2fs_put_page(node_page, 1);
>> +		inode->i_size = symlen-1;
>
>trivial coding style issue.
>inode->i_size = symlen - 1;
>
>Thanks,
>
>> +		set_inode_flag(F2FS_I(inode), FI_FAST_SYMLINK);
>> +		mark_inode_dirty(inode);
>> +	}
>>  	alloc_nid_done(sbi, inode->i_ino);
>> 
>>  	d_instantiate(dentry, inode);
>> @@ -743,6 +774,20 @@ const struct inode_operations f2fs_symlink_inode_operations = {
>>  #endif
>>  };
>> 
>> +const struct inode_operations f2fs_fast_symlink_inode_operations = {
>> +	.readlink       = generic_readlink,
>> +	.follow_link    = f2fs_follow_link,
>> +	.put_link       = page_put_link,
>> +	.getattr	= f2fs_getattr,
>> +	.setattr	= f2fs_setattr,
>> +#ifdef CONFIG_F2FS_FS_XATTR
>> +	.setxattr	= generic_setxattr,
>> +	.getxattr	= generic_getxattr,
>> +	.listxattr	= f2fs_listxattr,
>> +	.removexattr	= generic_removexattr,
>> +#endif
>> +};
>> +
>>  const struct inode_operations f2fs_special_inode_operations = {
>>  	.getattr	= f2fs_getattr,
>>  	.setattr        = f2fs_setattr,
>> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> index 35a9117..efe28a2b 100644
>> --- a/fs/f2fs/node.c
>> +++ b/fs/f2fs/node.c
>> @@ -908,8 +908,9 @@ void remove_inode_page(struct inode *inode)
>>  	}
>> 
>>  	/* remove potential inline_data blocks */
>> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>> -				S_ISLNK(inode->i_mode))
>> +	if ((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>> +				S_ISLNK(inode->i_mode)) &&
>> +				!f2fs_inode_is_fast_symlink(inode))
>>  		truncate_data_blocks_range(&dn, 1);
>> 
>>  	/* 0 is possible, after f2fs_new_inode() has failed */
>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> index 502f28c..834880c 100644
>> --- a/include/linux/f2fs_fs.h
>> +++ b/include/linux/f2fs_fs.h
>> @@ -178,9 +178,11 @@ struct f2fs_extent {
>>  #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
>>  #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
>>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>> +#define F2FS_FAST_SYMLINK	0x10    /* file fast symlink flag */
>> 
>>  #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
>>  						F2FS_INLINE_XATTR_ADDRS - 1))
>> +#define MAX_FAST_SYMLINK_SIZE (MAX_INLINE_DATA + 1)
>> 
>>  struct f2fs_inode {
>>  	__le16 i_mode;			/* file mode */
>> --
>> 1.9.1

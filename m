From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v3] f2fs: add fast symlink support
Date: Wed, 18 Mar 2015 16:58:52 +0800
Message-ID: <20150318085851.GA2863@kernel>
References: <1426228419-11183-1-git-send-email-wanpeng.li@linux.intel.com>
	<20150317172127.GA745@jaegeuk-mac02>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <wanpeng.li@linux.intel.com>) id 1YYA63-0001Iv-2P
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Mar 2015 09:17:03 +0000
Received: from mga14.intel.com ([192.55.52.115])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YYA61-0006A5-PI for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 18 Mar 2015 09:17:03 +0000
Content-Disposition: inline
In-Reply-To: <20150317172127.GA745@jaegeuk-mac02>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,
On Tue, Mar 17, 2015 at 10:21:27AM -0700, Jaegeuk Kim wrote:
>> -	err = page_symlink(inode, symname, symlen);
>> +
>> +	if (symlen > MAX_FAST_SYMLINK_SIZE) {
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
>
>This is mostly likewise the inline_data flow.
>As of now, I can't recommend using any i_addr region, since we need to handle
>many cases such as truncation, roll-forward recovery, and fsck/dump tools.
>
>It is more sensible to enable inline_data by default, isn't it?

Do you mean to replace the codes above by something like
f2fs_write_inline_data()?

Regards,
Wanpeng Li 

>
>Thanks,
>
>> +		set_page_dirty(node_page);
>> +		f2fs_put_page(node_page, 1);
>> +		inode->i_size = symlen-1;
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

------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/

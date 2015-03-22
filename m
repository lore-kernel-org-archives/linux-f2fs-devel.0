From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v3] f2fs: add fast symlink support
Date: Mon, 23 Mar 2015 07:10:15 +0800
Message-ID: <20150322231015.GA19526@kernel>
References: <1426228419-11183-1-git-send-email-wanpeng.li@linux.intel.com>
 <20150317172127.GA745@jaegeuk-mac02>
 <20150318085851.GA2863@kernel>
 <20150318180528.GD7461@jaegeuk-mac02>
 <20150318230217.GA5374@kernel>
 <008701d061f3$55a0e7a0$00e2b6e0$@samsung.com>
 <20150320190501.GA19413@jaegeuk-mac02.mot.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150320190501.GA19413@jaegeuk-mac02.mot.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <chao2.yu@samsung.com>, 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Jaegeuk,
On Fri, Mar 20, 2015 at 01:13:39PM -0700, Jaegeuk Kim wrote:
>Hi Wanpeng,
>
>The Chao's patch is what I intended.
>
>Could anyone of you enhance that patch?
>If we use inline_data by default, we need another option to disable it.
>Like "noinline_data"?

Will do, thanks for you and Chao's help.

Regards,
Wanpeng Li 

>
>Thanks,
>
>On Thu, Mar 19, 2015 at 11:17:17AM +0800, Chao Yu wrote:
>> Hi Wanpeng,
>> 
>> > -----Original Message-----
>> > From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
>> > Sent: Thursday, March 19, 2015 7:02 AM
>> > To: Jaegeuk Kim
>> > Cc: Wanpeng Li; Changman Lee; Chao Yu; linux-f2fs-devel@lists.sourceforge.net;
>> > linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
>> > Subject: Re: [PATCH v3] f2fs: add fast symlink support
>> > 
>> > Hi Jaegeuk,
>> > On Wed, Mar 18, 2015 at 11:05:28AM -0700, Jaegeuk Kim wrote:
>> > >Hi,
>> > >
>> > >On Wed, Mar 18, 2015 at 04:58:52PM +0800, Wanpeng Li wrote:
>> > >> Hi Jaegeuk,
>> > >> On Tue, Mar 17, 2015 at 10:21:27AM -0700, Jaegeuk Kim wrote:
>> > >> >> -	err = page_symlink(inode, symname, symlen);
>> > >> >> +
>> > >> >> +	if (symlen > MAX_FAST_SYMLINK_SIZE) {
>> > >> >> +		/* slow symlink */
>> > >> >> +		inode->i_op = &f2fs_symlink_inode_operations;
>> > >> >> +		inode->i_mapping->a_ops = &f2fs_dblock_aops;
>> > >> >> +		err = page_symlink(inode, symname, symlen);
>> > >> >> +	} else {
>> > >> >> +		/* fast symlink */
>> > >> >> +		struct page *node_page;
>> > >> >> +
>> > >> >> +		inode->i_op = &f2fs_fast_symlink_inode_operations;
>> > >> >> +		node_page = get_node_page(sbi, inode->i_ino);
>> > >> >> +		memcpy((char *)&F2FS_INODE(node_page)->i_addr, symname, symlen);
>> > >> >
>> > >> >This is mostly likewise the inline_data flow.
>> > >> >As of now, I can't recommend using any i_addr region, since we need to handle
>> > >> >many cases such as truncation, roll-forward recovery, and fsck/dump tools.
>> > >> >
>> > >> >It is more sensible to enable inline_data by default, isn't it?
>> > >>
>> > >> Do you mean to replace the codes above by something like
>> > >> f2fs_write_inline_data()?
>> > >
>> > >I meant the mount option, inline_data.
>> > >Currently, f2fs doesn't set that option at mount time, but I thought that we
>> > >can set it by default since it becomes stable.
>> > 
>> > So I think you mean my codes should memcpy i_addr[1~872] instead of i_addr[0~872], right?
>> 
>> I think what Jaegeuk means is that we can use inline_data in f2fs by default with
>> patch like below firstly:
>> 
>> >From a7320bfe94239ea4ceb193621a3a1a4d11a40d07 Mon Sep 17 00:00:00 2001
>> From: Chao Yu <chao2.yu@samsung.com>
>> Date: Thu, 19 Mar 2015 10:02:08 +0800
>> Subject: [PATCH] f2fs: use inline_data by default
>> 
>> Use inline_data feature by default since it brings us better performance & space
>> utilization and now it is already stable.
>> 
>> Suggested-by: Jaegeuk Kim <jaegeuk@kernel.org>
>> Signed-off-by: Chao Yu <chao2.yu@samsung.com>
>> Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>> ---
>>  fs/f2fs/super.c | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index fc6857f..8772d91 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -991,6 +991,7 @@ try_onemore:
>>  	sbi->active_logs = NR_CURSEG_TYPE;
>>  
>>  	set_opt(sbi, BG_GC);
>> +	set_opt(sbi, INLINE_DATA);
>>  
>>  #ifdef CONFIG_F2FS_FS_XATTR
>>  	set_opt(sbi, XATTR_USER);
>> -- 
>> 2.3.1
>> 
>> Then we enable inline_data feature for symlink in f2fs_may_inline, after that
>> by default our symlink created has inline_data flag in it, we treat small size
>> symlink as an inline regular file, we can write its data page which is written
>> in page_symlink into inode page like normal inline data procedure.
>> 
>> Thanks,
>> 
>> > 
>> > Regards,
>> > Wanpeng Li
>> > 
>> > >
>> > >Thanks,
>> > >
>> > >>
>> > >> Regards,
>> > >> Wanpeng Li
>> > >>
>> > >> >
>> > >> >Thanks,
>> > >> >
>> > >> >> +		set_page_dirty(node_page);
>> > >> >> +		f2fs_put_page(node_page, 1);
>> > >> >> +		inode->i_size = symlen-1;
>> > >> >> +		set_inode_flag(F2FS_I(inode), FI_FAST_SYMLINK);
>> > >> >> +		mark_inode_dirty(inode);
>> > >> >> +	}
>> > >> >>  	alloc_nid_done(sbi, inode->i_ino);
>> > >> >>
>> > >> >>  	d_instantiate(dentry, inode);
>> > >> >> @@ -743,6 +774,20 @@ const struct inode_operations f2fs_symlink_inode_operations = {
>> > >> >>  #endif
>> > >> >>  };
>> > >> >>
>> > >> >> +const struct inode_operations f2fs_fast_symlink_inode_operations = {
>> > >> >> +	.readlink       = generic_readlink,
>> > >> >> +	.follow_link    = f2fs_follow_link,
>> > >> >> +	.put_link       = page_put_link,
>> > >> >> +	.getattr	= f2fs_getattr,
>> > >> >> +	.setattr	= f2fs_setattr,
>> > >> >> +#ifdef CONFIG_F2FS_FS_XATTR
>> > >> >> +	.setxattr	= generic_setxattr,
>> > >> >> +	.getxattr	= generic_getxattr,
>> > >> >> +	.listxattr	= f2fs_listxattr,
>> > >> >> +	.removexattr	= generic_removexattr,
>> > >> >> +#endif
>> > >> >> +};
>> > >> >> +
>> > >> >>  const struct inode_operations f2fs_special_inode_operations = {
>> > >> >>  	.getattr	= f2fs_getattr,
>> > >> >>  	.setattr        = f2fs_setattr,
>> > >> >> diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
>> > >> >> index 35a9117..efe28a2b 100644
>> > >> >> --- a/fs/f2fs/node.c
>> > >> >> +++ b/fs/f2fs/node.c
>> > >> >> @@ -908,8 +908,9 @@ void remove_inode_page(struct inode *inode)
>> > >> >>  	}
>> > >> >>
>> > >> >>  	/* remove potential inline_data blocks */
>> > >> >> -	if (S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>> > >> >> -				S_ISLNK(inode->i_mode))
>> > >> >> +	if ((S_ISREG(inode->i_mode) || S_ISDIR(inode->i_mode) ||
>> > >> >> +				S_ISLNK(inode->i_mode)) &&
>> > >> >> +				!f2fs_inode_is_fast_symlink(inode))
>> > >> >>  		truncate_data_blocks_range(&dn, 1);
>> > >> >>
>> > >> >>  	/* 0 is possible, after f2fs_new_inode() has failed */
>> > >> >> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>> > >> >> index 502f28c..834880c 100644
>> > >> >> --- a/include/linux/f2fs_fs.h
>> > >> >> +++ b/include/linux/f2fs_fs.h
>> > >> >> @@ -178,9 +178,11 @@ struct f2fs_extent {
>> > >> >>  #define F2FS_INLINE_DATA	0x02	/* file inline data flag */
>> > >> >>  #define F2FS_INLINE_DENTRY	0x04	/* file inline dentry flag */
>> > >> >>  #define F2FS_DATA_EXIST		0x08	/* file inline data exist flag */
>> > >> >> +#define F2FS_FAST_SYMLINK	0x10    /* file fast symlink flag */
>> > >> >>
>> > >> >>  #define MAX_INLINE_DATA		(sizeof(__le32) * (DEF_ADDRS_PER_INODE - \
>> > >> >>  						F2FS_INLINE_XATTR_ADDRS - 1))
>> > >> >> +#define MAX_FAST_SYMLINK_SIZE (MAX_INLINE_DATA + 1)
>> > >> >>
>> > >> >>  struct f2fs_inode {
>> > >> >>  	__le16 i_mode;			/* file mode */
>> > >> >> --
>> > >> >> 1.9.1

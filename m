From: Sheng Yong <shengyong1@huawei.com>
Subject: Re: [RFC PATCH 2/2] f2fs: introduce lost+found feature
Date: Fri, 9 Feb 2018 11:22:29 +0800
Message-ID: <ccf9607a-4aba-6623-9115-52fd11b456ce@huawei.com>
References: <20180206043118.134137-1-shengyong1@huawei.com>
 <20180206043118.134137-3-shengyong1@huawei.com>
 <e13a93f2-9873-a7f4-1d57-62f9388215d3@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-4.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1ejzH7-0000DN-FA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:22:57 +0000
Received: from [45.249.212.32] (helo=huawei.com)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ejzH6-0000su-9S
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Feb 2018 03:22:57 +0000
In-Reply-To: <e13a93f2-9873-a7f4-1d57-62f9388215d3@kernel.org>
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
To: Chao Yu <chao@kernel.org>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, heyunlei@huawei.com, linux-f2fs-devel@lists.sourceforge.net

Hi, Chao

On 2018/2/8 21:29, Chao Yu wrote:
> On 2018/2/6 12:31, Sheng Yong wrote:
>> Introduce lost+found feature. The lost+found is a directory which saves
> 
> Nitpick, lost_found feature...
> 
> Needs to add /sys/fs/f2fs/features/lost_found sysfs entry, and show
> 'lost_found' in /sys/fs/f2fs/<dev>/features.

I will add this sysfs entry in the next version :)

Thanks,
Sheng
> 
> Thanks,
> 
>> unreachable files. If f2fsck finds a file which has no parent, or the
>> parent is removed by f2fsck, the file will be placed in lost+found
>> directory.
>>
>> According fscrypt policy, lost+found could not be encrypted. As a
>> result, the root directory cannot be encrypted. So if lost+found
>> feature is enabled, let's avoid to encrypt root directory.
>>
>> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
>> ---
>>   fs/f2fs/f2fs.h  |  2 ++
>>   fs/f2fs/super.c | 12 ++++++++++++
>>   2 files changed, 14 insertions(+)
>>
>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>> index a60d56a96f9b..d9c9be6ea5d5 100644
>> --- a/fs/f2fs/f2fs.h
>> +++ b/fs/f2fs/f2fs.h
>> @@ -125,6 +125,7 @@ struct f2fs_mount_info {
>>   #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
>>   #define F2FS_FEATURE_QUOTA_INO		0x0080
>>   #define F2FS_FEATURE_INODE_CRTIME	0x0100
>> +#define F2FS_FEATURE_LOST_FOUND		0x0200
>>   
>>   #define F2FS_HAS_FEATURE(sb, mask)					\
>>   	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
>> @@ -3186,6 +3187,7 @@ F2FS_FEATURE_FUNCS(inode_chksum, INODE_CHKSUM);
>>   F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBLE_INLINE_XATTR);
>>   F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
>>   F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
>> +F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>   
>>   #ifdef CONFIG_BLK_DEV_ZONED
>>   static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>> index b39ab55ab1b5..5f536e878d21 100644
>> --- a/fs/f2fs/super.c
>> +++ b/fs/f2fs/super.c
>> @@ -1797,6 +1797,18 @@ static int f2fs_get_context(struct inode *inode, void *ctx, size_t len)
>>   static int f2fs_set_context(struct inode *inode, const void *ctx, size_t len,
>>   							void *fs_data)
>>   {
>> +	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
>> +
>> +	/*
>> +	 * Encrypting the root directory is not allowed because f2fsck
>> +	 * expects lost+found directory to exist and remain unencrypted
>> +	 * if LOST_FOUND feature is enabled.
>> +	 *
>> +	 */
>> +	if (f2fs_sb_has_lost_found(sbi->sb) &&
>> +			inode->i_ino == F2FS_ROOT_INO(sbi))
>> +		return -EPERM;
>> +
>>   	return f2fs_setxattr(inode, F2FS_XATTR_INDEX_ENCRYPTION,
>>   				F2FS_XATTR_NAME_ENCRYPTION_CONTEXT,
>>   				ctx, len, fs_data, XATTR_CREATE);
>>
> 
> .
> 


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

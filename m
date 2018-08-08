From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH v3 1/3] f2fs: support superblock checksum
Date: Wed, 8 Aug 2018 20:24:59 +0800
Message-ID: <0d7dbbd2-d94a-ccf8-7ef9-80086cf0af7d@kernel.org>
References: <20180808102750.102971-1-zhengjunling@huawei.com>
 <772d31d6-3cfe-d7e2-af18-eb023c73aee9@kernel.org>
 <df6895b0-d94c-e5a5-82e2-2f8e5439d0b3@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fnNWi-0007xQ-AD
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 12:25:20 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fnNWg-00BtFU-Fq
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 12:25:20 +0000
In-Reply-To: <df6895b0-d94c-e5a5-82e2-2f8e5439d0b3@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org, yuchao0@huawei.com
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/8 20:21, Junling Zheng wrote:
> On 2018/8/8 20:03, Chao Yu wrote:
>> On 2018/8/8 18:27, Junling Zheng wrote:
>>> Now we support crc32 checksum for superblock.
>>>
>>> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
>>> ---
>>> v2 -> v3:
>>>  - add sysfs entry for superblock checksum.
>>>  - move the crc checking to the beginning of sanity_check_raw_super().
>>>  - fix the NULL pointer dereference as sb->s_fs_info hasn't be set yet =
in
>>>    sanity_check_raw_super().
>>> v1 -> v2:
>>>  - fix to switch endian of crc.
>>>  fs/f2fs/f2fs.h          |  2 ++
>>>  fs/f2fs/super.c         | 29 +++++++++++++++++++++++++++++
>>>  fs/f2fs/sysfs.c         |  7 +++++++
>>>  include/linux/f2fs_fs.h |  3 ++-
>>>  4 files changed, 40 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
>>> index 4525f4f82af0..d50d6efda96b 100644
>>> --- a/fs/f2fs/f2fs.h
>>> +++ b/fs/f2fs/f2fs.h
>>> @@ -147,6 +147,7 @@ struct f2fs_mount_info {
>>>  #define F2FS_FEATURE_INODE_CRTIME	0x0100
>>>  #define F2FS_FEATURE_LOST_FOUND		0x0200
>>>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
>>> +#define F2FS_FEATURE_SB_CHKSUM		0x0800
>>>  =

>>>  #define F2FS_HAS_FEATURE(sb, mask)					\
>>>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) !=3D 0)
>>> @@ -3376,6 +3377,7 @@ F2FS_FEATURE_FUNCS(flexible_inline_xattr, FLEXIBL=
E_INLINE_XATTR);
>>>  F2FS_FEATURE_FUNCS(quota_ino, QUOTA_INO);
>>>  F2FS_FEATURE_FUNCS(inode_crtime, INODE_CRTIME);
>>>  F2FS_FEATURE_FUNCS(lost_found, LOST_FOUND);
>>> +F2FS_FEATURE_FUNCS(sb_chksum, SB_CHKSUM);
>>>  =

>>>  #ifdef CONFIG_BLK_DEV_ZONED
>>>  static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>>> diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
>>> index bd57be470e23..c3dbafa31613 100644
>>> --- a/fs/f2fs/super.c
>>> +++ b/fs/f2fs/super.c
>>> @@ -2149,6 +2149,26 @@ static int sanity_check_raw_super(struct f2fs_sb=
_info *sbi,
>>>  					(bh->b_data + F2FS_SUPER_OFFSET);
>>>  	struct super_block *sb =3D sbi->sb;
>>>  	unsigned int blocksize;
>>> +	size_t crc_offset =3D 0;
>>> +	__u32 crc =3D 0;
>>> +
>>> +	/* Check checksum_offset and crc in superblock */
>>> +	if (le32_to_cpu(raw_super->feature) & F2FS_FEATURE_SB_CHKSUM) {
>>> +		crc_offset =3D le32_to_cpu(raw_super->checksum_offset);
>>> +		if (crc_offset !=3D
>>> +			offsetof(struct f2fs_super_block, crc)) {
>>> +			f2fs_msg(sb, KERN_INFO,
>>> +				"Invalid SB checksum offset: %lu",
>>
>> warning: format =91%lu=92 expects argument of type =91long unsigned int=
=92, but argument
>> 4 has type =91size_t=92 [-Wformat=3D]
>>      crc_offset);
>>
> =

> :( sorry, I'll send a v4 patch.
> =

>> Otherwise, it looks good to me, you can add in next version:
>>
>> Reviewed-by: Chao Yu <yuchao0@huawei.com>
>>
>> Thanks,
>>
>>> +				crc_offset);
>>> +			return 1;
>>> +		}
>>> +		crc =3D le32_to_cpu(raw_super->crc);
>>> +		if (!f2fs_crc_valid(sbi, crc, raw_super, crc_offset)) {
>>> +			f2fs_msg(sb, KERN_INFO,
>>> +				"Invalid SB checksum value: %u", crc);
>>> +			return 1;
>>> +		}
>>> +	}
>>>  =

>>>  	if (F2FS_SUPER_MAGIC !=3D le32_to_cpu(raw_super->magic)) {
>>>  		f2fs_msg(sb, KERN_INFO,
>>> @@ -2568,6 +2588,7 @@ static int read_raw_super_block(struct f2fs_sb_in=
fo *sbi,
>>>  int f2fs_commit_super(struct f2fs_sb_info *sbi, bool recover)
>>>  {
>>>  	struct buffer_head *bh;
>>> +	__u32 crc =3D 0;
>>>  	int err;
>>>  =

>>>  	if ((recover && f2fs_readonly(sbi->sb)) ||
>>> @@ -2576,6 +2597,14 @@ int f2fs_commit_super(struct f2fs_sb_info *sbi, =
bool recover)
>>>  		return -EROFS;
>>>  	}
>>>  =

>>> +	/* we should update superblock crc here */
>>> +	if (!recover &&
>>> +		F2FS_HAS_FEATURE(sbi->sb, F2FS_FEATURE_SB_CHKSUM)) {

Can we change to use f2fs_sb_has_sb_chksum()?

Thanks,

>>> +		crc =3D f2fs_crc32(sbi, F2FS_RAW_SUPER(sbi),
>>> +				offsetof(struct f2fs_super_block, crc));
>>> +		F2FS_RAW_SUPER(sbi)->crc =3D cpu_to_le32(crc);
>>> +	}
>>> +
>>>  	/* write back-up superblock first */
>>>  	bh =3D sb_bread(sbi->sb, sbi->valid_super_block ? 0 : 1);
>>>  	if (!bh)
>>> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
>>> index cd2e030e47b8..c86d91be6c48 100644
>>> --- a/fs/f2fs/sysfs.c
>>> +++ b/fs/f2fs/sysfs.c
>>> @@ -120,6 +120,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>>>  	if (f2fs_sb_has_lost_found(sb))
>>>  		len +=3D snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>>>  				len ? ", " : "", "lost_found");
>>> +	if (f2fs_sb_has_sb_chksum(sb))
>>> +		len +=3D snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>>> +				len ? ", " : "", "sb_checksum");
>>>  	len +=3D snprintf(buf + len, PAGE_SIZE - len, "\n");
>>>  	return len;
>>>  }
>>> @@ -337,6 +340,7 @@ enum feat_id {
>>>  	FEAT_QUOTA_INO,
>>>  	FEAT_INODE_CRTIME,
>>>  	FEAT_LOST_FOUND,
>>> +	FEAT_SB_CHECKSUM,
>>>  };
>>>  =

>>>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>>> @@ -353,6 +357,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *=
a,
>>>  	case FEAT_QUOTA_INO:
>>>  	case FEAT_INODE_CRTIME:
>>>  	case FEAT_LOST_FOUND:
>>> +	case FEAT_SB_CHECKSUM:
>>>  		return snprintf(buf, PAGE_SIZE, "supported\n");
>>>  	}
>>>  	return 0;
>>> @@ -433,6 +438,7 @@ F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FL=
EXIBLE_INLINE_XATTR);
>>>  F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
>>>  F2FS_FEATURE_RO_ATTR(inode_crtime, FEAT_INODE_CRTIME);
>>>  F2FS_FEATURE_RO_ATTR(lost_found, FEAT_LOST_FOUND);
>>> +F2FS_FEATURE_RO_ATTR(sb_checksum, FEAT_SB_CHECKSUM);
>>>  =

>>>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>>>  static struct attribute *f2fs_attrs[] =3D {
>>> @@ -489,6 +495,7 @@ static struct attribute *f2fs_feat_attrs[] =3D {
>>>  	ATTR_LIST(quota_ino),
>>>  	ATTR_LIST(inode_crtime),
>>>  	ATTR_LIST(lost_found),
>>> +	ATTR_LIST(sb_checksum),
>>>  	NULL,
>>>  };
>>>  =

>>> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
>>> index f70f8ac9c4f4..aa4b586569c1 100644
>>> --- a/include/linux/f2fs_fs.h
>>> +++ b/include/linux/f2fs_fs.h
>>> @@ -112,7 +112,8 @@ struct f2fs_super_block {
>>>  	struct f2fs_device devs[MAX_DEVICES];	/* device list */
>>>  	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
>>>  	__u8 hot_ext_count;		/* # of hot file extension */
>>> -	__u8 reserved[314];		/* valid reserved region */
>>> +	__u8 reserved[310];		/* valid reserved region */
>>> +	__le32 crc;			/* checksum of superblock */
>>>  } __packed;
>>>  =

>>>  /*
>>>
>>
>> .
>>
> =

> =


---------------------------------------------------------------------------=
---
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

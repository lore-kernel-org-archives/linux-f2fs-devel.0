From: Chao Yu <chao@kernel.org>
Subject: Re: [PATCH 1/2] f2fs: add quota_ino feature infra
Date: Thu, 2 Nov 2017 22:25:51 +0800
Message-ID: <cfead5a1-8cd9-19e6-0b4a-fa0e9208a630@kernel.org>
References: <20171031034030.26719-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <chao@kernel.org>) id 1eAGSu-0007FC-MX
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 14:27:28 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1eAGSo-0005fE-Uf
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Nov 2017 14:27:28 +0000
In-Reply-To: <20171031034030.26719-1-jaegeuk@kernel.org>
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
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/10/31 11:40, Jaegeuk Kim wrote:
> This patch adds quota_ino feature infra to be used for quota files.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

> ---
>  fs/f2fs/f2fs.h          | 6 ++++++
>  fs/f2fs/sysfs.c         | 7 +++++++
>  include/linux/f2fs_fs.h | 6 +++++-
>  3 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
> index 4a75f07f1dc8..9a1c7ffa6845 100644
> --- a/fs/f2fs/f2fs.h
> +++ b/fs/f2fs/f2fs.h
> @@ -122,6 +122,7 @@ struct f2fs_mount_info {
>  #define F2FS_FEATURE_PRJQUOTA		0x0010
>  #define F2FS_FEATURE_INODE_CHKSUM	0x0020
>  #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
> +#define F2FS_FEATURE_QUOTA_INO		0x0080
>  
>  #define F2FS_HAS_FEATURE(sb, mask)					\
>  	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
> @@ -3070,6 +3071,11 @@ static inline int f2fs_sb_has_flexible_inline_xattr(struct super_block *sb)
>  	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_FLEXIBLE_INLINE_XATTR);
>  }
>  
> +static inline int f2fs_sb_has_quota_ino(struct super_block *sb)
> +{
> +	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_QUOTA_INO);
> +}
> +
>  #ifdef CONFIG_BLK_DEV_ZONED
>  static inline int get_blkz_type(struct f2fs_sb_info *sbi,
>  			struct block_device *bdev, block_t blkaddr)
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index f0fdc89ce82f..9835348b6e5d 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -110,6 +110,9 @@ static ssize_t features_show(struct f2fs_attr *a,
>  	if (f2fs_sb_has_flexible_inline_xattr(sb))
>  		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
>  				len ? ", " : "", "flexible_inline_xattr");
> +	if (f2fs_sb_has_quota_ino(sb))
> +		len += snprintf(buf + len, PAGE_SIZE - len, "%s%s",
> +				len ? ", " : "", "quota_ino");
>  	len += snprintf(buf + len, PAGE_SIZE - len, "\n");
>  	return len;
>  }
> @@ -227,6 +230,7 @@ enum feat_id {
>  	FEAT_PROJECT_QUOTA,
>  	FEAT_INODE_CHECKSUM,
>  	FEAT_FLEXIBLE_INLINE_XATTR,
> +	FEAT_QUOTA_INO,
>  };
>  
>  static ssize_t f2fs_feature_show(struct f2fs_attr *a,
> @@ -240,6 +244,7 @@ static ssize_t f2fs_feature_show(struct f2fs_attr *a,
>  	case FEAT_PROJECT_QUOTA:
>  	case FEAT_INODE_CHECKSUM:
>  	case FEAT_FLEXIBLE_INLINE_XATTR:
> +	case FEAT_QUOTA_INO:
>  		return snprintf(buf, PAGE_SIZE, "supported\n");
>  	}
>  	return 0;
> @@ -314,6 +319,7 @@ F2FS_FEATURE_RO_ATTR(extra_attr, FEAT_EXTRA_ATTR);
>  F2FS_FEATURE_RO_ATTR(project_quota, FEAT_PROJECT_QUOTA);
>  F2FS_FEATURE_RO_ATTR(inode_checksum, FEAT_INODE_CHECKSUM);
>  F2FS_FEATURE_RO_ATTR(flexible_inline_xattr, FEAT_FLEXIBLE_INLINE_XATTR);
> +F2FS_FEATURE_RO_ATTR(quota_ino, FEAT_QUOTA_INO);
>  
>  #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
>  static struct attribute *f2fs_attrs[] = {
> @@ -364,6 +370,7 @@ static struct attribute *f2fs_feat_attrs[] = {
>  	ATTR_LIST(project_quota),
>  	ATTR_LIST(inode_checksum),
>  	ATTR_LIST(flexible_inline_xattr),
> +	ATTR_LIST(quota_ino),
>  	NULL,
>  };
>  
> diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
> index 50a8ee501bf1..ce34007972c3 100644
> --- a/include/linux/f2fs_fs.h
> +++ b/include/linux/f2fs_fs.h
> @@ -36,6 +36,9 @@
>  #define F2FS_NODE_INO(sbi)	((sbi)->node_ino_num)
>  #define F2FS_META_INO(sbi)	((sbi)->meta_ino_num)
>  
> +#define F2FS_QUOTA_INO		3
> +#define F2FS_MAX_QUOTAS		3
> +
>  #define F2FS_IO_SIZE(sbi)	(1 << (sbi)->write_io_size_bits) /* Blocks */
>  #define F2FS_IO_SIZE_KB(sbi)	(1 << ((sbi)->write_io_size_bits + 2)) /* KB */
>  #define F2FS_IO_SIZE_BYTES(sbi)	(1 << ((sbi)->write_io_size_bits + 12)) /* B */
> @@ -108,7 +111,8 @@ struct f2fs_super_block {
>  	__u8 encryption_level;		/* versioning level for encryption */
>  	__u8 encrypt_pw_salt[16];	/* Salt used for string2key algorithm */
>  	struct f2fs_device devs[MAX_DEVICES];	/* device list */
> -	__u8 reserved[327];		/* valid reserved region */
> +	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
> +	__u8 reserved[315];		/* valid reserved region */
>  } __packed;
>  
>  /*
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

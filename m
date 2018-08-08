From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH v2 3/3] f2fs-tools: introduce sb checksum
Date: Wed, 8 Aug 2018 21:25:36 +0800
Message-ID: <b0a121b8-cfcc-7253-1679-340ea1d32cbd@kernel.org>
References: <20180808102750.102971-1-zhengjunling@huawei.com>
 <20180808102750.102971-3-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fnOTM-0005ue-Cf
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 13:25:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fnOTK-00BVmV-Gs
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 08 Aug 2018 13:25:56 +0000
In-Reply-To: <20180808102750.102971-3-zhengjunling@huawei.com>
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

On 2018/8/8 18:27, Junling Zheng wrote:
> This patch introduced superblock checksum.

It needs to update sb_chksum in sanity_check_area_boundary()?

To avoid missing updating sb_chksum, how about packaging a function to commit
superblock like what we did in kernel side, so that we can update chksum in
packaged function. IMO, we can add one other patch to do that before this one.

Thanks,

> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
> v1 -> v2:
>  - Rename CHKSUM_OFFSET_SB to SB_CHKSUM_OFFSET.
>  - Introduce update_sb_chksum() to update superblock checksum.
>  fsck/fsck.h        |  1 +
>  fsck/mount.c       | 44 ++++++++++++++++++++++++++++++++++++++++++++
>  fsck/resize.c      |  3 +++
>  include/f2fs_fs.h  |  6 +++++-
>  mkfs/f2fs_format.c |  9 +++++++++
>  5 files changed, 62 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 6042e68..2172cac 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -170,6 +170,7 @@ extern int fsck_verify(struct f2fs_sb_info *);
>  extern void fsck_free(struct f2fs_sb_info *);
>  extern int f2fs_do_mount(struct f2fs_sb_info *);
>  extern void f2fs_do_umount(struct f2fs_sb_info *);
> +extern void update_sb_chksum(struct f2fs_super_block *);
>  
>  extern void flush_journal_entries(struct f2fs_sb_info *);
>  extern void zero_journal_entries(struct f2fs_sb_info *);
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 58ef3e6..1dfabba 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -340,6 +340,7 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
>  	DISP_u32(sb, node_ino);
>  	DISP_u32(sb, meta_ino);
>  	DISP_u32(sb, cp_payload);
> +	DISP_u32(sb, crc);
>  	DISP("%-.256s", sb, version);
>  	printf("\n");
>  }
> @@ -467,6 +468,9 @@ void print_sb_state(struct f2fs_super_block *sb)
>  	if (f & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
>  		MSG(0, "%s", " lost_found");
>  	}
> +	if (f & cpu_to_le32(F2FS_FEATURE_SB_CHKSUM)) {
> +		MSG(0, "%s", " sb_checksum");
> +	}
>  	MSG(0, "\n");
>  	MSG(0, "Info: superblock encrypt level = %d, salt = ",
>  					sb->encryption_level);
> @@ -558,10 +562,29 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
>  	return 0;
>  }
>  
> +static int verify_sb_chksum(struct f2fs_super_block *sb)
> +{
> +	if (SB_CHKSUM_OFFSET != get_sb(checksum_offset)) {
> +		MSG(0, "\tInvalid SB CRC offset: %u\n",
> +					get_sb(checksum_offset));
> +		return -1;
> +	}
> +	if (f2fs_crc_valid(get_sb(crc), sb,
> +			get_sb(checksum_offset))) {
> +		MSG(0, "\tInvalid SB CRC: 0x%x\n", get_sb(crc));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
>  int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>  {
>  	unsigned int blocksize;
>  
> +	if ((get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) &&
> +					verify_sb_chksum(sb))
> +		return -1;
> +
>  	if (F2FS_SUPER_MAGIC != get_sb(magic))
>  		return -1;
>  
> @@ -605,6 +628,18 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>  	return 0;
>  }
>  
> +void update_sb_chksum(struct f2fs_super_block *sb)
> +{
> +	u32 old_crc, new_crc;
> +
> +	old_crc = get_sb(crc);
> +	new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb,
> +					SB_CHKSUM_OFFSET);
> +	set_sb(crc, new_crc);
> +	MSG(0, "Info: update SB CRC successfully "
> +		"(0x%x --> 0x%x)\n", old_crc, new_crc);
> +}
> +
>  int validate_super_block(struct f2fs_sb_info *sbi, int block)
>  {
>  	u64 offset;
> @@ -646,6 +681,10 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>  
>  			memcpy(sbi->raw_super->version,
>  						c.version, VERSION_LEN);
> +			if (le32_to_cpu(sbi->raw_super->feature) &
> +						F2FS_FEATURE_SB_CHKSUM)
> +				update_sb_chksum(sbi->raw_super);
> +
>  			ret = dev_write(sbi->raw_super, offset,
>  					sizeof(struct f2fs_super_block));
>  			ASSERT(ret >= 0);
> @@ -2402,6 +2441,9 @@ static int check_sector_size(struct f2fs_super_block *sb)
>  	set_sb(log_sectorsize, log_sectorsize);
>  	set_sb(log_sectors_per_block, log_sectors_per_block);
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM)
> +		update_sb_chksum(sb);
> +
>  	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
>  	for (index = 0; index < 2; index++) {
> @@ -2434,6 +2476,8 @@ static void tune_sb_features(struct f2fs_sb_info *sbi)
>  	if (!sb_changed)
>  		return;
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM)
> +		update_sb_chksum(sb);
>  	write_superblock(sb);
>  }
>  
> diff --git a/fsck/resize.c b/fsck/resize.c
> index e9612b3..ca8c6f9 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -160,6 +160,9 @@ safe_resize:
>  			(get_sb(segment_count_main) - 2));
>  		return -1;
>  	}
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM)
> +		update_sb_chksum(sb);
> +
>  	return 0;
>  }
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index e279b9f..b6dfd29 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -279,6 +279,7 @@ static inline uint64_t bswap_64(uint64_t val)
>  #define BITS_PER_BYTE		8
>  #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
>  #define CP_CHKSUM_OFFSET	4092
> +#define SB_CHKSUM_OFFSET	3068
>  #define MAX_PATH_LEN		64
>  #define MAX_DEVICES		8
>  
> @@ -579,6 +580,7 @@ enum {
>  #define F2FS_FEATURE_INODE_CRTIME	0x0100
>  #define F2FS_FEATURE_LOST_FOUND		0x0200
>  #define F2FS_FEATURE_VERITY		0x0400	/* reserved */
> +#define F2FS_FEATURE_SB_CHKSUM		0x0800
>  
>  #define MAX_VOLUME_NAME		512
>  
> @@ -632,7 +634,8 @@ struct f2fs_super_block {
>  	struct f2fs_device devs[MAX_DEVICES];	/* device list */
>  	__le32 qf_ino[F2FS_MAX_QUOTAS];	/* quota inode numbers */
>  	__u8 hot_ext_count;		/* # of hot file extension */
> -	__u8 reserved[314];		/* valid reserved region */
> +	__u8 reserved[310];		/* valid reserved region */
> +	__le32 crc;			/* checksum of superblock */
>  } __attribute__((packed));
>  
>  /*
> @@ -1337,6 +1340,7 @@ struct feature feature_table[] = {					\
>  	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME },	\
>  	{ "lost_found",			F2FS_FEATURE_LOST_FOUND },	\
>  	{ "verity",			F2FS_FEATURE_VERITY },	/* reserved */ \
> +	{ "sb_checksum",		F2FS_FEATURE_SB_CHKSUM },	\
>  	{ NULL,				0x0},				\
>  };
>  
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 621126c..012f3a8 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -187,6 +187,7 @@ static int f2fs_prepare_super_block(void)
>  	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
>  	u_int32_t max_nat_bitmap_size, max_nat_segments;
>  	u_int32_t total_zones;
> +	u_int32_t crc;
>  	enum quota_type qtype;
>  	int i;
>  
> @@ -504,6 +505,14 @@ static int f2fs_prepare_super_block(void)
>  
>  	sb->feature = c.feature;
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		set_sb(checksum_offset, SB_CHKSUM_OFFSET);
> +		/* calculate superblock checksum */
> +		crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb, SB_CHKSUM_OFFSET);
> +		set_sb(crc, crc);
> +		MSG(0, "Info: set SB CRC successfully (0x%x)\n", crc);
> +	}
> +
>  	return 0;
>  }
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

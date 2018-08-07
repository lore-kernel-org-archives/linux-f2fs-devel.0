From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [RFC PATCH 3/3] f2fs-tools: introduce sb checksum
Date: Tue, 7 Aug 2018 18:24:28 +0800
Message-ID: <900a2950-cad2-6900-3b22-faf9677d74b1@huawei.com>
References: <20180807091718.192688-1-zhengjunling@huawei.com>
 <20180807091718.192688-3-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1fmzAV-0006kK-Ft
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:24:47 +0000
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fmzAT-00Asxj-1B
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Aug 2018 10:24:47 +0000
In-Reply-To: <20180807091718.192688-3-zhengjunling@huawei.com>
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
To: Junling Zheng <zhengjunling@huawei.com>, jaegeuk@kernel.org
Cc: miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 2018/8/7 17:17, Junling Zheng wrote:
> This patch introduced superblock checksum.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
>  fsck/mount.c       | 52 ++++++++++++++++++++++++++++++++++++++++++++++
>  fsck/resize.c      | 11 ++++++++++
>  include/f2fs_fs.h  |  6 +++++-
>  mkfs/f2fs_format.c |  9 ++++++++
>  4 files changed, 77 insertions(+), 1 deletion(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 957f531..b29af3c 100644
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
> @@ -602,6 +606,20 @@ int sanity_check_raw_super(struct f2fs_super_block *sb, u64 offset)
>  
>  	if (sanity_check_area_boundary(sb, offset))
>  		return -1;
> +
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		if (CHKSUM_OFFSET_SB != get_sb(checksum_offset)) {
> +			MSG(0, "\tInvalid SB CRC offset: %u\n",
> +						get_sb(checksum_offset));
> +			return -1;
> +		}
> +		if (f2fs_crc_valid(get_sb(crc), sb,
> +				get_sb(checksum_offset))) {
> +			MSG(0, "\tInvalid SB CRC: 0x%x\n", get_sb(crc));
> +			return -1;
> +		}
> +	}
> +
>  	return 0;
>  }
>  
> @@ -609,6 +627,7 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>  {
>  	u64 offset;
>  	char buf[F2FS_BLKSIZE];
> +	u32 old_crc, new_crc;
>  
>  	sbi->raw_super = malloc(sizeof(struct f2fs_super_block));
>  
> @@ -646,6 +665,18 @@ int validate_super_block(struct f2fs_sb_info *sbi, int block)
>  
>  			memcpy(sbi->raw_super->version,
>  						c.version, VERSION_LEN);
> +			if (le32_to_cpu(sbi->raw_super->feature) &
> +						F2FS_FEATURE_SB_CHKSUM) {
> +				/* Recalculate CRC */
> +				old_crc = le32_to_cpu(sbi->raw_super->crc);
> +				new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC,
> +								sbi->raw_super,
> +								CHKSUM_OFFSET_SB);
> +				sbi->raw_super->crc = cpu_to_le32(new_crc);
> +				MSG(0, "Info: update SB CRC successfully"
> +					"(0x%x --> 0x%x)\n", old_crc, new_crc);
> +			}

As most of these codes are copied one, how about introducing functions to avoid
redundant codes and improve readability:

verify_sb_checksum()
update_sb_checksum(, bool initialize/update)


> +
>  			ret = dev_write(sbi->raw_super, offset,
>  					sizeof(struct f2fs_super_block));
>  			ASSERT(ret >= 0);
> @@ -2453,6 +2484,7 @@ static int check_sector_size(struct f2fs_super_block *sb)
>  	int index;
>  	u_int32_t log_sectorsize, log_sectors_per_block;
>  	u_int8_t *zero_buff;
> +	u32 old_crc, new_crc;
>  
>  	log_sectorsize = log_base_2(c.sector_size);
>  	log_sectors_per_block = log_base_2(c.sectors_per_blk);
> @@ -2467,6 +2499,16 @@ static int check_sector_size(struct f2fs_super_block *sb)
>  	set_sb(log_sectorsize, log_sectorsize);
>  	set_sb(log_sectors_per_block, log_sectors_per_block);
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		/* Recalculate CRC */
> +		old_crc = get_sb(crc);
> +		new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb,
> +						CHKSUM_OFFSET_SB);
> +		set_sb(crc, new_crc);
> +		MSG(0, "Info: update SB CRC successfully"
> +			"(0x%x --> 0x%x)\n", old_crc, new_crc);
> +	}
> +
>  	memcpy(zero_buff + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	DBG(1, "\tWriting super block, at offset 0x%08x\n", 0);
>  	for (index = 0; index < 2; index++) {
> @@ -2485,6 +2527,7 @@ static int check_sector_size(struct f2fs_super_block *sb)
>  static void tune_sb_features(struct f2fs_sb_info *sbi)
>  {
>  	int sb_changed = 0;
> +	u32 old_crc, new_crc;
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  
>  	if (!(sb->feature & cpu_to_le32(F2FS_FEATURE_ENCRYPT)) &&
> @@ -2499,6 +2542,15 @@ static void tune_sb_features(struct f2fs_sb_info *sbi)
>  	if (!sb_changed)
>  		return;
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		/* Recalculate CRC */
> +		old_crc = get_sb(crc);
> +		new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb,
> +						CHKSUM_OFFSET_SB);
> +		set_sb(crc, new_crc);
> +		MSG(0, "Info: update SB CRC successfully"
> +			"(0x%x --> 0x%x)\n", old_crc, new_crc);
> +	}
>  	write_superblock(sb);
>  }
>  
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 94580db..dfec9d2 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -11,6 +11,7 @@
>  
>  static int get_new_sb(struct f2fs_super_block *sb)
>  {
> +	u_int32_t old_crc, new_crc;
>  	u_int32_t zone_size_bytes;
>  	u_int64_t zone_align_start_offset;
>  	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
> @@ -160,6 +161,16 @@ safe_resize:
>  			(get_sb(segment_count_main) - 2));
>  		return -1;
>  	}
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		/* Recalculate CRC */
> +		old_crc = get_sb(crc);
> +		new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb,
> +						CHKSUM_OFFSET_SB);
> +		set_sb(crc, new_crc);
> +		MSG(0, "Info: update SB CRC successfully"
> +			"(0x%x --> 0x%x)\n", old_crc, new_crc);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index dbeeb6a..fb57c38 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -279,6 +279,7 @@ static inline uint64_t bswap_64(uint64_t val)
>  #define BITS_PER_BYTE		8
>  #define F2FS_SUPER_MAGIC	0xF2F52010	/* F2FS Magic Number */
>  #define CHKSUM_OFFSET_CP	4092
> +#define CHKSUM_OFFSET_SB	3068

How about SB_CHKSUM_OFFSET?

Thanks,

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
> @@ -1338,6 +1341,7 @@ struct feature feature_table[] = {					\
>  	{ "inode_crtime",		F2FS_FEATURE_INODE_CRTIME },	\
>  	{ "lost_found",			F2FS_FEATURE_LOST_FOUND },	\
>  	{ "verity",			F2FS_FEATURE_VERITY },	/* reserved */ \
> +	{ "sb_checksum",		F2FS_FEATURE_SB_CHKSUM },	\
>  	{ NULL,				0x0},				\
>  };
>  
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 038a589..53316ee 100644
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
> +		set_sb(checksum_offset, CHKSUM_OFFSET_SB);
> +		/* calculate superblock checksum */
> +		crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb, CHKSUM_OFFSET_SB);
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

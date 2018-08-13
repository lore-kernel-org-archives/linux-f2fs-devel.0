From: Chao Yu <chao@kernel.org>
Subject: Re: [RFC PATCH 4/4] f2fs-tools: introduce sb checksum
Date: Mon, 13 Aug 2018 22:33:55 +0800
Message-ID: <2e8414fe-b028-fdf0-3a78-97711a5d997f@kernel.org>
References: <20180813133211.243529-1-zhengjunling@huawei.com>
 <20180813133211.243529-4-zhengjunling@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1fpDv6-0005IH-A2
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 14:34:08 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fpDv3-00GMPu-VA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 13 Aug 2018 14:34:08 +0000
In-Reply-To: <20180813133211.243529-4-zhengjunling@huawei.com>
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

On 2018/8/13 21:32, Junling Zheng wrote:
> This patch introduced crc for superblock.
> 
> Signed-off-by: Junling Zheng <zhengjunling@huawei.com>
> ---
>  fsck/mount.c       | 23 +++++++++++++++++++++++
>  fsck/resize.c      | 12 ++++++------
>  include/f2fs_fs.h  | 16 +++++++++++++++-
>  mkfs/f2fs_format.c |  3 +++
>  4 files changed, 47 insertions(+), 7 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index e7ceb8d..af9b219 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -340,6 +340,7 @@ void print_raw_sb_info(struct f2fs_super_block *sb)
>  	DISP_u32(sb, node_ino);
>  	DISP_u32(sb, meta_ino);
>  	DISP_u32(sb, cp_payload);
> +	DISP_u32(sb, crc);

if (feature is on) {
	DISP_u32(sb, checksum_offset);
	DISP_u32(sb, crc);
}

Thanks,

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
> @@ -555,10 +559,29 @@ static inline int sanity_check_area_boundary(struct f2fs_super_block *sb,
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
>  int sanity_check_raw_super(struct f2fs_super_block *sb, enum SB_ADDR sb_addr)
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
> diff --git a/fsck/resize.c b/fsck/resize.c
> index 5161a1f..3462165 100644
> --- a/fsck/resize.c
> +++ b/fsck/resize.c
> @@ -603,9 +603,6 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
>  		}
>  	}
>  
> -	print_raw_sb_info(sb);
> -	print_raw_sb_info(new_sb);
> -
>  	old_main_blkaddr = get_sb(main_blkaddr);
>  	new_main_blkaddr = get_newsb(main_blkaddr);
>  	offset = new_main_blkaddr - old_main_blkaddr;
> @@ -629,6 +626,9 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
>  	migrate_sit(sbi, new_sb, offset_seg);
>  	rebuild_checkpoint(sbi, new_sb, offset_seg);
>  	update_superblock(new_sb, SB_ALL);
> +	print_raw_sb_info(sb);
> +	print_raw_sb_info(new_sb);
> +
>  	return 0;
>  }
>  
> @@ -658,9 +658,6 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
>  		}
>  	}
>  
> -	print_raw_sb_info(sb);
> -	print_raw_sb_info(new_sb);
> -
>  	old_main_blkaddr = get_sb(main_blkaddr);
>  	new_main_blkaddr = get_newsb(main_blkaddr);
>  	offset = old_main_blkaddr - new_main_blkaddr;
> @@ -690,6 +687,9 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
>  	/* move whole data region */
>  	//if (err)
>  	//	migrate_main(sbi, offset);
> +	print_raw_sb_info(sb);
> +	print_raw_sb_info(new_sb);
> +
>  	return 0;
>  }
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index b0d9b9b..556d526 100644
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
> @@ -1424,10 +1428,20 @@ static inline int __write_superblock(struct f2fs_super_block *sb, int sb_mask)
>  {
>  	int index, ret;
>  	u_int8_t *buf;
> +	u32 old_crc, new_crc;
>  
>  	buf = calloc(F2FS_BLKSIZE, 1);
>  	ASSERT(buf);
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM) {
> +		old_crc = get_sb(crc);
> +		new_crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, sb,
> +						SB_CHKSUM_OFFSET);
> +		set_sb(crc, new_crc);
> +		MSG(0, "Info: SB CRC is set successfully"
> +				"(0x%x -> 0x%x)\n", old_crc, new_crc);
> +	}
> +
>  	memcpy(buf + F2FS_SUPER_OFFSET, sb, sizeof(*sb));
>  	for (index = 0; index < SB_ADDR_MAX; index++) {
>  		if ((1 << index) & sb_mask) {
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 7e3846e..87e33da 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -504,6 +504,9 @@ static int f2fs_prepare_super_block(void)
>  
>  	sb->feature = c.feature;
>  
> +	if (get_sb(feature) & F2FS_FEATURE_SB_CHKSUM)
> +		set_sb(checksum_offset, SB_CHKSUM_OFFSET);
> +
>  	return 0;
>  }
>  
> 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

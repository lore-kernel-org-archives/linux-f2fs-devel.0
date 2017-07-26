From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH] f2fs-tools: support inode checksum
Date: Wed, 26 Jul 2017 14:40:59 -0700
Message-ID: <20170726214059.GB66153@jaegeuk-macbookpro.roam.corp.google.com>
References: <20170726150135.9641-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170726150135.9641-1-chao@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,

Just for testing purpose, I filed them in dev-test.git.
Note that, I fixed two build errors below.

Thanks,

On 07/26, Chao Yu wrote:
> From: Chao Yu <yuchao0@huawei.com>
> 
> This patch introduce a new option 'inode_checksum' for enabling inode
> checksum functionality in mkfs/fsck/sload.
> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fsck/dir.c              |  4 ++++
>  fsck/fsck.c             | 27 +++++++++++++++++++++++++--
>  fsck/mount.c            |  9 +++++++++
>  fsck/segment.c          |  4 ++++
>  include/f2fs_fs.h       |  5 +++++
>  lib/libf2fs.c           | 22 ++++++++++++++++++++++
>  mkfs/f2fs_format.c      |  8 ++++++++
>  mkfs/f2fs_format_main.c |  7 +++++++
>  8 files changed, 84 insertions(+), 2 deletions(-)
> 
> diff --git a/fsck/dir.c b/fsck/dir.c
> index 3aa67ec..bbf28aa 100644
> --- a/fsck/dir.c
> +++ b/fsck/dir.c
> @@ -447,6 +447,10 @@ static void init_inode_block(struct f2fs_sb_info *sbi,
>  		make_empty_dir(sbi, node_blk);
>  	else if (S_ISLNK(mode))
>  		page_symlink(sbi, node_blk, de->link, size);
> +
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +		node_blk->i.i_inode_checksum =
> +			cpu_to_le32(f2fs_inode_chksum(node_blk));
>  }
>  
>  int convert_inline_dentry(struct f2fs_sb_info *sbi, struct f2fs_node *node,
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index 7a81855..2787b35 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -857,9 +857,32 @@ skip_blkcnt_fix:
>  					nid, i_links);
>  		}
>  	}
> -	if (need_fix && !c.ro) {
> -		/* drop extent information to avoid potential wrong access */
> +
> +	/* drop extent information to avoid potential wrong access */
> +	if (need_fix && !c.ro)
>  		node_blk->i.i_ext.len = 0;
> +
> +	if ((c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) &&
> +				f2fs_has_extra_isize(&node_blk->i)) {
> +		__u32 provided, calculated;
> +
> +		provided = le32_to_cpu(node_blk->i.i_inode_checksum);
> +		calculated = f2fs_inode_chksum(node_blk);
> +
> +		if (provided != calculated) {
> +			ASSERT_MSG("ino: 0x%x chksum:0x%x, but calculated one is: 0x%x",
> +				nid, provided, calculated);
> +			if (c.fix_on) {
> +				node_blk->i.i_inode_checksum =
> +							cpu_to_le32(calculated);
> +				need_fix = 1;
> +				FIX_MSG("ino: 0x%x recover, i_inode_checksum= 0x%x -> 0x%x",
> +						provided, calculated);

						nid, provided, calculated);

Thanks,

> +			}
> +		}
> +	}
> +
> +	if (need_fix && !c.ro) {
>  		ret = dev_write_block(node_blk, ni->blk_addr);
>  		ASSERT(ret >= 0);
>  	}
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 0453f64..8b30264 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -91,6 +91,7 @@ void print_inode_info(struct f2fs_inode *inode, int name)
>  	DISP_u16(inode, i_extra_isize);
>  	DISP_u16(inode, i_padding);
>  	DISP_u32(inode, i_projid);
> +	DISP_u32(inode, i_inode_checksum);
>  
>  	DISP_u32(inode, i_addr[ofs]);		/* Pointers to data blocks */
>  	DISP_u32(inode, i_addr[ofs + 1]);	/* Pointers to data blocks */
> @@ -291,6 +292,9 @@ void print_sb_state(struct f2fs_super_block *sb)
>  	if (f & cpu_to_le32(F2FS_FEATURE_PRJQUOTA)) {
>  		MSG(0, "%s", " project quota");
>  	}
> +	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
> +		MSG(0, "%s", " inode checksum");
> +	}
>  	MSG(0, "\n");
>  	MSG(0, "Info: superblock encrypt level = %d, salt = ",
>  					sb->encryption_level);
> @@ -2157,6 +2161,11 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  	}
>  
>  	c.bug_on = 0;
> +	c.feature = sb->feature;
> +
> +	/* precompute checksum seed for metadata */
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +		c.chksum_seed = f2fs_cal_crc32(~0, sb->uuid, sizeof(sb->uuid));
>  
>  	sbi->total_valid_node_count = get_cp(valid_node_count);
>  	sbi->total_valid_inode_count = get_cp(valid_inode_count);
> diff --git a/fsck/segment.c b/fsck/segment.c
> index 5e23b6b..d568d61 100644
> --- a/fsck/segment.c
> +++ b/fsck/segment.c
> @@ -206,6 +206,10 @@ int f2fs_build_file(struct f2fs_sb_info *sbi, struct dentry *de)
>  
>  		node_blk->i.i_size = cpu_to_le64(de->size);
>  
> +		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +			node_blk->i.i_inode_checksum =
> +				cpu_to_le32(f2fs_inode_chksum(node_blk));
> +
>  		ret = dev_write_block(node_blk, ni.blk_addr);
>  		ASSERT(ret >= 0);
>  		free(node_blk);
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 380bc2a..dfbe36d 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -316,6 +316,9 @@ struct f2fs_configuration {
>  	/* sload parameters */
>  	char *from_dir;
>  	char *mount_point;
> +
> +	/* precomputed fs UUID checksum for seeding other checksums */
> +	u_int32_t chksum_seed;
>  };
>  
>  #ifdef CONFIG_64BIT
> @@ -473,6 +476,7 @@ enum {
>  #define F2FS_FEATURE_ATOMIC_WRITE	0x0004
>  #define F2FS_FEATURE_EXTRA_ATTR		0x0008
>  #define F2FS_FEATURE_PRJQUOTA		0x0010
> +#define F2FS_FEATURE_INODE_CHKSUM	0x0020
>  
>  #define MAX_VOLUME_NAME		512
>  
> @@ -683,6 +687,7 @@ struct f2fs_inode {
>  			__le16 i_extra_isize;	/* extra inode attribute size */
>  			__le16 i_padding;	/* padding */
>  			__le32 i_projid;	/* project id */
> +			__le32 i_inode_checksum;/* inode meta checksum */
>  			__le32 i_extra_end[0];	/* for attribute size calculation */
>  		};
>  		__le32 i_addr[DEF_ADDRS_PER_INODE];	/* Pointers to data blocks */
> diff --git a/lib/libf2fs.c b/lib/libf2fs.c
> index a3091bb..3c0465c 100644
> --- a/lib/libf2fs.c
> +++ b/lib/libf2fs.c
> @@ -493,6 +493,28 @@ int f2fs_crc_valid(u_int32_t blk_crc, void *buf, int len)
>  	return 0;
>  }
>  
> +__u32 f2fs_inode_chksum(struct f2fs_node *node)

Declare this in f2fs_fs.h.

> +{
> +	struct f2fs_inode *ri = &node->i;
> +	__le32 ino = node->footer.ino;
> +	__le32 gen = ri->i_generation;
> +	__u32 chksum, chksum_seed;
> +	__u32 dummy_cs = 0;
> +	unsigned int offset = offsetof(struct f2fs_inode, i_inode_checksum);
> +	unsigned int cs_size = sizeof(dummy_cs);
> +
> +	chksum = f2fs_cal_crc32(c.chksum_seed, (__u8 *)&ino,
> +							sizeof(ino));
> +	chksum_seed = f2fs_cal_crc32(chksum, (__u8 *)&gen, sizeof(gen));
> +
> +	chksum = f2fs_cal_crc32(chksum_seed, (__u8 *)ri, offset);
> +	chksum = f2fs_cal_crc32(chksum, (__u8 *)&dummy_cs, cs_size);
> +	offset += cs_size;
> +	chksum = f2fs_cal_crc32(chksum, (__u8 *)ri + offset,
> +						F2FS_BLKSIZE - offset);
> +	return chksum;
> +}
> +
>  /*
>   * try to identify the root device
>   */
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 8e068e9..92876b8 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -369,6 +369,10 @@ static int f2fs_prepare_super_block(void)
>  
>  	uuid_generate(sb->uuid);
>  
> +	/* precompute checksum seed for metadata */
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +		c.chksum_seed = f2fs_cal_crc32(~0, sb->uuid, sizeof(sb->uuid));
> +
>  	utf8_to_utf16(sb->volume_name, (const char *)c.vol_label,
>  				MAX_VOLUME_NAME, strlen(c.vol_label));
>  	set_sb(node_ino, 1);
> @@ -940,6 +944,10 @@ static int f2fs_write_root_inode(void)
>  	raw_node->i.i_ext.blk_addr = 0;
>  	raw_node->i.i_ext.len = 0;
>  
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +		raw_node->i.i_inode_checksum =
> +			cpu_to_le32(f2fs_inode_chksum(raw_node));
> +
>  	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
>  	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
>  					c.blks_per_seg;
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 39e8e3f..adbbff9 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -84,6 +84,8 @@ static void parse_feature(const char *features)
>  		c.feature |= cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR);
>  	} else if (!strcmp(features, "project_quota")) {
>  		c.feature |= cpu_to_le32(F2FS_FEATURE_PRJQUOTA);
> +	} else if (!strcmp(features, "inode_checksum")) {
> +		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM);
>  	} else {
>  		MSG(0, "Error: Wrong features\n");
>  		mkfs_usage();
> @@ -169,6 +171,11 @@ static void f2fs_parse_options(int argc, char *argv[])
>  				"enabled with extra attr feature\n");
>  			exit(1);
>  		}
> +		if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM)) {
> +			MSG(0, "\tInfo: inode checksum feature should always been"
> +				"enabled with extra attr feature\n");
> +			exit(1);
> +		}
>  	}
>  
>  	if (optind >= argc) {
> -- 
> 2.13.0.90.g1eb437020

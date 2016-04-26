From: He YunLei <heyunlei@huawei.com>
Subject: Re: [PATCH 1/3] resize.f2fs: support to expand partition
 size
Date: Tue, 26 Apr 2016 10:17:05 +0800
Message-ID: <571ECFA1.708@huawei.com>
References: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1ausud-0008C7-5t
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:39:43 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ausuT-0004Kr-Mg
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:39:43 +0000
In-Reply-To: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net

hi, kim

On 2016/4/26 8:28, Jaegeuk Kim wrote:
> Now user can expand existing partition with resize.f2fs.
> Currently, it doesn't support shrink an image.
>
> For example,
>   # resize.f2fs -t [# of sectors] [image]
>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>   fsck/Makefile.am  |   4 +-
>   fsck/f2fs.h       |   4 +-
>   fsck/fsck.h       |   2 +
>   fsck/main.c       |  64 ++++++
>   fsck/resize.c     | 578 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>   include/f2fs_fs.h |  17 ++
>   man/Makefile.am   |   2 +-
>   man/defrag.f2fs.8 |   3 +-
>   man/dump.f2fs.8   |   3 +-
>   man/fsck.f2fs.8   |   3 +-
>   man/mkfs.f2fs.8   |   3 +-
>   man/resize.f2fs.8 |  49 +++++
>   12 files changed, 724 insertions(+), 8 deletions(-)
>   create mode 100644 fsck/resize.c
>   create mode 100644 man/resize.f2fs.8
>
> diff --git a/fsck/Makefile.am b/fsck/Makefile.am
> index 73df884..3586625 100644
> --- a/fsck/Makefile.am
> +++ b/fsck/Makefile.am
> @@ -3,9 +3,11 @@
>   AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
>   AM_CFLAGS = -Wall
>   sbin_PROGRAMS = fsck.f2fs
> -fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h
> +fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c f2fs.h fsck.h $(top_srcdir)/include/f2fs_fs.h	\
> +		resize.c
>   fsck_f2fs_LDADD = ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
>
>   install-data-hook:
>   	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
>   	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/defrag.f2fs
> +	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/resize.f2fs
> diff --git a/fsck/f2fs.h b/fsck/f2fs.h
> index a618b47..4b3c666 100644
> --- a/fsck/f2fs.h
> +++ b/fsck/f2fs.h
> @@ -323,9 +323,9 @@ static inline block_t sum_blk_addr(struct f2fs_sb_info *sbi, int base, int type)
>   #define segno_in_journal(jnl, i)        (jnl->sit_j.entries[i].segno)
>
>   #define SIT_ENTRY_OFFSET(sit_i, segno)                                  \
> -	(segno % sit_i->sents_per_block)
> +	((segno) % sit_i->sents_per_block)
>   #define SIT_BLOCK_OFFSET(sit_i, segno)                                  \
> -	(segno / SIT_ENTRY_PER_BLOCK)
> +	((segno) / SIT_ENTRY_PER_BLOCK)
>   #define TOTAL_SEGS(sbi) (SM_I(sbi)->main_segments)
>
>   static inline bool IS_VALID_NID(struct f2fs_sb_info *sbi, u32 nid)
> diff --git a/fsck/fsck.h b/fsck/fsck.h
> index 5fc214e..db11b41 100644
> --- a/fsck/fsck.h
> +++ b/fsck/fsck.h
> @@ -179,4 +179,6 @@ extern int dump_info_from_blkaddr(struct f2fs_sb_info *, u32);
>   /* defrag.c */
>   int f2fs_defragment(struct f2fs_sb_info *, u64, u64, u64, int);
>
> +/* resize.c */
> +int f2fs_resize(struct f2fs_sb_info *);
>   #endif /* _FSCK_H_ */
> diff --git a/fsck/main.c b/fsck/main.c
> index 6058c4d..885e2cf 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -52,6 +52,15 @@ void defrag_usage()
>   	exit(1);
>   }
>
> +void resize_usage()
> +{
> +	MSG(0, "\nUsage: resize.f2fs [options] device\n");
> +	MSG(0, "[options]:\n");
> +	MSG(0, "  -d debug level [default:0]\n");
> +	MSG(0, "  -t target sectors [default: device size]\n");
> +	exit(1);
> +}
> +
>   void f2fs_parse_options(int argc, char *argv[])
>   {
>   	int option = 0;
> @@ -203,6 +212,34 @@ void f2fs_parse_options(int argc, char *argv[])
>   			}
>   			ASSERT(ret >= 0);
>   		}
> +	} else if (!strcmp("resize.f2fs", prog)) {
> +		const char *option_string = "d:t:";
> +
> +		config.func = RESIZE;
> +		while ((option = getopt(argc, argv, option_string)) != EOF) {
> +			int ret = 0;
> +
> +			switch (option) {
> +			case 'd':
> +				config.dbg_lv = atoi(optarg);
> +				MSG(0, "Info: Debug level = %d\n",
> +							config.dbg_lv);
> +				break;
> +			case 't':
> +				if (strncmp(optarg, "0x", 2))
> +					ret = sscanf(optarg, "%"PRIu64"",
> +							&config.target_sectors);
> +				else
> +					ret = sscanf(optarg, "%"PRIx64"",
> +							&config.target_sectors);
> +				break;
> +			default:
> +				MSG(0, "\tError: Unknown option %c\n", option);
> +				resize_usage();
> +				break;
> +			}
> +			ASSERT(ret >= 0);
> +		}
>   	}
>
>   	if ((optind + 1) != argc) {
> @@ -213,6 +250,8 @@ void f2fs_parse_options(int argc, char *argv[])
>   			dump_usage();
>   		else if (config.func == DEFRAG)
>   			defrag_usage();
> +		else if (config.func == RESIZE)
> +			resize_usage();
>   	}
>   	config.device_name = argv[optind];
>   }
> @@ -345,6 +384,27 @@ out_range:
>   	return -1;
>   }
>
> +static int do_resize(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +
> +	if (!config.target_sectors)
> +		config.target_sectors = config.total_sectors;
> +
> +	if (config.target_sectors > config.total_sectors) {
> +		ASSERT_MSG("Out-of-range Target=0x%"PRIx64" / 0x%"PRIx64"",
> +				config.target_sectors, config.total_sectors);
> +		return -1;
> +	}
> +
> +	if (config.target_sectors ==
> +			(get_sb(block_count) << get_sb(log_sectors_per_block))) {
> +		ASSERT_MSG("Nothing to resize; it's same");
> +		return -1;
> +	}
> +	return f2fs_resize(sbi);
> +}
> +
>   int main(int argc, char **argv)
>   {
>   	struct f2fs_sb_info *sbi;
> @@ -395,6 +455,10 @@ fsck_again:
>   		if (ret)
>   			goto out_err;
>   		break;
> +	case RESIZE:
> +		if (do_resize(sbi))
> +			goto out_err;
> +		break;
>   	}
>
>   	f2fs_do_umount(sbi);
> diff --git a/fsck/resize.c b/fsck/resize.c
> new file mode 100644
> index 0000000..0803024
> --- /dev/null
> +++ b/fsck/resize.c
> @@ -0,0 +1,578 @@
> +/**
> + * resize.c
> + *
> + * Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +#include "fsck.h"
> +
> +static int get_new_sb(struct f2fs_sb_info *sbi, struct f2fs_super_block *sb)
> +{
> +	u_int32_t zone_size_bytes, zone_align_start_offset;
> +	u_int32_t blocks_for_sit, blocks_for_nat, blocks_for_ssa;
> +	u_int32_t sit_segments, diff, total_meta_segments;
> +	u_int32_t total_valid_blks_available;
> +	u_int32_t sit_bitmap_size, max_sit_bitmap_size;
> +	u_int32_t max_nat_bitmap_size, max_nat_segments;
> +	u_int32_t segment_size_bytes = 1 << (get_sb(log_blocksize) +
> +					get_sb(log_blocks_per_seg));
> +	u_int32_t blks_per_seg = 1 << get_sb(log_blocks_per_seg);
> +	u_int32_t segs_per_zone = get_sb(segs_per_sec) * get_sb(secs_per_zone);
> +
> +	set_sb(block_count, config.target_sectors >>
> +				get_sb(log_sectors_per_block));
> +
> +	zone_size_bytes = segment_size_bytes * segs_per_zone;
> +	zone_align_start_offset =
> +		(config.start_sector * config.sector_size +
> +		2 * F2FS_BLKSIZE + zone_size_bytes - 1) /
> +		zone_size_bytes * zone_size_bytes -
> +		config.start_sector * config.sector_size;
> +
> +	set_sb(segment_count, (config.target_sectors * config.sector_size -
> +				zone_align_start_offset) / segment_size_bytes /
> +				config.segs_per_sec * config.segs_per_sec);
> +
> +	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
> +	sit_segments = SEG_ALIGN(blocks_for_sit);
> +	set_sb(segment_count_sit, sit_segments * 2);
> +	set_sb(nat_blkaddr, get_sb(sit_blkaddr) +
> +				get_sb(segment_count_sit) * blks_per_seg);
> +
> +	total_valid_blks_available = (get_sb(segment_count) -
> +			(get_sb(segment_count_ckpt) +
> +			get_sb(segment_count_sit))) * blks_per_seg;
> +	blocks_for_nat = ALIGN(total_valid_blks_available, NAT_ENTRY_PER_BLOCK);
> +	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
> +
> +	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
> +				get_sb(log_blocks_per_seg)) / 8;
> +	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
> +		max_sit_bitmap_size = MAX_SIT_BITMAP_SIZE;
> +	else
> +		max_sit_bitmap_size = sit_bitmap_size;
> +
> +	/*
> +	 * It should be reserved minimum 1 segment for nat.
> +	 * When sit is too large, we should expand cp area. It requires more pages for cp.
> +	 */
> +	if (max_sit_bitmap_size >
> +			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 65)) {
> +		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
> +		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
> +	} else {
> +		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
> +			- max_sit_bitmap_size;
> +		set_sb(cp_payload, 0);
> +	}
> +
> +	max_nat_segments = (max_nat_bitmap_size * 8) >>
> +					get_sb(log_blocks_per_seg);
> +
> +	if (get_sb(segment_count_nat) > max_nat_segments)
> +		set_sb(segment_count_nat, max_nat_segments);
> +
> +	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
> +
> +	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) +
> +				get_sb(segment_count_nat) * blks_per_seg);
> +
> +	total_valid_blks_available = (get_sb(segment_count) -
> +			(get_sb(segment_count_ckpt) +
> +			get_sb(segment_count_sit) +
> +			get_sb(segment_count_nat))) * blks_per_seg;
> +
> +	blocks_for_ssa = total_valid_blks_available / blks_per_seg + 1;
> +
> +	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
> +
> +	total_meta_segments = get_sb(segment_count_ckpt) +
> +		get_sb(segment_count_sit) +
> +		get_sb(segment_count_nat) +
> +		get_sb(segment_count_ssa);
> +
> +	diff = total_meta_segments % segs_per_zone;
> +	if (diff)
> +		set_sb(segment_count_ssa, get_sb(segment_count_ssa) +
> +			(segs_per_zone - diff));
> +
> +	set_sb(main_blkaddr, get_sb(ssa_blkaddr) + get_sb(segment_count_ssa) *
> +			 blks_per_seg);
> +
> +	set_sb(segment_count_main, get_sb(segment_count) -
> +			(get_sb(segment_count_ckpt) +
> +			 get_sb(segment_count_sit) +
> +			 get_sb(segment_count_nat) +
> +			 get_sb(segment_count_ssa)));
> +
> +	set_sb(section_count, get_sb(segment_count_main) /
> +						get_sb(segs_per_sec));
> +
> +	set_sb(segment_count_main, get_sb(section_count) *
> +						get_sb(segs_per_sec));
> +
> +	/* Let's determine the best reserved and overprovisioned space */
> +	config.new_overprovision = get_best_overprovision(sb);
> +	config.new_reserved_segments =
> +		(2 * (100 / config.new_overprovision + 1) + 6) *
> +						get_sb(segs_per_sec);
> +
> +	if ((get_sb(segment_count_main) - 2) < config.new_reserved_segments ||
> +		get_sb(segment_count_main) * blks_per_seg >
> +						get_sb(block_count)) {
> +		MSG(0, "\tError: Device size is not sufficient for F2FS volume,\
> +			more segment needed =%u",
> +			config.new_reserved_segments -
> +			(get_sb(segment_count_main) - 2));
> +		return -1;
> +	}
> +	return 0;
> +}
> +
> +static void migrate_main(struct f2fs_sb_info *sbi,
> +		struct f2fs_super_block *new_sb, unsigned int offset)
> +{
> +	void *raw = calloc(BLOCK_SZ, 1);
> +	struct seg_entry *se;
> +	block_t from, to;
> +	int i, j, ret;
> +	struct f2fs_summary sum;
> +
> +	ASSERT(raw != NULL);
> +
> +	for (i = TOTAL_SEGS(sbi); i >= 0; i--) {
> +		se = get_seg_entry(sbi, i);
> +		if (!se->valid_blocks)
> +			continue;
> +
> +		for (j = sbi->blocks_per_seg - 1; j >= 0; j--) {
> +			if (!f2fs_test_bit(j, (const char *)se->cur_valid_map))
> +				continue;
> +
> +			from = START_BLOCK(sbi, i) + j;
> +			ret = dev_read_block(raw, from);
> +			ASSERT(ret >= 0);
> +
> +			to = from + offset;
> +			ret = dev_write_block(raw, to);
> +			ASSERT(ret >= 0);
> +
> +			get_sum_entry(sbi, from, &sum);
> +
> +			if (IS_DATASEG(se->type))
> +				update_data_blkaddr(sbi, le32_to_cpu(sum.nid),
> +					le16_to_cpu(sum.ofs_in_node), to);
> +			else
> +				update_nat_blkaddr(sbi, 0,
> +						le32_to_cpu(sum.nid), to);
> +		}
> +	}
> +	free(raw);
> +	DBG(0, "Info: Done to migrate data and node blocks\n");
> +}
> +
> +static void move_ssa(struct f2fs_sb_info *sbi, unsigned int segno,
> +					block_t new_sum_blk_addr)
> +{
> +	struct f2fs_summary_block *sum_blk;
> +	int type;
> +
> +	sum_blk = get_sum_block(sbi, segno, &type);
> +	if (type < SEG_TYPE_MAX) {
> +		int ret;
> +
> +		ret = dev_write_block(sum_blk, new_sum_blk_addr);
> +		ASSERT(ret >= 0);
> +		DBG(1, "Write summary block: (%d) segno=%x/%x --> (%d) %x\n",
> +				type, segno, GET_SUM_BLKADDR(sbi, segno),
> +				IS_SUM_NODE_SEG(sum_blk->footer),
> +				new_sum_blk_addr);
> +	}
> +	if (type == SEG_TYPE_NODE || type == SEG_TYPE_DATA ||
> +			type == SEG_TYPE_MAX) {
> +		free(sum_blk);
> +	}
> +	DBG(1, "Info: Done to migrate SSA blocks\n");
> +}
> +
> +static void migrate_ssa(struct f2fs_sb_info *sbi,
> +		struct f2fs_super_block *new_sb, unsigned int offset)
> +{
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
> +	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
> +	int segno;
> +
> +	if (new_sum_blkaddr < old_sum_blkaddr + offset) {
> +		for (segno = offset; segno < TOTAL_SEGS(sbi); segno++)
> +			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
> +	} else {
> +		for (segno = TOTAL_SEGS(sbi) - 1; segno >= offset; segno--)
> +			move_ssa(sbi, segno, new_sum_blkaddr + segno - offset);
> +	}
> +
> +	DBG(0, "Info: Done to migrate SSA blocks\n");
> +}
> +
> +static int shrink_nats(struct f2fs_sb_info *sbi,
> +				struct f2fs_super_block *new_sb)
> +{
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	block_t old_nat_blkaddr = get_sb(nat_blkaddr);
> +	unsigned int nat_blocks;
> +	void *nat_block, *zero_block;
> +	int nid, ret, new_max_nid;
> +	pgoff_t block_off;
> +	pgoff_t block_addr;
> +	int seg_off;
> +
> +	nat_block = malloc(BLOCK_SZ);
> +	ASSERT(nat_block);
> +	zero_block = calloc(BLOCK_SZ, 1);
> +	ASSERT(zero_block);
> +
> +	nat_blocks = get_newsb(segment_count_nat) >> 1;
> +	nat_blocks = nat_blocks << get_sb(log_blocks_per_seg);
> +	new_max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
> +
> +	for (nid = nm_i->max_nid - 1; nid > new_max_nid; nid -= NAT_ENTRY_PER_BLOCK) {
> +		block_off = nid / NAT_ENTRY_PER_BLOCK;
> +		seg_off = block_off >> sbi->log_blocks_per_seg;
> +		block_addr = (pgoff_t)(old_nat_blkaddr +
> +				(seg_off << sbi->log_blocks_per_seg << 1) +
> +				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
> +
> +		if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
> +			block_addr += sbi->blocks_per_seg;
> +
> +		ret = dev_read_block(nat_block, block_addr);
> +		ASSERT(ret >= 0);
> +
> +		if (memcmp(zero_block, nat_block, BLOCK_SZ)) {
> +			ret = -1;
> +			goto not_avail;
> +		}
> +	}
> +	ret = 0;
> +	nm_i->max_nid = new_max_nid;
> +not_avail:
> +	free(nat_block);
> +	free(zero_block);
> +	return ret;
> +}
> +
> +static void migrate_nat(struct f2fs_sb_info *sbi,
> +			struct f2fs_super_block *new_sb)
> +{
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +	struct f2fs_nm_info *nm_i = NM_I(sbi);
> +	block_t old_nat_blkaddr = get_sb(nat_blkaddr);
> +	block_t new_nat_blkaddr = get_newsb(nat_blkaddr);
> +	unsigned int nat_blocks;
> +	void *nat_block;
> +	int nid, ret, new_max_nid;
> +	pgoff_t block_off;
> +	pgoff_t block_addr;
> +	int seg_off;
> +
> +	nat_block = malloc(BLOCK_SZ);
> +	ASSERT(nat_block);
> +
> +	for (nid = nm_i->max_nid - 1; nid >= 0; nid -= NAT_ENTRY_PER_BLOCK) {
> +		block_off = nid / NAT_ENTRY_PER_BLOCK;
> +		seg_off = block_off >> sbi->log_blocks_per_seg;
> +		block_addr = (pgoff_t)(old_nat_blkaddr +
> +				(seg_off << sbi->log_blocks_per_seg << 1) +
> +				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
> +
> +		if (f2fs_test_bit(block_off, nm_i->nat_bitmap))
> +			block_addr += sbi->blocks_per_seg;
> +
> +		ret = dev_read_block(nat_block, block_addr);
> +		ASSERT(ret >= 0);
> +
> +		block_addr = (pgoff_t)(new_nat_blkaddr +
> +				(seg_off << sbi->log_blocks_per_seg << 1) +
> +				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
> +
> +		/* new bitmap should be zeros */
> +		ret = dev_write_block(nat_block, block_addr);
> +		ASSERT(ret >= 0);
> +	}
> +	/* zero out newly assigned nids */
> +	memset(nat_block, 0, BLOCK_SZ);
> +	nat_blocks = get_newsb(segment_count_nat) >> 1;
> +	nat_blocks = nat_blocks << get_sb(log_blocks_per_seg);
> +	new_max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
> +
> +	DBG(1, "Write NAT block: %x->%x, max_nid=%x->%x\n",
> +			old_nat_blkaddr, new_nat_blkaddr,
> +			get_sb(segment_count_nat),
> +			get_newsb(segment_count_nat));
> +
> +	for (nid = nm_i->max_nid; nid < new_max_nid;
> +				nid += NAT_ENTRY_PER_BLOCK) {
> +		block_off = nid / NAT_ENTRY_PER_BLOCK;
> +		seg_off = block_off >> sbi->log_blocks_per_seg;
> +		block_addr = (pgoff_t)(new_nat_blkaddr +
> +				(seg_off << sbi->log_blocks_per_seg << 1) +
> +				(block_off & ((1 << sbi->log_blocks_per_seg) - 1)));
> +		ret = dev_write_block(nat_block, block_addr);
> +		ASSERT(ret >= 0);
> +		DBG(1, "Write NAT: %lx\n", block_addr);
> +	}
> +	DBG(0, "Info: Done to migrate NAT blocks\n");
> +}
> +
> +static void migrate_sit(struct f2fs_sb_info *sbi,
> +		struct f2fs_super_block *new_sb, unsigned int offset)
> +{
> +	struct sit_info *sit_i = SIT_I(sbi);
> +	unsigned int ofs = 0, pre_ofs = 0;
> +	unsigned int segno, index;
> +	struct f2fs_sit_block *sit_blk = calloc(BLOCK_SZ, 1);
> +	block_t sit_blks = get_newsb(segment_count_sit) <<
> +						(sbi->log_blocks_per_seg - 1);
> +	struct seg_entry *se;
> +	block_t blk_addr = 0;
> +	int ret;
> +
> +	ASSERT(sit_blk);
> +
> +	/* initialize with zeros */
> +	for (index = 0; index < sit_blks; index++) {
> +		ret = dev_write_block(sit_blk, get_newsb(sit_blkaddr) + index);
> +		ASSERT(ret >= 0);
> +		DBG(1, "Write zero sit: %x\n", get_newsb(sit_blkaddr) + index);
> +	}
> +
> +	for (segno = 0; segno < TOTAL_SEGS(sbi); segno++) {
> +		struct f2fs_sit_entry *sit;
> +
> +		se = get_seg_entry(sbi, segno);
> +		if (segno < offset) {
> +			ASSERT(se->valid_blocks == 0);
> +			continue;
> +		}
> +
> +		ofs = SIT_BLOCK_OFFSET(sit_i, segno - offset);
> +
> +		if (ofs != pre_ofs) {
> +			blk_addr = get_newsb(sit_blkaddr) + pre_ofs;
> +			ret = dev_write_block(sit_blk, blk_addr);
> +			ASSERT(ret >= 0);
> +			DBG(1, "Write valid sit: %x\n", blk_addr);
> +
> +			pre_ofs = ofs;
> +			memset(sit_blk, 0, BLOCK_SZ);
> +		}
> +
> +		sit = &sit_blk->entries[SIT_ENTRY_OFFSET(sit_i, segno - offset)];
> +		memcpy(sit->valid_map, se->cur_valid_map, SIT_VBLOCK_MAP_SIZE);
> +		sit->vblocks = cpu_to_le16((se->type << SIT_VBLOCKS_SHIFT) |
> +							se->valid_blocks);
> +	}
> +	blk_addr = get_newsb(sit_blkaddr) + ofs;
> +	ret = dev_write_block(sit_blk, blk_addr);
> +	DBG(1, "Write valid sit: %x\n", blk_addr);
> +	ASSERT(ret >= 0);
> +
> +	free(sit_blk);
> +	DBG(0, "Info: Done to migrate SIT blocks\n");
> +}
> +
> +static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
> +			struct f2fs_super_block *new_sb, unsigned int offset)
> +{
> +	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
> +	struct f2fs_checkpoint *new_cp;
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +	unsigned int free_segment_count, new_segment_count;
> +	block_t new_cp_blks = 1 + get_newsb(cp_payload);
> +	block_t orphan_blks = 0;
> +	block_t new_cp_blk_no, old_cp_blk_no;
> +	u_int32_t crc = 0;
> +	void *buf;
> +	int i, ret;
> +
> +	new_cp = calloc(new_cp_blks * BLOCK_SZ, 1);
> +	ASSERT(new_cp);
> +
> +	buf = malloc(BLOCK_SZ);
> +	ASSERT(buf);
> +
> +	/* ovp / free segments */
> +	set_cp(overprov_segment_count, config.new_overprovision);
> +	set_cp(rsvd_segment_count, config.new_reserved_segments);
> +	free_segment_count = get_cp(free_segment_count);
> +	new_segment_count = get_newsb(segment_count_main) -
> +					get_sb(segment_count_main);
> +
> +	set_cp(free_segment_count, free_segment_count + new_segment_count);
> +	set_cp(user_block_count, ((get_sb(segment_count_main) -

there maybe we should use new_sb:
		
	set_cp(user_block_count, ((get_newsb(segment_count_main) -

Thanks.
	
> +			get_cp(overprov_segment_count)) * config.blks_per_seg));
> +
> +	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG))
> +		orphan_blks = __start_sum_addr(sbi) - 1;
> +
> +	set_cp(cp_pack_start_sum, 1 + get_newsb(cp_payload));
> +	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_newsb(cp_payload));
> +
> +	/* cur->segno - offset */
> +	for (i = 0; i < NO_CHECK_TYPE; i++) {
> +		if (i < CURSEG_HOT_NODE) {
> +			set_cp(cur_data_segno[i],
> +					CURSEG_I(sbi, i)->segno - offset);
> +		} else {
> +			int n = i - CURSEG_HOT_NODE;
> +
> +			set_cp(cur_node_segno[n],
> +					CURSEG_I(sbi, i)->segno - offset);
> +		}
> +	}
> +
> +	/* sit / nat ver bitmap bytesize */
> +	set_cp(sit_ver_bitmap_bytesize,
> +			((get_newsb(segment_count_sit) / 2) <<
> +			get_newsb(log_blocks_per_seg)) / 8);
> +	set_cp(nat_ver_bitmap_bytesize,
> +			((get_newsb(segment_count_nat) / 2) <<
> +			get_newsb(log_blocks_per_seg)) / 8);
> +
> +	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
> +						(unsigned char *)cp);
> +
> +	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CHECKSUM_OFFSET);
> +	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
> +
> +	/* Write a new checkpoint in the other set */
> +	new_cp_blk_no = old_cp_blk_no = get_sb(cp_blkaddr);
> +	if (sbi->cur_cp == 2)
> +		old_cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +	else
> +		new_cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +
> +	/* write first cp */
> +	ret = dev_write_block(new_cp, new_cp_blk_no++);
> +	ASSERT(ret >= 0);
> +
> +	memset(buf, 0, BLOCK_SZ);
> +	for (i = 0; i < get_newsb(cp_payload); i++) {
> +		ret = dev_write_block(buf, new_cp_blk_no++);
> +		ASSERT(ret >= 0);
> +	}
> +
> +	for (i = 0; i < orphan_blks; i++) {
> +		block_t orphan_blk_no = old_cp_blk_no + 1 + get_sb(cp_payload);
> +
> +		ret = dev_read_block(buf, orphan_blk_no++);
> +		ASSERT(ret >= 0);
> +
> +		ret = dev_write_block(buf, new_cp_blk_no++);
> +		ASSERT(ret >= 0);
> +	}
> +
> +	/* update summary blocks having nullified journal entries */
> +	for (i = 0; i < NO_CHECK_TYPE; i++) {
> +		struct curseg_info *curseg = CURSEG_I(sbi, i);
> +
> +		ret = dev_write_block(curseg->sum_blk, new_cp_blk_no++);
> +		ASSERT(ret >= 0);
> +	}
> +
> +	/* write the last cp */
> +	ret = dev_write_block(new_cp, new_cp_blk_no++);
> +	ASSERT(ret >= 0);
> +
> +	/* disable old checkpoint */
> +	memset(buf, 0, BLOCK_SZ);
> +	ret = dev_write_block(buf, old_cp_blk_no);
> +	ASSERT(ret >= 0);
> +
> +	free(buf);
> +	free(new_cp);
> +	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
> +}
> +
> +static void rebuild_superblock(struct f2fs_sb_info *sbi,
> +				struct f2fs_super_block *new_sb)
> +{
> +	int index, ret;
> +	u_int8_t *buf;
> +
> +	buf = calloc(BLOCK_SZ, 1);
> +
> +	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
> +	for (index = 0; index < 2; index++) {
> +		ret = dev_write_block(buf, index);
> +		ASSERT(ret >= 0);
> +	}
> +	free(buf);
> +	DBG(0, "Info: Done to rebuild superblock\n");
> +}
> +
> +int f2fs_resize(struct f2fs_sb_info *sbi)
> +{
> +	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> +	struct f2fs_super_block new_sb_raw;
> +	struct f2fs_super_block *new_sb = &new_sb_raw;
> +	block_t end_blkaddr, old_main_blkaddr, new_main_blkaddr;
> +	unsigned int offset, offset_seg;
> +	int err = -1;
> +
> +	/* flush NAT/SIT journal entries */
> +	flush_journal_entries(sbi);
> +
> +	memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
> +	if (get_new_sb(sbi, new_sb))
> +		return -1;
> +
> +	/* check nat availability */
> +	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
> +		err = shrink_nats(sbi, new_sb);
> +		if (err) {
> +			MSG(0, "\tError: Failed to shrink NATs\n");
> +			return err;
> +		}
> +	}
> +
> +	config.dbg_lv = 1;
> +	print_raw_sb_info(sb);
> +	print_raw_sb_info(new_sb);
> +	config.dbg_lv = 0;
> +
> +	old_main_blkaddr = get_sb(main_blkaddr);
> +	new_main_blkaddr = get_newsb(main_blkaddr);
> +	offset = new_main_blkaddr - old_main_blkaddr;
> +	end_blkaddr = (get_sb(segment_count) << get_sb(log_blocks_per_seg)) +
> +						get_sb(main_blkaddr);
> +
> +	if (old_main_blkaddr > new_main_blkaddr) {
> +		MSG(0, "\tError: Support resize to expand only\n");
> +		return -1;
> +	}
> +
> +	err = -EAGAIN;
> +	offset_seg = offset >> get_sb(log_blocks_per_seg);
> +
> +	if (new_main_blkaddr < end_blkaddr) {
> +		err = f2fs_defragment(sbi, old_main_blkaddr, offset,
> +						new_main_blkaddr, 0);
> +		if (err)
> +			MSG(0, "Skip defragement\n");
> +	}
> +	/* move whole data region */
> +	if (err)
> +		migrate_main(sbi, new_sb, offset);
> +
> +	migrate_ssa(sbi, new_sb, offset_seg);
> +	migrate_nat(sbi, new_sb);
> +	migrate_sit(sbi, new_sb, offset_seg);
> +	rebuild_checkpoint(sbi, new_sb, offset_seg);
> +	rebuild_superblock(sbi, new_sb);
> +	return 0;
> +}
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index 330cbe5..99798d0 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -221,18 +221,22 @@ enum f2fs_config_func {
>   	FSCK,
>   	DUMP,
>   	DEFRAG,
> +	RESIZE,
>   };
>
>   struct f2fs_configuration {
>   	u_int32_t sector_size;
>   	u_int32_t reserved_segments;
> +	u_int32_t new_reserved_segments;
>   	double overprovision;
> +	double new_overprovision;
>   	u_int32_t cur_seg[6];
>   	u_int32_t segs_per_sec;
>   	u_int32_t secs_per_zone;
>   	u_int32_t segs_per_zone;
>   	u_int32_t start_sector;
>   	u_int64_t total_sectors;
> +	u_int64_t target_sectors;
>   	u_int32_t sectors_per_blk;
>   	u_int32_t blks_per_seg;
>   	__u8 init_version[VERSION_LEN + 1];
> @@ -277,6 +281,9 @@ struct f2fs_configuration {
>   #define get_sb_le64(member)			le64_to_cpu(sb->member)
>   #define get_sb_le32(member)			le32_to_cpu(sb->member)
>   #define get_sb_le16(member)			le16_to_cpu(sb->member)
> +#define get_newsb_le64(member)			le64_to_cpu(new_sb->member)
> +#define get_newsb_le32(member)			le32_to_cpu(new_sb->member)
> +#define get_newsb_le16(member)			le16_to_cpu(new_sb->member)
>
>   #define set_sb(member, val)	\
>   			do {						\
> @@ -298,6 +305,16 @@ struct f2fs_configuration {
>   				} 					\
>   				t; \
>   			})
> +#define get_newsb(member)		\
> +			({						\
> +				typeof(new_sb->member) t;		\
> +				switch (sizeof(t)) {			\
> +				case 8: t = get_newsb_le64(member); break; \
> +				case 4: t = get_newsb_le32(member); break; \
> +				case 2: t = get_newsb_le16(member); break; \
> +				} 					\
> +				t; \
> +			})
>
>   #define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
>   #define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
> diff --git a/man/Makefile.am b/man/Makefile.am
> index 256f3c3..6c04de7 100644
> --- a/man/Makefile.am
> +++ b/man/Makefile.am
> @@ -1,3 +1,3 @@
>   ## Makefile.am
>
> -dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8
> +dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8
> diff --git a/man/defrag.f2fs.8 b/man/defrag.f2fs.8
> index e18e69f..8c709a7 100644
> --- a/man/defrag.f2fs.8
> +++ b/man/defrag.f2fs.8
> @@ -71,4 +71,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
>   .SH SEE ALSO
>   .BR mkfs.f2fs(8),
>   .BR dump.f2fs(8),
> -.BR fsck.f2fs(8).
> +.BR fsck.f2fs(8),
> +.BR resize.f2fs(8).
> diff --git a/man/dump.f2fs.8 b/man/dump.f2fs.8
> index ca5f511..dc1d806 100644
> --- a/man/dump.f2fs.8
> +++ b/man/dump.f2fs.8
> @@ -65,4 +65,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
>   .SH SEE ALSO
>   .BR mkfs.f2fs(8),
>   .BR fsck.f2fs(8),
> -.BR defrag.f2fs(8).
> +.BR defrag.f2fs(8),
> +.BR resize.f2fs(8).
> diff --git a/man/fsck.f2fs.8 b/man/fsck.f2fs.8
> index 0ffe6e1..22457c5 100644
> --- a/man/fsck.f2fs.8
> +++ b/man/fsck.f2fs.8
> @@ -64,4 +64,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
>   .SH SEE ALSO
>   .BR mkfs.f2fs(8),
>   .BR dump.f2fs(8),
> -.BR defrag.f2fs(8).
> +.BR defrag.f2fs(8),
> +.BR resize.f2fs(8).
> diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> index cdbde96..b767c0c 100644
> --- a/man/mkfs.f2fs.8
> +++ b/man/mkfs.f2fs.8
> @@ -94,4 +94,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
>   .BR mkfs (8),
>   .BR fsck.f2fs(8),
>   .BR dump.f2fs(8),
> -.BR defrag.f2fs(8).
> +.BR defrag.f2fs(8),
> +.BR resize.f2fs(8).
> diff --git a/man/resize.f2fs.8 b/man/resize.f2fs.8
> new file mode 100644
> index 0000000..1920810
> --- /dev/null
> +++ b/man/resize.f2fs.8
> @@ -0,0 +1,49 @@
> +.\" Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
> +.\"
> +.TH RESIZE.F2FS 8
> +.SH NAME
> +resize.f2fs \- resize filesystem size
> +.SH SYNOPSIS
> +.B resize.f2fs
> +[
> +.B \-t
> +.I target sectors
> +]
> +[
> +.B \-d
> +.I debugging-level
> +]
> +.I device
> +.SH DESCRIPTION
> +.B resize.f2fs
> +is used to resize an f2fs file system (usually in a disk partition).
> +\fIdevice\fP is the special file corresponding to the device (e.g.
> +\fI/dev/sdXX\fP).
> +
> +Current version only supports expanding the prebuilt filesystem.
> +
> +.PP
> +The exit code returned by
> +.B resize.f2fs
> +is 0 on success and -1 on failure.
> +.SH OPTIONS
> +.TP
> +.BI \-t " target sectors"
> +Specify the size in sectors.
> +.TP
> +.BI \-d " debug-level"
> +Specify the level of debugging options.
> +The default number is 0, which shows basic debugging messages.
> +.TP
> +.SH AUTHOR
> +This version of
> +.B resize.f2fs
> +has been written by Jaegeuk Kim <jaegeuk@kernel.org>.
> +.SH AVAILABILITY
> +.B resize.f2fs
> +is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
> +.SH SEE ALSO
> +.BR mkfs.f2fs(8),
> +.BR fsck.f2fs(8),
> +.BR dump.f2fs(8),
> +.BR defrag.f2fs(8).
>


------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z

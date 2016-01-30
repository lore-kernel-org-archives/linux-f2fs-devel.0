From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH 1/4] f2fs-tools: simplify get_{sb|cp} and
 set_{sb|cp}
Date: Fri, 29 Jan 2016 17:46:12 -0800
Message-ID: <20160130014612.GA81968@jaegeuk.gateway>
References: <1454145399-30713-1-git-send-email-shengyong1@huawei.com>
	<1454145399-30713-2-git-send-email-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aPKcP-0005mf-4H
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:46:29 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aPKcL-0001KY-Cx for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 30 Jan 2016 01:46:29 +0000
Content-Disposition: inline
In-Reply-To: <1454145399-30713-2-git-send-email-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Sheng,

This is not a good way.
You're asking to change all the pending patches as well.

Why not just adding two definitions like these?

#define get_sb(member)		get_val(sb, member)
#define set_sb(member, val)	set_sb(sb, member, val)
#define get_cp(member)		get_val(cp, member)
#define set_cp(member, val)	set_sb(cp, member, val)

Thanks,

On Sat, Jan 30, 2016 at 09:16:36AM +0000, Sheng Yong wrote:
> * Remove dumplicated definitions of get_{sb|cp} and set_{sb|cp}, and introduce
>   micros get_val and set_val instead.
> * Add a new parameter to get_val and set_val so that they are not depended on
>   implied definition of `sb' and `cp'.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/fsck.c        |  20 ++---
>  fsck/main.c        |   8 +-
>  fsck/mount.c       | 146 ++++++++++++++++-----------------
>  include/f2fs_fs.h  |  84 +++++++------------
>  mkfs/f2fs_format.c | 234 ++++++++++++++++++++++++++---------------------------
>  5 files changed, 232 insertions(+), 260 deletions(-)
> 
> diff --git a/fsck/fsck.c b/fsck/fsck.c
> index e7dd02f..4fbb56d 100644
> --- a/fsck/fsck.c
> +++ b/fsck/fsck.c
> @@ -1191,7 +1191,7 @@ void fsck_chk_orphan_node(struct f2fs_sb_info *sbi)
>  	if (!is_set_ckpt_flags(F2FS_CKPT(sbi), CP_ORPHAN_PRESENT_FLAG))
>  		return;
>  
> -	start_blk = __start_cp_addr(sbi) + 1 + get_sb(cp_payload);
> +	start_blk = __start_cp_addr(sbi) + 1 + get_val(sb, cp_payload);
>  	orphan_blkaddr = __start_sum_addr(sbi) - 1;
>  
>  	orphan_blk = calloc(BLOCK_SZ, 1);
> @@ -1324,25 +1324,25 @@ static void fix_checkpoint(struct f2fs_sb_info *sbi)
>  		flags |= CP_ORPHAN_PRESENT_FLAG;
>  	}
>  
> -	set_cp(ckpt_flags, flags);
> -	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
> +	set_val(cp, ckpt_flags, flags);
> +	set_val(cp, cp_pack_total_block_count, 8 + orphan_blks + get_val(sb, cp_payload));
>  
> -	set_cp(free_segment_count, fsck->chk.free_segs);
> -	set_cp(valid_block_count, fsck->chk.valid_blk_cnt);
> -	set_cp(valid_node_count, fsck->chk.valid_node_cnt);
> -	set_cp(valid_inode_count, fsck->chk.valid_inode_cnt);
> +	set_val(cp, free_segment_count, fsck->chk.free_segs);
> +	set_val(cp, valid_block_count, fsck->chk.valid_blk_cnt);
> +	set_val(cp, valid_node_count, fsck->chk.valid_node_cnt);
> +	set_val(cp, valid_inode_count, fsck->chk.valid_inode_cnt);
>  
>  	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
>  
> -	cp_blk_no = get_sb(cp_blkaddr);
> +	cp_blk_no = get_val(sb, cp_blkaddr);
>  	if (sbi->cur_cp == 2)
> -		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +		cp_blk_no += 1 << get_val(sb, log_blocks_per_seg);
>  
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
>  
> -	for (i = 0; i < get_sb(cp_payload); i++) {
> +	for (i = 0; i < get_val(sb, cp_payload); i++) {
>  		ret = dev_write_block(((unsigned char *)cp) + i * F2FS_BLKSIZE,
>  								cp_blk_no++);
>  		ASSERT(ret >= 0);
> diff --git a/fsck/main.c b/fsck/main.c
> index 54dbb2d..7fcaa5d 100644
> --- a/fsck/main.c
> +++ b/fsck/main.c
> @@ -255,7 +255,7 @@ static int do_defrag(struct f2fs_sb_info *sbi)
>  {
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  
> -	if (config.defrag_start > get_sb(block_count))
> +	if (config.defrag_start > get_val(sb, block_count))
>  		goto out_range;
>  	if (config.defrag_start < SM_I(sbi)->main_blkaddr)
>  		config.defrag_start = SM_I(sbi)->main_blkaddr;
> @@ -263,8 +263,8 @@ static int do_defrag(struct f2fs_sb_info *sbi)
>  	if (config.defrag_len == 0)
>  		config.defrag_len = sbi->blocks_per_seg;
>  
> -	if (config.defrag_start + config.defrag_len > get_sb(block_count))
> -		config.defrag_len = get_sb(block_count) - config.defrag_start;
> +	if (config.defrag_start + config.defrag_len > get_val(sb, block_count))
> +		config.defrag_len = get_val(sb, block_count) - config.defrag_start;
>  
>  	if (config.defrag_target == 0) {
>  		config.defrag_target = config.defrag_start - 1;
> @@ -273,7 +273,7 @@ static int do_defrag(struct f2fs_sb_info *sbi)
>  	}
>  
>  	if (config.defrag_target < SM_I(sbi)->main_blkaddr ||
> -			config.defrag_target > get_sb(block_count))
> +			config.defrag_target > get_val(sb, block_count))
>  		goto out_range;
>  	if (config.defrag_target >= config.defrag_start &&
>  		config.defrag_target < config.defrag_start + config.defrag_len)
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 4c807f9..6e6d230 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -269,21 +269,21 @@ int sanity_check_raw_super(struct f2fs_super_block *sb)
>  {
>  	unsigned int blocksize;
>  
> -	if (F2FS_SUPER_MAGIC != get_sb(magic))
> +	if (F2FS_SUPER_MAGIC != get_val(sb, magic))
>  		return -1;
>  
>  	if (F2FS_BLKSIZE != PAGE_CACHE_SIZE)
>  		return -1;
>  
> -	blocksize = 1 << get_sb(log_blocksize);
> +	blocksize = 1 << get_val(sb, log_blocksize);
>  	if (F2FS_BLKSIZE != blocksize)
>  		return -1;
>  
> -	if (get_sb(log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
> -			get_sb(log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
> +	if (get_val(sb, log_sectorsize) > F2FS_MAX_LOG_SECTOR_SIZE ||
> +			get_val(sb, log_sectorsize) < F2FS_MIN_LOG_SECTOR_SIZE)
>  		return -1;
>  
> -	if (get_sb(log_sectors_per_block) + get_sb(log_sectorsize) !=
> +	if (get_val(sb, log_sectors_per_block) + get_val(sb, log_sectorsize) !=
>  						F2FS_MAX_LOG_SECTOR_SIZE)
>  		return -1;
>  
> @@ -350,22 +350,22 @@ int init_sb_info(struct f2fs_sb_info *sbi)
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  	u64 total_sectors;
>  
> -	sbi->log_sectors_per_block = get_sb(log_sectors_per_block);
> -	sbi->log_blocksize = get_sb(log_blocksize);
> +	sbi->log_sectors_per_block = get_val(sb, log_sectors_per_block);
> +	sbi->log_blocksize = get_val(sb, log_blocksize);
>  	sbi->blocksize = 1 << sbi->log_blocksize;
> -	sbi->log_blocks_per_seg = get_sb(log_blocks_per_seg);
> +	sbi->log_blocks_per_seg = get_val(sb, log_blocks_per_seg);
>  	sbi->blocks_per_seg = 1 << sbi->log_blocks_per_seg;
> -	sbi->segs_per_sec = get_sb(segs_per_sec);
> -	sbi->secs_per_zone = get_sb(secs_per_zone);
> -	sbi->total_sections = get_sb(section_count);
> -	sbi->total_node_count = (get_sb(segment_count_nat) / 2) *
> +	sbi->segs_per_sec = get_val(sb, segs_per_sec);
> +	sbi->secs_per_zone = get_val(sb, secs_per_zone);
> +	sbi->total_sections = get_val(sb, section_count);
> +	sbi->total_node_count = (get_val(sb, segment_count_nat) / 2) *
>  				sbi->blocks_per_seg * NAT_ENTRY_PER_BLOCK;
> -	sbi->root_ino_num = get_sb(root_ino);
> -	sbi->node_ino_num = get_sb(node_ino);
> -	sbi->meta_ino_num = get_sb(meta_ino);
> +	sbi->root_ino_num = get_val(sb, root_ino);
> +	sbi->node_ino_num = get_val(sb, node_ino);
> +	sbi->meta_ino_num = get_val(sb, meta_ino);
>  	sbi->cur_victim_sec = NULL_SEGNO;
>  
> -	total_sectors = get_sb(block_count) << sbi->log_sectors_per_block;
> +	total_sectors = get_val(sb, block_count) << sbi->log_sectors_per_block;
>  	MSG(0, "Info: total FS sectors = %"PRIu64" (%"PRIu64" MB)\n",
>  				total_sectors, total_sectors >> 11);
>  	return 0;
> @@ -387,7 +387,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
>  		return NULL;
>  
>  	cp = (struct f2fs_checkpoint *)cp_page_1;
> -	crc_offset = get_cp(checksum_offset);
> +	crc_offset = get_val(cp, checksum_offset);
>  	if (crc_offset >= blk_size)
>  		goto invalid_cp1;
>  
> @@ -395,17 +395,17 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
>  	if (f2fs_crc_valid(crc, cp, crc_offset))
>  		goto invalid_cp1;
>  
> -	pre_version = get_cp(checkpoint_ver);
> +	pre_version = get_val(cp, checkpoint_ver);
>  
>  	/* Read the 2nd cp block in this CP pack */
>  	cp_page_2 = malloc(PAGE_SIZE);
> -	cp_addr += get_cp(cp_pack_total_block_count) - 1;
> +	cp_addr += get_val(cp, cp_pack_total_block_count) - 1;
>  
>  	if (dev_read_block(cp_page_2, cp_addr) < 0)
>  		goto invalid_cp2;
>  
>  	cp = (struct f2fs_checkpoint *)cp_page_2;
> -	crc_offset = get_cp(checksum_offset);
> +	crc_offset = get_val(cp, checksum_offset);
>  	if (crc_offset >= blk_size)
>  		goto invalid_cp2;
>  
> @@ -413,7 +413,7 @@ void *validate_checkpoint(struct f2fs_sb_info *sbi, block_t cp_addr,
>  	if (f2fs_crc_valid(crc, cp, crc_offset))
>  		goto invalid_cp2;
>  
> -	cur_version = get_cp(checkpoint_ver);
> +	cur_version = get_val(cp, checkpoint_ver);
>  
>  	if (cur_version == pre_version) {
>  		*version = cur_version;
> @@ -435,7 +435,7 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  	unsigned long blk_size = sbi->blocksize;
>  	unsigned long long cp1_version = 0, cp2_version = 0, version;
>  	unsigned long long cp_start_blk_no;
> -	unsigned int cp_blks = 1 + get_sb(cp_payload);
> +	unsigned int cp_blks = 1 + get_val(sb, cp_payload);
>  	int ret;
>  
>  	sbi->ckpt = malloc(cp_blks * blk_size);
> @@ -445,11 +445,11 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  	 * Finding out valid cp block involves read both
>  	 * sets( cp pack1 and cp pack 2)
>  	 */
> -	cp_start_blk_no = get_sb(cp_blkaddr);
> +	cp_start_blk_no = get_val(sb, cp_blkaddr);
>  	cp1 = validate_checkpoint(sbi, cp_start_blk_no, &cp1_version);
>  
>  	/* The second checkpoint pack should start at the next segment */
> -	cp_start_blk_no += 1 << get_sb(log_blocks_per_seg);
> +	cp_start_blk_no += 1 << get_val(sb, log_blocks_per_seg);
>  	cp2 = validate_checkpoint(sbi, cp_start_blk_no, &cp2_version);
>  
>  	if (cp1 && cp2) {
> @@ -481,9 +481,9 @@ int get_valid_checkpoint(struct f2fs_sb_info *sbi)
>  		unsigned int i;
>  		unsigned long long cp_blk_no;
>  
> -		cp_blk_no = get_sb(cp_blkaddr);
> +		cp_blk_no = get_val(sb, cp_blkaddr);
>  		if (cur_page == cp2)
> -			cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +			cp_blk_no += 1 << get_val(sb, log_blocks_per_seg);
>  
>  		/* copy sit bitmap */
>  		for (i = 1; i < cp_blks; i++) {
> @@ -510,12 +510,12 @@ int sanity_check_ckpt(struct f2fs_sb_info *sbi)
>  	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
>  	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
>  
> -	total = get_sb(segment_count);
> -	fsmeta = get_sb(segment_count_ckpt);
> -	fsmeta += get_sb(segment_count_sit);
> -	fsmeta += get_sb(segment_count_nat);
> -	fsmeta += get_cp(rsvd_segment_count);
> -	fsmeta += get_sb(segment_count_ssa);
> +	total = get_val(sb, segment_count);
> +	fsmeta = get_val(sb, segment_count_ckpt);
> +	fsmeta += get_val(sb, segment_count_sit);
> +	fsmeta += get_val(sb, segment_count_nat);
> +	fsmeta += get_val(cp, rsvd_segment_count);
> +	fsmeta += get_val(sb, segment_count_ssa);
>  
>  	if (fsmeta >= total)
>  		return 1;
> @@ -531,16 +531,16 @@ int init_node_manager(struct f2fs_sb_info *sbi)
>  	unsigned char *version_bitmap;
>  	unsigned int nat_segs, nat_blocks;
>  
> -	nm_i->nat_blkaddr = get_sb(nat_blkaddr);
> +	nm_i->nat_blkaddr = get_val(sb, nat_blkaddr);
>  
>  	/* segment_count_nat includes pair segment so divide to 2. */
> -	nat_segs = get_sb(segment_count_nat) >> 1;
> -	nat_blocks = nat_segs << get_sb(log_blocks_per_seg);
> +	nat_segs = get_val(sb, segment_count_nat) >> 1;
> +	nat_blocks = nat_segs << get_val(sb, log_blocks_per_seg);
>  	nm_i->max_nid = NAT_ENTRY_PER_BLOCK * nat_blocks;
>  	nm_i->fcnt = 0;
>  	nm_i->nat_cnt = 0;
> -	nm_i->init_scan_nid = get_cp(next_free_nid);
> -	nm_i->next_scan_nid = get_cp(next_free_nid);
> +	nm_i->init_scan_nid = get_val(cp, next_free_nid);
> +	nm_i->next_scan_nid = get_val(cp, next_free_nid);
>  
>  	nm_i->bitmap_size = __bitmap_size(sbi, NAT_BITMAP);
>  
> @@ -597,21 +597,21 @@ int build_sit_info(struct f2fs_sb_info *sbi)
>  			return -ENOMEM;
>  	}
>  
> -	sit_segs = get_sb(segment_count_sit) >> 1;
> +	sit_segs = get_val(sb, segment_count_sit) >> 1;
>  	bitmap_size = __bitmap_size(sbi, SIT_BITMAP);
>  	src_bitmap = __bitmap_ptr(sbi, SIT_BITMAP);
>  
>  	dst_bitmap = malloc(bitmap_size);
>  	memcpy(dst_bitmap, src_bitmap, bitmap_size);
>  
> -	sit_i->sit_base_addr = get_sb(sit_blkaddr);
> +	sit_i->sit_base_addr = get_val(sb, sit_blkaddr);
>  	sit_i->sit_blocks = sit_segs << sbi->log_blocks_per_seg;
> -	sit_i->written_valid_blocks = get_cp(valid_block_count);
> +	sit_i->written_valid_blocks = get_val(cp, valid_block_count);
>  	sit_i->sit_bitmap = dst_bitmap;
>  	sit_i->bitmap_size = bitmap_size;
>  	sit_i->dirty_sentries = 0;
>  	sit_i->sents_per_block = SIT_ENTRY_PER_BLOCK;
> -	sit_i->elapsed_time = get_cp(elapsed_time);
> +	sit_i->elapsed_time = get_val(cp, elapsed_time);
>  	return 0;
>  }
>  
> @@ -716,13 +716,13 @@ static void read_normal_summaries(struct f2fs_sb_info *sbi, int type)
>  	int ret;
>  
>  	if (IS_DATASEG(type)) {
> -		segno = get_cp(cur_data_segno[type]);
> +		segno = get_val(cp, cur_data_segno[type]);
>  		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
>  			blk_addr = sum_blk_addr(sbi, NR_CURSEG_TYPE, type);
>  		else
>  			blk_addr = sum_blk_addr(sbi, NR_CURSEG_DATA_TYPE, type);
>  	} else {
> -		segno = get_cp(cur_node_segno[type - CURSEG_HOT_NODE]);
> +		segno = get_val(cp, cur_node_segno[type - CURSEG_HOT_NODE]);
>  		if (is_set_ckpt_flags(cp, CP_UMOUNT_FLAG))
>  			blk_addr = sum_blk_addr(sbi, NR_CURSEG_NODE_TYPE,
>  							type - CURSEG_HOT_NODE);
> @@ -803,12 +803,12 @@ static void build_curseg(struct f2fs_sb_info *sbi)
>  		array[i].sum_blk = malloc(PAGE_CACHE_SIZE);
>  		ASSERT(array[i].sum_blk);
>  		if (i <= CURSEG_COLD_DATA) {
> -			blk_off = get_cp(cur_data_blkoff[i]);
> -			segno = get_cp(cur_data_segno[i]);
> +			blk_off = get_val(cp, cur_data_blkoff[i]);
> +			segno = get_val(cp, cur_data_segno[i]);
>  		}
>  		if (i > CURSEG_COLD_DATA) {
> -			blk_off = get_cp(cur_node_blkoff[i - CURSEG_HOT_NODE]);
> -			segno = get_cp(cur_node_segno[i - CURSEG_HOT_NODE]);
> +			blk_off = get_val(cp, cur_node_blkoff[i - CURSEG_HOT_NODE]);
> +			segno = get_val(cp, cur_node_segno[i - CURSEG_HOT_NODE]);
>  		}
>  		array[i].segno = segno;
>  		array[i].zone = GET_ZONENO_FROM_SEGNO(sbi, segno);
> @@ -924,7 +924,7 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
>  
>  	ssa_blk = GET_SUM_BLKADDR(sbi, segno);
>  	for (type = 0; type < NR_CURSEG_NODE_TYPE; type++) {
> -		if (segno == get_cp(cur_node_segno[type])) {
> +		if (segno == get_val(cp, cur_node_segno[type])) {
>  			curseg = CURSEG_I(sbi, CURSEG_HOT_NODE + type);
>  			if (!IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
>  				ASSERT_MSG("segno [0x%x] indicates a data "
> @@ -939,7 +939,7 @@ struct f2fs_summary_block *get_sum_block(struct f2fs_sb_info *sbi,
>  	}
>  
>  	for (type = 0; type < NR_CURSEG_DATA_TYPE; type++) {
> -		if (segno == get_cp(cur_data_segno[type])) {
> +		if (segno == get_val(cp, cur_data_segno[type])) {
>  			curseg = CURSEG_I(sbi, type);
>  			if (IS_SUM_NODE_SEG(curseg->sum_blk->footer)) {
>  				ASSERT_MSG("segno [0x%x] indicates a node "
> @@ -1151,13 +1151,13 @@ int build_segment_manager(struct f2fs_sb_info *sbi)
>  
>  	/* init sm info */
>  	sbi->sm_info = sm_info;
> -	sm_info->seg0_blkaddr = get_sb(segment0_blkaddr);
> -	sm_info->main_blkaddr = get_sb(main_blkaddr);
> -	sm_info->segment_count = get_sb(segment_count);
> -	sm_info->reserved_segments = get_cp(rsvd_segment_count);
> -	sm_info->ovp_segments = get_cp(overprov_segment_count);
> -	sm_info->main_segments = get_sb(segment_count_main);
> -	sm_info->ssa_blkaddr = get_sb(ssa_blkaddr);
> +	sm_info->seg0_blkaddr = get_val(sb, segment0_blkaddr);
> +	sm_info->main_blkaddr = get_val(sb, main_blkaddr);
> +	sm_info->segment_count = get_val(sb, segment_count);
> +	sm_info->reserved_segments = get_val(cp, rsvd_segment_count);
> +	sm_info->ovp_segments = get_val(cp, overprov_segment_count);
> +	sm_info->main_segments = get_val(sb, segment_count_main);
> +	sm_info->ssa_blkaddr = get_val(sb, ssa_blkaddr);
>  
>  	build_sit_info(sbi);
>  
> @@ -1384,7 +1384,7 @@ void flush_sit_entries(struct f2fs_sb_info *sbi)
>  			free_segs++;
>  	}
>  
> -	set_cp(free_segment_count, free_segs);
> +	set_val(cp, free_segment_count, free_segs);
>  }
>  
>  int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left, int type)
> @@ -1487,14 +1487,14 @@ void write_curseg_info(struct f2fs_sb_info *sbi)
>  	for (i = 0; i < NO_CHECK_TYPE; i++) {
>  		cp->alloc_type[i] = CURSEG_I(sbi, i)->alloc_type;
>  		if (i < CURSEG_HOT_NODE) {
> -			set_cp(cur_data_segno[i], CURSEG_I(sbi, i)->segno);
> -			set_cp(cur_data_blkoff[i],
> +			set_val(cp, cur_data_segno[i], CURSEG_I(sbi, i)->segno);
> +			set_val(cp, cur_data_blkoff[i],
>  					CURSEG_I(sbi, i)->next_blkoff);
>  		} else {
>  			int n = i - CURSEG_HOT_NODE;
>  
> -			set_cp(cur_node_segno[n], CURSEG_I(sbi, i)->segno);
> -			set_cp(cur_node_blkoff[n],
> +			set_val(cp, cur_node_segno[n], CURSEG_I(sbi, i)->segno);
> +			set_val(cp, cur_node_blkoff[n],
>  					CURSEG_I(sbi, i)->next_blkoff);
>  		}
>  	}
> @@ -1578,24 +1578,24 @@ void write_checkpoint(struct f2fs_sb_info *sbi)
>  		flags |= CP_ORPHAN_PRESENT_FLAG;
>  	}
>  
> -	set_cp(ckpt_flags, flags);
> +	set_val(cp, ckpt_flags, flags);
>  
> -	set_cp(free_segment_count, get_free_segments(sbi));
> -	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_sb(cp_payload));
> +	set_val(cp, free_segment_count, get_free_segments(sbi));
> +	set_val(cp, cp_pack_total_block_count, 8 + orphan_blks + get_val(sb, cp_payload));
>  
>  	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
>  
> -	cp_blk_no = get_sb(cp_blkaddr);
> +	cp_blk_no = get_val(sb, cp_blkaddr);
>  	if (sbi->cur_cp == 2)
> -		cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> +		cp_blk_no += 1 << get_val(sb, log_blocks_per_seg);
>  
>  	/* write the first cp */
>  	ret = dev_write_block(cp, cp_blk_no++);
>  	ASSERT(ret >= 0);
>  
>  	/* skip payload */
> -	cp_blk_no += get_sb(cp_payload);
> +	cp_blk_no += get_val(sb, cp_payload);
>  	/* skip orphan blocks */
>  	cp_blk_no += orphan_blks;
>  
> @@ -1635,7 +1635,7 @@ void build_nat_area_bitmap(struct f2fs_sb_info *sbi)
>  	ASSERT(nat_block);
>  
>  	/* Alloc & build nat entry bitmap */
> -	nr_nat_blks = (get_sb(segment_count_nat) / 2) <<
> +	nr_nat_blks = (get_val(sb, segment_count_nat) / 2) <<
>  					sbi->log_blocks_per_seg;
>  
>  	fsck->nr_nat_entries = nr_nat_blks * NAT_ENTRY_PER_BLOCK;
> @@ -1731,7 +1731,7 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  	print_ckpt_info(sbi);
>  
>  	if (config.auto_fix) {
> -		u32 flag = get_cp(ckpt_flags);
> +		u32 flag = get_val(cp, ckpt_flags);
>  
>  		if (flag & CP_FSCK_FLAG)
>  			config.fix_on = 1;
> @@ -1741,10 +1741,10 @@ int f2fs_do_mount(struct f2fs_sb_info *sbi)
>  
>  	config.bug_on = 0;
>  
> -	sbi->total_valid_node_count = get_cp(valid_node_count);
> -	sbi->total_valid_inode_count = get_cp(valid_inode_count);
> -	sbi->user_block_count = get_cp(user_block_count);
> -	sbi->total_valid_block_count = get_cp(valid_block_count);
> +	sbi->total_valid_node_count = get_val(cp, valid_node_count);
> +	sbi->total_valid_inode_count = get_val(cp, valid_inode_count);
> +	sbi->user_block_count = get_val(cp, user_block_count);
> +	sbi->total_valid_block_count = get_val(cp, valid_block_count);
>  	sbi->last_valid_block_count = sbi->total_valid_block_count;
>  	sbi->alloc_valid_block_count = 0;
>  
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index e1eeb6e..2ab9f49 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -270,60 +270,32 @@ struct f2fs_configuration {
>  #define BIT_MASK(nr)	(1 << (nr % BITS_PER_LONG))
>  #define BIT_WORD(nr)	(nr / BITS_PER_LONG)
>  
> -#define set_sb_le64(member, val)		(sb->member = cpu_to_le64(val))
> -#define set_sb_le32(member, val)		(sb->member = cpu_to_le32(val))
> -#define set_sb_le16(member, val)		(sb->member = cpu_to_le16(val))
> -#define get_sb_le64(member)			le64_to_cpu(sb->member)
> -#define get_sb_le32(member)			le32_to_cpu(sb->member)
> -#define get_sb_le16(member)			le16_to_cpu(sb->member)
> -
> -#define set_sb(member, val)	\
> -			do {						\
> -				typeof(sb->member) t;			\
> -				switch (sizeof(t)) {			\
> -				case 8: set_sb_le64(member, val); break; \
> -				case 4: set_sb_le32(member, val); break; \
> -				case 2: set_sb_le16(member, val); break; \
> -				} \
> +#define set_le64(ptr, member, val)		((ptr)->member = cpu_to_le64(val))
> +#define set_le32(ptr, member, val)		((ptr)->member = cpu_to_le32(val))
> +#define set_le16(ptr, member, val)		((ptr)->member = cpu_to_le16(val))
> +#define get_le64(ptr, member)			le64_to_cpu((ptr)->member)
> +#define get_le32(ptr, member)			le32_to_cpu((ptr)->member)
> +#define get_le16(ptr, member)			le16_to_cpu((ptr)->member)
> +
> +#define set_val(ptr, member, val)					   \
> +			do {						   \
> +				typeof((ptr)->member) t;		   \
> +				switch (sizeof(t)) {			   \
> +				case 8: set_le64(ptr, member, val); break; \
> +				case 4: set_le32(ptr, member, val); break; \
> +				case 2: set_le16(ptr, member, val); break; \
> +				}					   \
>  			} while(0)
>  
> -#define get_sb(member)		\
> -			({						\
> -				typeof(sb->member) t;			\
> -				switch (sizeof(t)) {			\
> -				case 8: t = get_sb_le64(member); break; \
> -				case 4: t = get_sb_le32(member); break; \
> -				case 2: t = get_sb_le16(member); break; \
> -				} 					\
> -				t; \
> -			})
> -
> -#define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
> -#define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
> -#define set_cp_le16(member, val)		(cp->member = cpu_to_le16(val))
> -#define get_cp_le64(member)			le64_to_cpu(cp->member)
> -#define get_cp_le32(member)			le32_to_cpu(cp->member)
> -#define get_cp_le16(member)			le16_to_cpu(cp->member)
> -
> -#define set_cp(member, val)	\
> -			do {						\
> -				typeof(cp->member) t;			\
> -				switch (sizeof(t)) {			\
> -				case 8: set_cp_le64(member, val); break; \
> -				case 4: set_cp_le32(member, val); break; \
> -				case 2: set_cp_le16(member, val); break; \
> -				} \
> -			} while(0)
> -
> -#define get_cp(member)		\
> -			({						\
> -				typeof(cp->member) t;			\
> -				switch (sizeof(t)) {			\
> -				case 8: t = get_cp_le64(member); break; \
> -				case 4: t = get_cp_le32(member); break; \
> -				case 2: t = get_cp_le16(member); break; \
> -				} 					\
> -				t; \
> +#define get_val(ptr, member)						  \
> +			({						  \
> +				typeof((ptr)->member) t;		  \
> +				switch (sizeof(t)) {			  \
> +				case 8: t = get_le64(ptr, member); break; \
> +				case 4: t = get_le32(ptr, member); break; \
> +				case 2: t = get_le16(ptr, member); break; \
> +				} 					  \
> +				t;					  \
>  			})
>  
>  /*
> @@ -899,7 +871,7 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
>  	double reserved, ovp, candidate, end, diff, space;
>  	double max_ovp = 0, max_space = 0;
>  
> -	if (get_sb(segment_count_main) < 256) {
> +	if (get_val(sb, segment_count_main) < 256) {
>  		candidate = 10;
>  		end = 95;
>  		diff = 5;
> @@ -911,9 +883,9 @@ static inline double get_best_overprovision(struct f2fs_super_block *sb)
>  
>  	for (; candidate <= end; candidate += diff) {
>  		reserved = (2 * (100 / candidate + 1) + 6) *
> -						get_sb(segs_per_sec);
> -		ovp = (get_sb(segment_count_main) - reserved) * candidate / 100;
> -		space = get_sb(segment_count_main) - reserved - ovp;
> +						get_val(sb, segs_per_sec);
> +		ovp = (get_val(sb, segment_count_main) - reserved) * candidate / 100;
> +		space = get_val(sb, segment_count_main) - reserved - ovp;
>  		if (max_space < space) {
>  			max_space = space;
>  			max_ovp = candidate;
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 645c2aa..db5348e 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -83,7 +83,7 @@ static void configure_extension_list(void)
>  	int name_len;
>  	int i = 0;
>  
> -	set_sb(extension_count, 0);
> +	set_val(sb, extension_count, 0);
>  	memset(sb->extension_list, 0, sizeof(sb->extension_list));
>  
>  	while (*extlist) {
> @@ -91,7 +91,7 @@ static void configure_extension_list(void)
>  		memcpy(sb->extension_list[i++], *extlist, name_len);
>  		extlist++;
>  	}
> -	set_sb(extension_count, i);
> +	set_val(sb, extension_count, i);
>  
>  	if (!ext_str)
>  		return;
> @@ -112,7 +112,7 @@ next:
>  			break;
>  	}
>  
> -	set_sb(extension_count, i);
> +	set_val(sb, extension_count, i);
>  
>  	free(config.extension_list);
>  }
> @@ -132,23 +132,23 @@ static int f2fs_prepare_super_block(void)
>  	u_int32_t max_nat_bitmap_size, max_nat_segments;
>  	u_int32_t total_zones;
>  
> -	set_sb(magic, F2FS_SUPER_MAGIC);
> -	set_sb(major_ver, F2FS_MAJOR_VERSION);
> -	set_sb(minor_ver, F2FS_MINOR_VERSION);
> +	set_val(sb, magic, F2FS_SUPER_MAGIC);
> +	set_val(sb, major_ver, F2FS_MAJOR_VERSION);
> +	set_val(sb, minor_ver, F2FS_MINOR_VERSION);
>  
>  	log_sectorsize = log_base_2(config.sector_size);
>  	log_sectors_per_block = log_base_2(config.sectors_per_blk);
>  	log_blocksize = log_sectorsize + log_sectors_per_block;
>  	log_blks_per_seg = log_base_2(config.blks_per_seg);
>  
> -	set_sb(log_sectorsize, log_sectorsize);
> -	set_sb(log_sectors_per_block, log_sectors_per_block);
> +	set_val(sb, log_sectorsize, log_sectorsize);
> +	set_val(sb, log_sectors_per_block, log_sectors_per_block);
>  
> -	set_sb(log_blocksize, log_blocksize);
> -	set_sb(log_blocks_per_seg, log_blks_per_seg);
> +	set_val(sb, log_blocksize, log_blocksize);
> +	set_val(sb, log_blocks_per_seg, log_blks_per_seg);
>  
> -	set_sb(segs_per_sec, config.segs_per_sec);
> -	set_sb(secs_per_zone, config.secs_per_zone);
> +	set_val(sb, segs_per_sec, config.segs_per_sec);
> +	set_val(sb, secs_per_zone, config.secs_per_zone);
>  
>  	blk_size_bytes = 1 << log_blocksize;
>  	segment_size_bytes = blk_size_bytes * config.blks_per_seg;
> @@ -156,9 +156,9 @@ static int f2fs_prepare_super_block(void)
>  		blk_size_bytes * config.secs_per_zone *
>  		config.segs_per_sec * config.blks_per_seg;
>  
> -	set_sb(checksum_offset, 0);
> +	set_val(sb, checksum_offset, 0);
>  
> -	set_sb(block_count, config.total_sectors >> log_sectors_per_block);
> +	set_val(sb, block_count, config.total_sectors >> log_sectors_per_block);
>  
>  	zone_align_start_offset =
>  		(config.start_sector * config.sector_size +
> @@ -174,41 +174,41 @@ static int f2fs_prepare_super_block(void)
>  				config.sectors_per_blk);
>  	}
>  
> -	set_sb(segment_count, (config.total_sectors * config.sector_size -
> +	set_val(sb, segment_count, (config.total_sectors * config.sector_size -
>  				zone_align_start_offset) / segment_size_bytes);
>  
> -	set_sb(segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
> +	set_val(sb, segment0_blkaddr, zone_align_start_offset / blk_size_bytes);
>  	sb->cp_blkaddr = sb->segment0_blkaddr;
>  
> -	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_sb(segment0_blkaddr));
> +	MSG(0, "Info: zone aligned segment0 blkaddr: %u\n", get_val(sb, segment0_blkaddr));
>  
> -	set_sb(segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
> +	set_val(sb, segment_count_ckpt, F2FS_NUMBER_OF_CHECKPOINT_PACK);
>  
> -	set_sb(sit_blkaddr, get_sb(segment0_blkaddr) + get_sb(segment_count_ckpt) *
> +	set_val(sb, sit_blkaddr, get_val(sb, segment0_blkaddr) + get_val(sb, segment_count_ckpt) *
>  			config.blks_per_seg);
>  
> -	blocks_for_sit = ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
> +	blocks_for_sit = ALIGN(get_val(sb, segment_count), SIT_ENTRY_PER_BLOCK);
>  
>  	sit_segments = SEG_ALIGN(blocks_for_sit);
>  
> -	set_sb(segment_count_sit, sit_segments * 2);
> +	set_val(sb, segment_count_sit, sit_segments * 2);
>  
> -	set_sb(nat_blkaddr, get_sb(sit_blkaddr) + get_sb(segment_count_sit) *
> +	set_val(sb, nat_blkaddr, get_val(sb, sit_blkaddr) + get_val(sb, segment_count_sit) *
>  			config.blks_per_seg);
>  
> -	total_valid_blks_available = (get_sb(segment_count) -
> -			(get_sb(segment_count_ckpt) + get_sb(segment_count_sit))) *
> +	total_valid_blks_available = (get_val(sb, segment_count) -
> +			(get_val(sb, segment_count_ckpt) + get_val(sb, segment_count_sit))) *
>  			config.blks_per_seg;
>  
>  	blocks_for_nat = ALIGN(total_valid_blks_available, NAT_ENTRY_PER_BLOCK);
>  
> -	set_sb(segment_count_nat, SEG_ALIGN(blocks_for_nat));
> +	set_val(sb, segment_count_nat, SEG_ALIGN(blocks_for_nat));
>  	/*
>  	 * The number of node segments should not be exceeded a "Threshold".
>  	 * This number resizes NAT bitmap area in a CP page.
>  	 * So the threshold is determined not to overflow one CP page
>  	 */
> -	sit_bitmap_size = ((get_sb(segment_count_sit) / 2) <<
> +	sit_bitmap_size = ((get_val(sb, segment_count_sit) / 2) <<
>  				log_blks_per_seg) / 8;
>  
>  	if (sit_bitmap_size > MAX_SIT_BITMAP_SIZE)
> @@ -223,55 +223,55 @@ static int f2fs_prepare_super_block(void)
>  	if (max_sit_bitmap_size >
>  			(CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1 - 64)) {
>  		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1;
> -		set_sb(cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
> +		set_val(sb, cp_payload, F2FS_BLK_ALIGN(max_sit_bitmap_size));
>  	} else {
>  		max_nat_bitmap_size = CHECKSUM_OFFSET - sizeof(struct f2fs_checkpoint) + 1
>  			- max_sit_bitmap_size;
> -		set_sb(cp_payload, 0);
> +		set_val(sb, cp_payload, 0);
>  	}
>  
>  	max_nat_segments = (max_nat_bitmap_size * 8) >> log_blks_per_seg;
>  
> -	if (get_sb(segment_count_nat) > max_nat_segments)
> -		set_sb(segment_count_nat, max_nat_segments);
> +	if (get_val(sb, segment_count_nat) > max_nat_segments)
> +		set_val(sb, segment_count_nat, max_nat_segments);
>  
> -	set_sb(segment_count_nat, get_sb(segment_count_nat) * 2);
> +	set_val(sb, segment_count_nat, get_val(sb, segment_count_nat) * 2);
>  
> -	set_sb(ssa_blkaddr, get_sb(nat_blkaddr) + get_sb(segment_count_nat) *
> +	set_val(sb, ssa_blkaddr, get_val(sb, nat_blkaddr) + get_val(sb, segment_count_nat) *
>  			config.blks_per_seg);
>  
> -	total_valid_blks_available = (get_sb(segment_count) -
> -			(get_sb(segment_count_ckpt) +
> -			get_sb(segment_count_sit) +
> -			get_sb(segment_count_nat))) *
> +	total_valid_blks_available = (get_val(sb, segment_count) -
> +			(get_val(sb, segment_count_ckpt) +
> +			get_val(sb, segment_count_sit) +
> +			get_val(sb, segment_count_nat))) *
>  			config.blks_per_seg;
>  
>  	blocks_for_ssa = total_valid_blks_available /
>  				config.blks_per_seg + 1;
>  
> -	set_sb(segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
> +	set_val(sb, segment_count_ssa, SEG_ALIGN(blocks_for_ssa));
>  
> -	total_meta_segments = get_sb(segment_count_ckpt) +
> -		get_sb(segment_count_sit) +
> -		get_sb(segment_count_nat) +
> -		get_sb(segment_count_ssa);
> +	total_meta_segments = get_val(sb, segment_count_ckpt) +
> +		get_val(sb, segment_count_sit) +
> +		get_val(sb, segment_count_nat) +
> +		get_val(sb, segment_count_ssa);
>  	diff = total_meta_segments % (config.segs_per_zone);
>  	if (diff)
> -		set_sb(segment_count_ssa, get_sb(segment_count_ssa) +
> +		set_val(sb, segment_count_ssa, get_val(sb, segment_count_ssa) +
>  			(config.segs_per_zone - diff));
>  
>  	total_meta_zones = ZONE_ALIGN(total_meta_segments *
>  						config.blks_per_seg);
>  
> -	set_sb(main_blkaddr, get_sb(segment0_blkaddr) + total_meta_zones *
> +	set_val(sb, main_blkaddr, get_val(sb, segment0_blkaddr) + total_meta_zones *
>  				config.segs_per_zone * config.blks_per_seg);
>  
> -	total_zones = get_sb(segment_count) / (config.segs_per_zone) -
> +	total_zones = get_val(sb, segment_count) / (config.segs_per_zone) -
>  							total_meta_zones;
>  
> -	set_sb(section_count, total_zones * config.secs_per_zone);
> +	set_val(sb, section_count, total_zones * config.secs_per_zone);
>  
> -	set_sb(segment_count_main, get_sb(section_count) * config.segs_per_sec);
> +	set_val(sb, segment_count_main, get_val(sb, section_count) * config.segs_per_sec);
>  
>  	/* Let's determine the best reserved and overprovisioned space */
>  	if (config.overprovision == 0)
> @@ -281,12 +281,12 @@ static int f2fs_prepare_super_block(void)
>  			(2 * (100 / config.overprovision + 1) + 6)
>  			* config.segs_per_sec;
>  
> -	if ((get_sb(segment_count_main) - 2) <
> +	if ((get_val(sb, segment_count_main) - 2) <
>  					config.reserved_segments) {
>  		MSG(1, "\tError: Device size is not sufficient for F2FS volume,\
>  			more segment needed =%u",
>  			config.reserved_segments -
> -			(get_sb(segment_count_main) - 2));
> +			(get_val(sb, segment_count_main) - 2));
>  		return -1;
>  	}
>  
> @@ -294,9 +294,9 @@ static int f2fs_prepare_super_block(void)
>  
>  	utf8_to_utf16(sb->volume_name, (const char *)config.vol_label,
>  				MAX_VOLUME_NAME, strlen(config.vol_label));
> -	set_sb(node_ino, 1);
> -	set_sb(meta_ino, 2);
> -	set_sb(root_ino, 3);
> +	set_val(sb, node_ino, 1);
> +	set_val(sb, meta_ino, 2);
> +	set_val(sb, root_ino, 3);
>  
>  	if (total_zones <= 6) {
>  		MSG(1, "\tError: %d zones: Need more zones \
> @@ -346,8 +346,8 @@ static int f2fs_init_sit_area(void)
>  	u_int64_t sit_seg_addr = 0;
>  	u_int8_t *zero_buf = NULL;
>  
> -	blk_size = 1 << get_sb(log_blocksize);
> -	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
> +	blk_size = 1 << get_val(sb, log_blocksize);
> +	seg_size = (1 << get_val(sb, log_blocks_per_seg)) * blk_size;
>  
>  	zero_buf = calloc(sizeof(u_int8_t), seg_size);
>  	if(zero_buf == NULL) {
> @@ -355,11 +355,11 @@ static int f2fs_init_sit_area(void)
>  		return -1;
>  	}
>  
> -	sit_seg_addr = get_sb(sit_blkaddr);
> +	sit_seg_addr = get_val(sb, sit_blkaddr);
>  	sit_seg_addr *= blk_size;
>  
>  	DBG(1, "\tFilling sit area at offset 0x%08"PRIx64"\n", sit_seg_addr);
> -	for (index = 0; index < (get_sb(segment_count_sit) / 2); index++) {
> +	for (index = 0; index < (get_val(sb, segment_count_sit) / 2); index++) {
>  		if (dev_fill(zero_buf, sit_seg_addr, seg_size)) {
>  			MSG(1, "\tError: While zeroing out the sit area \
>  					on disk!!!\n");
> @@ -380,8 +380,8 @@ static int f2fs_init_nat_area(void)
>  	u_int64_t nat_seg_addr = 0;
>  	u_int8_t *nat_buf = NULL;
>  
> -	blk_size = 1 << get_sb(log_blocksize);
> -	seg_size = (1 << get_sb(log_blocks_per_seg)) * blk_size;
> +	blk_size = 1 << get_val(sb, log_blocksize);
> +	seg_size = (1 << get_val(sb, log_blocks_per_seg)) * blk_size;
>  
>  	nat_buf = calloc(sizeof(u_int8_t), seg_size);
>  	if (nat_buf == NULL) {
> @@ -389,11 +389,11 @@ static int f2fs_init_nat_area(void)
>  		return -1;
>  	}
>  
> -	nat_seg_addr = get_sb(nat_blkaddr);
> +	nat_seg_addr = get_val(sb, nat_blkaddr);
>  	nat_seg_addr *= blk_size;
>  
>  	DBG(1, "\tFilling nat area at offset 0x%08"PRIx64"\n", nat_seg_addr);
> -	for (index = 0; index < get_sb(segment_count_nat) / 2; index++) {
> +	for (index = 0; index < get_val(sb, segment_count_nat) / 2; index++) {
>  		if (dev_fill(nat_buf, nat_seg_addr, seg_size)) {
>  			MSG(1, "\tError: While zeroing out the nat area \
>  					on disk!!!\n");
> @@ -445,58 +445,58 @@ static int f2fs_write_check_point_pack(void)
>  	}
>  
>  	/* 1. cp page 1 of checkpoint pack 1 */
> -	set_cp(checkpoint_ver, 1);
> -	set_cp(cur_node_segno[0], config.cur_seg[CURSEG_HOT_NODE]);
> -	set_cp(cur_node_segno[1], config.cur_seg[CURSEG_WARM_NODE]);
> -	set_cp(cur_node_segno[2], config.cur_seg[CURSEG_COLD_NODE]);
> -	set_cp(cur_data_segno[0], config.cur_seg[CURSEG_HOT_DATA]);
> -	set_cp(cur_data_segno[1], config.cur_seg[CURSEG_WARM_DATA]);
> -	set_cp(cur_data_segno[2], config.cur_seg[CURSEG_COLD_DATA]);
> +	set_val(cp, checkpoint_ver, 1);
> +	set_val(cp, cur_node_segno[0], config.cur_seg[CURSEG_HOT_NODE]);
> +	set_val(cp, cur_node_segno[1], config.cur_seg[CURSEG_WARM_NODE]);
> +	set_val(cp, cur_node_segno[2], config.cur_seg[CURSEG_COLD_NODE]);
> +	set_val(cp, cur_data_segno[0], config.cur_seg[CURSEG_HOT_DATA]);
> +	set_val(cp, cur_data_segno[1], config.cur_seg[CURSEG_WARM_DATA]);
> +	set_val(cp, cur_data_segno[2], config.cur_seg[CURSEG_COLD_DATA]);
>  	for (i = 3; i < MAX_ACTIVE_NODE_LOGS; i++) {
> -		set_cp(cur_node_segno[i], 0xffffffff);
> -		set_cp(cur_data_segno[i], 0xffffffff);
> +		set_val(cp, cur_node_segno[i], 0xffffffff);
> +		set_val(cp, cur_data_segno[i], 0xffffffff);
>  	}
>  
> -	set_cp(cur_node_blkoff[0], 1);
> -	set_cp(cur_data_blkoff[0], 1);
> -	set_cp(valid_block_count, 2);
> -	set_cp(rsvd_segment_count, config.reserved_segments);
> -	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
> -			get_cp(rsvd_segment_count)) *
> +	set_val(cp, cur_node_blkoff[0], 1);
> +	set_val(cp, cur_data_blkoff[0], 1);
> +	set_val(cp, valid_block_count, 2);
> +	set_val(cp, rsvd_segment_count, config.reserved_segments);
> +	set_val(cp, overprov_segment_count, (get_val(sb, segment_count_main) -
> +			get_val(cp, rsvd_segment_count)) *
>  			config.overprovision / 100);
> -	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
> -			get_cp(rsvd_segment_count));
> +	set_val(cp, overprov_segment_count, get_val(cp, overprov_segment_count) +
> +			get_val(cp, rsvd_segment_count));
>  
>  	MSG(0, "Info: Overprovision ratio = %.3lf%%\n", config.overprovision);
>  	MSG(0, "Info: Overprovision segments = %u (GC reserved = %u)\n",
> -					get_cp(overprov_segment_count),
> +					get_val(cp, overprov_segment_count),
>  					config.reserved_segments);
>  
>  	/* main segments - reserved segments - (node + data segments) */
> -	set_cp(free_segment_count, get_sb(segment_count_main) - 6);
> -	set_cp(user_block_count, ((get_cp(free_segment_count) + 6 -
> -			get_cp(overprov_segment_count)) * config.blks_per_seg));
> +	set_val(cp, free_segment_count, get_val(sb, segment_count_main) - 6);
> +	set_val(cp, user_block_count, ((get_val(cp, free_segment_count) + 6 -
> +			get_val(cp, overprov_segment_count)) * config.blks_per_seg));
>  	/* cp page (2), data summaries (1), node summaries (3) */
> -	set_cp(cp_pack_total_block_count, 6 + get_sb(cp_payload));
> -	set_cp(ckpt_flags, CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
> -	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
> -	set_cp(valid_node_count, 1);
> -	set_cp(valid_inode_count, 1);
> -	set_cp(next_free_nid, get_sb(root_ino) + 1);
> -	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
> -			get_sb(log_blocks_per_seg)) / 8);
> +	set_val(cp, cp_pack_total_block_count, 6 + get_val(sb, cp_payload));
> +	set_val(cp, ckpt_flags, CP_UMOUNT_FLAG | CP_COMPACT_SUM_FLAG);
> +	set_val(cp, cp_pack_start_sum, 1 + get_val(sb, cp_payload));
> +	set_val(cp, valid_node_count, 1);
> +	set_val(cp, valid_inode_count, 1);
> +	set_val(cp, next_free_nid, get_val(sb, root_ino) + 1);
> +	set_val(cp, sit_ver_bitmap_bytesize, ((get_val(sb, segment_count_sit) / 2) <<
> +			get_val(sb, log_blocks_per_seg)) / 8);
>  
> -	set_cp(nat_ver_bitmap_bytesize, ((get_sb(segment_count_nat) / 2) <<
> -			 get_sb(log_blocks_per_seg)) / 8);
> +	set_val(cp, nat_ver_bitmap_bytesize, ((get_val(sb, segment_count_nat) / 2) <<
> +			 get_val(sb, log_blocks_per_seg)) / 8);
>  
> -	set_cp(checksum_offset, CHECKSUM_OFFSET);
> +	set_val(cp, checksum_offset, CHECKSUM_OFFSET);
>  
>  	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
>  							cpu_to_le32(crc);
>  
> -	blk_size_bytes = 1 << get_sb(log_blocksize);
> -	cp_seg_blk_offset = get_sb(segment0_blkaddr);
> +	blk_size_bytes = 1 << get_val(sb, log_blocksize);
> +	cp_seg_blk_offset = get_val(sb, segment0_blkaddr);
>  	cp_seg_blk_offset *= blk_size_bytes;
>  
>  	DBG(1, "\tWriting main segments, cp at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
> @@ -505,7 +505,7 @@ static int f2fs_write_check_point_pack(void)
>  		goto free_cp_payload;
>  	}
>  
> -	for (i = 0; i < get_sb(cp_payload); i++) {
> +	for (i = 0; i < get_val(sb, cp_payload); i++) {
>  		cp_seg_blk_offset += blk_size_bytes;
>  		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
>  			MSG(1, "\tError: While zeroing out the sit bitmap area \
> @@ -537,8 +537,8 @@ static int f2fs_write_check_point_pack(void)
>  	sum->nat_j.entries[0].ne.version = 0;
>  	sum->nat_j.entries[0].ne.ino = sb->root_ino;
>  	sum->nat_j.entries[0].ne.block_addr = cpu_to_le32(
> -			get_sb(main_blkaddr) +
> -			get_cp(cur_node_segno[0]) * config.blks_per_seg);
> +			get_val(sb, main_blkaddr) +
> +			get_val(cp, cur_node_segno[0]) * config.blks_per_seg);
>  
>  	memcpy(sum_compact_p, &sum->n_nats, SUM_JOURNAL_SIZE);
>  	sum_compact_p += SUM_JOURNAL_SIZE;
> @@ -635,7 +635,7 @@ static int f2fs_write_check_point_pack(void)
>  	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, cp, CHECKSUM_OFFSET);
>  	*((__le32 *)((unsigned char *)cp + CHECKSUM_OFFSET)) =
>  							cpu_to_le32(crc);
> -	cp_seg_blk_offset = (get_sb(segment0_blkaddr) +
> +	cp_seg_blk_offset = (get_val(sb, segment0_blkaddr) +
>  				config.blks_per_seg) *
>  				blk_size_bytes;
>  	DBG(1, "\tWriting cp page 1 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
> @@ -644,7 +644,7 @@ static int f2fs_write_check_point_pack(void)
>  		goto free_cp_payload;
>  	}
>  
> -	for (i = 0; i < get_sb(cp_payload); i++) {
> +	for (i = 0; i < get_val(sb, cp_payload); i++) {
>  		cp_seg_blk_offset += blk_size_bytes;
>  		if (dev_fill(cp_payload, cp_seg_blk_offset, blk_size_bytes)) {
>  			MSG(1, "\tError: While zeroing out the sit bitmap area \
> @@ -655,7 +655,7 @@ static int f2fs_write_check_point_pack(void)
>  
>  	/* cp page 2 of check point pack 2 */
>  	cp_seg_blk_offset += blk_size_bytes * (le32_to_cpu(cp->cp_pack_total_block_count)
> -			- get_sb(cp_payload) - 1);
> +			- get_val(sb, cp_payload) - 1);
>  	DBG(1, "\tWriting cp page 2 of checkpoint pack 2, at offset 0x%08"PRIx64"\n", cp_seg_blk_offset);
>  	if (dev_write(cp, cp_seg_blk_offset, blk_size_bytes)) {
>  		MSG(1, "\tError: While writing the cp to disk!!!\n");
> @@ -701,8 +701,8 @@ static int f2fs_write_super_block(void)
>  static int discard_obsolete_dnode(struct f2fs_node *raw_node, u_int64_t offset)
>  {
>  	do {
> -		if (offset < get_sb(main_blkaddr) ||
> -			offset >= get_sb(main_blkaddr) + get_sb(block_count))
> +		if (offset < get_val(sb, main_blkaddr) ||
> +			offset >= get_val(sb, main_blkaddr) + get_val(sb, block_count))
>  			break;
>  
>  		if (dev_read_block(raw_node, offset)) {
> @@ -740,7 +740,7 @@ static int f2fs_write_root_inode(void)
>  	raw_node->footer.ino = sb->root_ino;
>  	raw_node->footer.cp_ver = cpu_to_le64(1);
>  	raw_node->footer.next_blkaddr = cpu_to_le32(
> -			get_sb(main_blkaddr) +
> +			get_val(sb, main_blkaddr) +
>  			config.cur_seg[CURSEG_HOT_NODE] *
>  			config.blks_per_seg + 1);
>  
> @@ -749,7 +749,7 @@ static int f2fs_write_root_inode(void)
>  	raw_node->i.i_uid = cpu_to_le32(getuid());
>  	raw_node->i.i_gid = cpu_to_le32(getgid());
>  
> -	blk_size_bytes = 1 << get_sb(log_blocksize);
> +	blk_size_bytes = 1 << get_val(sb, log_blocksize);
>  	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
>  	raw_node->i.i_blocks = cpu_to_le64(2);
>  
> @@ -765,7 +765,7 @@ static int f2fs_write_root_inode(void)
>  	raw_node->i.i_current_depth = cpu_to_le32(1);
>  	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
>  
> -	data_blk_nor = get_sb(main_blkaddr) +
> +	data_blk_nor = get_val(sb, main_blkaddr) +
>  		config.cur_seg[CURSEG_HOT_DATA] * config.blks_per_seg;
>  	raw_node->i.i_addr[0] = cpu_to_le32(data_blk_nor);
>  
> @@ -773,7 +773,7 @@ static int f2fs_write_root_inode(void)
>  	raw_node->i.i_ext.blk_addr = 0;
>  	raw_node->i.i_ext.len = 0;
>  
> -	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
> +	main_area_node_seg_blk_offset = get_val(sb, main_blkaddr);
>  	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_HOT_NODE] *
>  					config.blks_per_seg;
>          main_area_node_seg_blk_offset *= blk_size_bytes;
> @@ -786,7 +786,7 @@ static int f2fs_write_root_inode(void)
>  	}
>  
>  	/* avoid power-off-recovery based on roll-forward policy */
> -	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
> +	main_area_node_seg_blk_offset = get_val(sb, main_blkaddr);
>  	main_area_node_seg_blk_offset += config.cur_seg[CURSEG_WARM_NODE] *
>  					config.blks_per_seg;
>  
> @@ -813,21 +813,21 @@ static int f2fs_update_nat_root(void)
>  	}
>  
>  	/* update root */
> -	nat_blk->entries[get_sb(root_ino)].block_addr = cpu_to_le32(
> -		get_sb(main_blkaddr) +
> +	nat_blk->entries[get_val(sb, root_ino)].block_addr = cpu_to_le32(
> +		get_val(sb, main_blkaddr) +
>  		config.cur_seg[CURSEG_HOT_NODE] * config.blks_per_seg);
> -	nat_blk->entries[get_sb(root_ino)].ino = sb->root_ino;
> +	nat_blk->entries[get_val(sb, root_ino)].ino = sb->root_ino;
>  
>  	/* update node nat */
> -	nat_blk->entries[get_sb(node_ino)].block_addr = cpu_to_le32(1);
> -	nat_blk->entries[get_sb(node_ino)].ino = sb->node_ino;
> +	nat_blk->entries[get_val(sb, node_ino)].block_addr = cpu_to_le32(1);
> +	nat_blk->entries[get_val(sb, node_ino)].ino = sb->node_ino;
>  
>  	/* update meta nat */
> -	nat_blk->entries[get_sb(meta_ino)].block_addr = cpu_to_le32(1);
> -	nat_blk->entries[get_sb(meta_ino)].ino = sb->meta_ino;
> +	nat_blk->entries[get_val(sb, meta_ino)].block_addr = cpu_to_le32(1);
> +	nat_blk->entries[get_val(sb, meta_ino)].ino = sb->meta_ino;
>  
> -	blk_size_bytes = 1 << get_sb(log_blocksize);
> -	nat_seg_blk_offset = get_sb(nat_blkaddr);
> +	blk_size_bytes = 1 << get_val(sb, log_blocksize);
> +	nat_seg_blk_offset = get_val(sb, nat_blkaddr);
>  	nat_seg_blk_offset *= blk_size_bytes;
>  
>  	DBG(1, "\tWriting nat root, at offset 0x%08"PRIx64"\n", nat_seg_blk_offset);
> @@ -867,8 +867,8 @@ static int f2fs_add_default_dentry_root(void)
>  	/* bitmap for . and .. */
>  	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
>  	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
> -	blk_size_bytes = 1 << get_sb(log_blocksize);
> -	data_blk_offset = get_sb(main_blkaddr);
> +	blk_size_bytes = 1 << get_val(sb, log_blocksize);
> +	data_blk_offset = get_val(sb, main_blkaddr);
>  	data_blk_offset += config.cur_seg[CURSEG_HOT_DATA] *
>  				config.blks_per_seg;
>  	data_blk_offset *= blk_size_bytes;
> -- 
> 1.9.1
> 
> 
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

------------------------------------------------------------------------------
Site24x7 APM Insight: Get Deep Visibility into Application Performance
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
Monitor end-to-end web transactions and take corrective actions now
Troubleshoot faster and improve end-user experience. Signup Now!
http://pubads.g.doubleclick.net/gampad/clk?id=267308311&iu=/4140

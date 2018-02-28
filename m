From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [RFC PATCH v2 5/7] mkfs.f2fs: create lost+found
 directory
Date: Tue, 27 Feb 2018 21:25:36 -0800
Message-ID: <20180228052536.GF81737@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180223031801.231805-1-shengyong1@huawei.com>
 <20180223031801.231805-6-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <jaegeuk@kernel.org>) id 1equFM-001OK4-7n
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:25:44 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1equFI-006Agx-Se
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 05:25:42 +0000
Content-Disposition: inline
In-Reply-To: <20180223031801.231805-6-shengyong1@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Sheng Yong <shengyong1@huawei.com>
Cc: hyojun@google.com, miaoxie@huawei.com, linux-f2fs-devel@lists.sourceforge.net

On 02/23, Sheng Yong wrote:
> This patch introduces a new feature F2FS_FEATURE_LOST_FOUND. It can be
> switched on by indicating `-O lost_found'. If LOST_FOUND feature is
> enabled, an empty directory lost+found is created by mkfs.
> 
> This is a preparation for fsck. During fsck, the directory is used to
> save unreachable files, which have no parent directory or their parent
> directory is removed by fsck. Encrypted files are also allowed to be
> saved here.
> 
> Signed-off-by: Sheng Yong <shengyong1@huawei.com>
> ---
>  fsck/mount.c            |   3 +
>  include/f2fs_fs.h       |   6 ++
>  mkfs/f2fs_format.c      | 224 +++++++++++++++++++++++++++++++++++++++++++++---
>  mkfs/f2fs_format_main.c |   2 +
>  4 files changed, 223 insertions(+), 12 deletions(-)
> 
> diff --git a/fsck/mount.c b/fsck/mount.c
> index 46cb571..6482721 100644
> --- a/fsck/mount.c
> +++ b/fsck/mount.c
> @@ -460,6 +460,9 @@ void print_sb_state(struct f2fs_super_block *sb)
>  	if (f & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
>  		MSG(0, "%s", " inode_crtime");
>  	}
> +	if (f & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
> +		MSG(0, "%s", " lost_found");
> +	}
>  	MSG(0, "\n");
>  	MSG(0, "Info: superblock encrypt level = %d, salt = ",
>  					sb->encryption_level);
> diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> index ca4522d..093c402 100644
> --- a/include/f2fs_fs.h
> +++ b/include/f2fs_fs.h
> @@ -291,6 +291,8 @@ static inline uint64_t bswap_64(uint64_t val)
>  
>  #define VERSION_LEN	256
>  
> +#define LPF "lost+found"
> +
>  enum f2fs_config_func {
>  	MKFS,
>  	FSCK,
> @@ -369,6 +371,9 @@ struct f2fs_configuration {
>  	u_int32_t next_free_nid;
>  	u_int32_t quota_inum;
>  	u_int32_t quota_dnum;
> +	u_int32_t lpf_inum;
> +	u_int32_t lpf_dnum;
> +	u_int32_t lpf_ino;
>  
>  	/* defragmentation parameters */
>  	int defrag_shrink;
> @@ -557,6 +562,7 @@ enum {
>  #define F2FS_FEATURE_FLEXIBLE_INLINE_XATTR	0x0040
>  #define F2FS_FEATURE_QUOTA_INO		0x0080
>  #define F2FS_FEATURE_INODE_CRTIME	0x0100
> +#define F2FS_FEATURE_LOST_FOUND		0x0200
>  
>  #define MAX_VOLUME_NAME		512
>  
> diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
> index 5eaeff4..4145c79 100644
> --- a/mkfs/f2fs_format.c
> +++ b/mkfs/f2fs_format.c
> @@ -426,6 +426,9 @@ static int f2fs_prepare_super_block(void)
>  					qtype, c.next_free_nid - 1);
>  	}
>  
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND))
> +		c.lpf_ino = c.next_free_nid++;
> +
>  	if (total_zones <= 6) {
>  		MSG(1, "\tError: %d zones: Need more zones "
>  			"by shrinking zone size\n", total_zones);
> @@ -608,9 +611,10 @@ static int f2fs_write_check_point_pack(void)
>  		set_cp(cur_data_segno[i], 0xffffffff);
>  	}
>  
> -	set_cp(cur_node_blkoff[0], 1 + c.quota_inum);
> -	set_cp(cur_data_blkoff[0], 1 + c.quota_dnum);
> -	set_cp(valid_block_count, 2 + c.quota_inum + c.quota_dnum);
> +	set_cp(cur_node_blkoff[0], 1 + c.quota_inum + c.lpf_inum);
> +	set_cp(cur_data_blkoff[0], 1 + c.quota_dnum + c.lpf_dnum);
> +	set_cp(valid_block_count, 2 + c.quota_inum + c.quota_dnum +
> +			c.lpf_inum + c.lpf_dnum);
>  	set_cp(rsvd_segment_count, c.reserved_segments);
>  	set_cp(overprov_segment_count, (get_sb(segment_count_main) -
>  			get_cp(rsvd_segment_count)) *
> @@ -642,8 +646,8 @@ static int f2fs_write_check_point_pack(void)
>  
>  	set_cp(ckpt_flags, flags);
>  	set_cp(cp_pack_start_sum, 1 + get_sb(cp_payload));
> -	set_cp(valid_node_count, 1 + c.quota_inum);
> -	set_cp(valid_inode_count, 1 + c.quota_inum);
> +	set_cp(valid_node_count, 1 + c.quota_inum + c.lpf_inum);
> +	set_cp(valid_inode_count, 1 + c.quota_inum + c.lpf_inum);
>  	set_cp(next_free_nid, c.next_free_nid);
>  	set_cp(sit_ver_bitmap_bytesize, ((get_sb(segment_count_sit) / 2) <<
>  			get_sb(log_blocks_per_seg)) / 8);
> @@ -702,7 +706,7 @@ static int f2fs_write_check_point_pack(void)
>  	SET_SUM_TYPE((&sum->footer), SUM_TYPE_DATA);
>  
>  	journal = &sum->journal;
> -	journal->n_nats = cpu_to_le16(1 + c.quota_inum);
> +	journal->n_nats = cpu_to_le16(1 + c.quota_inum + c.lpf_inum);
>  	journal->nat_j.entries[0].nid = sb->root_ino;
>  	journal->nat_j.entries[0].ne.version = 0;
>  	journal->nat_j.entries[0].ne.ino = sb->root_ino;
> @@ -723,6 +727,16 @@ static int f2fs_write_check_point_pack(void)
>  		i++;
>  	}
>  
> +	if (c.lpf_inum) {
> +		journal->nat_j.entries[i].nid = cpu_to_le32(c.lpf_ino);
> +		journal->nat_j.entries[i].ne.version = 0;
> +		journal->nat_j.entries[i].ne.ino = cpu_to_le32(c.lpf_ino);
> +		journal->nat_j.entries[i].ne.block_addr = cpu_to_le32(
> +				get_sb(main_blkaddr) +
> +				get_cp(cur_node_segno[0]) *
> +				c.blks_per_seg + i);
> +	}
> +
>  	memcpy(sum_compact_p, &journal->n_nats, SUM_JOURNAL_SIZE);
>  	sum_compact_p += SUM_JOURNAL_SIZE;
>  
> @@ -732,10 +746,13 @@ static int f2fs_write_check_point_pack(void)
>  	journal->sit_j.entries[0].segno = cp->cur_node_segno[0];
>  	journal->sit_j.entries[0].se.vblocks =
>  				cpu_to_le16((CURSEG_HOT_NODE << 10) |
> -						(1 + c.quota_inum));
> +						(1 + c.quota_inum + c.lpf_inum));
>  	f2fs_set_bit(0, (char *)journal->sit_j.entries[0].se.valid_map);
>  	for (i = 1; i <= c.quota_inum; i++)
>  		f2fs_set_bit(i, (char *)journal->sit_j.entries[0].se.valid_map);
> +	if (c.lpf_inum)
> +		f2fs_set_bit(i, (char *)journal->sit_j.entries[0].se.valid_map);
> +
>  	journal->sit_j.entries[1].segno = cp->cur_node_segno[1];
>  	journal->sit_j.entries[1].se.vblocks =
>  				cpu_to_le16((CURSEG_WARM_NODE << 10));
> @@ -747,10 +764,12 @@ static int f2fs_write_check_point_pack(void)
>  	journal->sit_j.entries[3].segno = cp->cur_data_segno[0];
>  	journal->sit_j.entries[3].se.vblocks =
>  				cpu_to_le16((CURSEG_HOT_DATA << 10) |
> -						(1 + c.quota_dnum));
> +						(1 + c.quota_dnum + c.lpf_dnum));
>  	f2fs_set_bit(0, (char *)journal->sit_j.entries[3].se.valid_map);
>  	for (i = 1; i <= c.quota_dnum; i++)
>  		f2fs_set_bit(i, (char *)journal->sit_j.entries[3].se.valid_map);
> +	if (c.lpf_dnum)
> +		f2fs_set_bit(i, (char *)journal->sit_j.entries[3].se.valid_map);
>  
>  	journal->sit_j.entries[4].segno = cp->cur_data_segno[1];
>  	journal->sit_j.entries[4].se.vblocks =
> @@ -780,6 +799,11 @@ static int f2fs_write_check_point_pack(void)
>  		off += QUOTA_DATA(qtype);
>  	}
>  
> +	if (c.lpf_dnum) {
> +		(sum_entry + off)->nid = cpu_to_le32(c.lpf_ino);
> +		(sum_entry + off)->ofs_in_node = 0;
> +	}
> +
>  	/* warm data summary, nothing to do */
>  	/* cold data summary, nothing to do */
>  
> @@ -804,6 +828,11 @@ static int f2fs_write_check_point_pack(void)
>  		sum->entries[1 + i].ofs_in_node = 0;
>  		i++;
>  	}
> +	if (c.lpf_inum) {
> +		i++;
> +		sum->entries[i].nid = cpu_to_le32(c.lpf_ino);
> +		sum->entries[i].ofs_in_node = 0;
> +	}
>  
>  	cp_seg_blk++;
>  	DBG(1, "\tWriting Segment summary for HOT_NODE, at offset 0x%08"PRIx64"\n",
> @@ -963,7 +992,7 @@ static int f2fs_discard_obsolete_dnode(void)
>  	offset += c.cur_seg[CURSEG_WARM_NODE] * c.blks_per_seg;
>  
>  	last_inode_pos = start_inode_pos +
> -		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + c.quota_inum;
> +		c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg + c.quota_inum + c.lpf_inum;
>  
>  	do {
>  		if (offset < get_sb(main_blkaddr) || offset >= end_blkaddr)
> @@ -1016,7 +1045,10 @@ static int f2fs_write_root_inode(void)
>  			c.blks_per_seg + 1);
>  
>  	raw_node->i.i_mode = cpu_to_le16(0x41ed);
> -	raw_node->i.i_links = cpu_to_le32(2);
> +	if (c.lpf_ino)
> +		raw_node->i.i_links = cpu_to_le32(3);
> +	else
> +		raw_node->i.i_links = cpu_to_le32(2);
>  	raw_node->i.i_uid = cpu_to_le32(getuid());
>  	raw_node->i.i_gid = cpu_to_le32(getgid());
>  
> @@ -1122,10 +1154,16 @@ static int f2fs_write_default_quota(int qtype, unsigned int blkaddr,
>  	dqblk.dqb_pad = cpu_to_le32(0);
>  	dqblk.dqb_ihardlimit = cpu_to_le64(0);
>  	dqblk.dqb_isoftlimit = cpu_to_le64(0);
> -	dqblk.dqb_curinodes = cpu_to_le64(1);
> +	if (c.lpf_ino)
> +		dqblk.dqb_curinodes = cpu_to_le64(2);
> +	else
> +		dqblk.dqb_curinodes = cpu_to_le64(1);
>  	dqblk.dqb_bhardlimit = cpu_to_le64(0);
>  	dqblk.dqb_bsoftlimit = cpu_to_le64(0);
> -	dqblk.dqb_curspace = cpu_to_le64(4096);
> +	if (c.lpf_ino)
> +		dqblk.dqb_curspace = cpu_to_le64(8192);
> +	else
> +		dqblk.dqb_curspace = cpu_to_le64(4096);
>  	dqblk.dqb_btime = cpu_to_le64(0);
>  	dqblk.dqb_itime = cpu_to_le64(0);
>  
> @@ -1300,6 +1338,142 @@ static int f2fs_update_nat_root(void)
>  	return 0;
>  }
>  
> +static u_int64_t f2fs_add_default_dentry_lpf(void)
> +{
> +	struct f2fs_dentry_block *dent_blk;
> +	u_int64_t data_blk_offset = 0;
> +
> +	dent_blk = calloc(F2FS_BLKSIZE, 1);
> +	if (dent_blk == NULL) {
> +		MSG(1, "\tError: Calloc Failed for dent_blk!!!\n");
> +		return -1;
> +	}
> +
> +	dent_blk->dentry[0].hash_code = 0;
> +	dent_blk->dentry[0].ino = cpu_to_le32(c.lpf_ino);
> +	dent_blk->dentry[0].name_len = cpu_to_le16(1);
> +	dent_blk->dentry[0].file_type = F2FS_FT_DIR;
> +	memcpy(dent_blk->filename[0], ".", 1);
> +
> +	dent_blk->dentry[1].hash_code = 0;
> +	dent_blk->dentry[1].ino = sb->root_ino;
> +	dent_blk->dentry[1].name_len = cpu_to_le16(2);
> +	dent_blk->dentry[1].file_type = F2FS_FT_DIR;
> +	memcpy(dent_blk->filename[1], "..", 2);
> +
> +	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
> +	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
> +
> +	data_blk_offset = get_sb(main_blkaddr);
> +	data_blk_offset += c.cur_seg[CURSEG_HOT_DATA] * c.blks_per_seg +
> +		1 + c.quota_dnum;
> +
> +	DBG(1, "\tWriting default dentry lost+found, at offset 0x%08"PRIx64"\n",
> +			data_blk_offset);
> +	if (dev_write_block(dent_blk, data_blk_offset)) {
> +		MSG(1, "\tError While writing the dentry_blk to disk!!!\n");
> +		free(dent_blk);
> +		return -1;
> +	}
> +
> +	free(dent_blk);
> +	c.lpf_dnum++;
> +	return data_blk_offset;
> +}
> +
> +static int f2fs_write_lpf_inode(void)
> +{
> +	struct f2fs_node *raw_node;
> +	u_int64_t blk_size_bytes, data_blk_nor;
> +	u_int64_t main_area_node_seg_blk_offset;
> +	int err = 0;
> +
> +	ASSERT(c.lpf_ino);
> +
> +	raw_node = calloc(F2FS_BLKSIZE, 1);
> +	if (raw_node == NULL) {
> +		MSG(1, "\tError: Calloc Failed for raw_node!!!\n");
> +		return -1;
> +	}
> +
> +	raw_node->footer.nid = cpu_to_le32(c.lpf_ino);
> +	raw_node->footer.ino = raw_node->footer.nid;
> +	raw_node->footer.cp_ver = cpu_to_le64(1);
> +	raw_node->footer.next_blkaddr = cpu_to_le32(
> +			get_sb(main_blkaddr) +
> +			c.cur_seg[CURSEG_HOT_NODE] * c.blks_per_seg +
> +			1 + c.quota_inum + 1);
> +
> +	raw_node->i.i_mode = cpu_to_le16(0x41c0); /* 0700 */
> +	raw_node->i.i_links = cpu_to_le32(2);
> +	raw_node->i.i_uid = cpu_to_le32(getuid());
> +	raw_node->i.i_gid = cpu_to_le32(getgid());
> +
> +	blk_size_bytes = 1 << get_sb(log_blocksize);
> +	raw_node->i.i_size = cpu_to_le64(1 * blk_size_bytes); /* dentry */
> +	raw_node->i.i_blocks = cpu_to_le64(2);
> +
> +	raw_node->i.i_atime = cpu_to_le32(time(NULL));
> +	raw_node->i.i_atime_nsec = 0;
> +	raw_node->i.i_ctime = cpu_to_le32(time(NULL));
> +	raw_node->i.i_ctime_nsec = 0;
> +	raw_node->i.i_mtime = cpu_to_le32(time(NULL));
> +	raw_node->i.i_mtime_nsec = 0;
> +	raw_node->i.i_generation = 0;
> +	raw_node->i.i_xattr_nid = 0;
> +	raw_node->i.i_flags = 0;
> +	raw_node->i.i_pino = le32_to_cpu(sb->root_ino);
> +	raw_node->i.i_namelen = le32_to_cpu(strlen(LPF));
> +	memcpy(raw_node->i.i_name, LPF, strlen(LPF));
> +	raw_node->i.i_current_depth = cpu_to_le32(1);
> +	raw_node->i.i_dir_level = DEF_DIR_LEVEL;
> +
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_EXTRA_ATTR)) {
> +		raw_node->i.i_inline = F2FS_EXTRA_ATTR;
> +		raw_node->i.i_extra_isize =
> +			cpu_to_le16(F2FS_TOTAL_EXTRA_ATTR_SIZE);
> +	}
> +
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_PRJQUOTA))
> +		raw_node->i.i_projid = cpu_to_le32(F2FS_DEF_PROJID);
> +
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CRTIME)) {
> +		raw_node->i.i_crtime = cpu_to_le32(time(NULL));
> +		raw_node->i.i_crtime_nsec = 0;
> +	}
> +
> +	data_blk_nor = f2fs_add_default_dentry_lpf();

Could you please check data type of data_blk_nor?

> +	if (data_blk_nor < 0) {

Can't do this.

> +		MSG(1, "\tError: Failed to add default dentries for lost+found!!!\n");
> +		err = -1;
> +		goto exit;
> +	}
> +	raw_node->i.i_addr[get_extra_isize(raw_node)] = cpu_to_le32(data_blk_nor);

cpu_to_le32() is wrong.

Please check all the data types in the series.

Thanks,

> +
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_INODE_CHKSUM))
> +		raw_node->i.i_inode_checksum =
> +			cpu_to_le32(f2fs_inode_chksum(raw_node));
> +
> +	main_area_node_seg_blk_offset = get_sb(main_blkaddr);
> +	main_area_node_seg_blk_offset += c.cur_seg[CURSEG_HOT_NODE] *
> +		c.blks_per_seg + c.quota_inum + 1;
> +
> +	DBG(1, "\tWriting lost+found inode (hot node), %x %x %x at offset 0x%08"PRIu64"\n",
> +			get_sb(main_blkaddr),
> +			c.cur_seg[CURSEG_HOT_NODE],
> +			c.blks_per_seg, main_area_node_seg_blk_offset);
> +	if (dev_write_block(raw_node, main_area_node_seg_blk_offset)) {
> +		MSG(1, "\tError: While writing the raw_node to disk!!!\n");
> +		err = -1;
> +		goto exit;
> +	}
> +
> +	c.lpf_inum++;
> +exit:
> +	free(raw_node);
> +	return err;
> +}
> +
>  static int f2fs_add_default_dentry_root(void)
>  {
>  	struct f2fs_dentry_block *dent_blk = NULL;
> @@ -1327,6 +1501,23 @@ static int f2fs_add_default_dentry_root(void)
>  	test_and_set_bit_le(0, dent_blk->dentry_bitmap);
>  	test_and_set_bit_le(1, dent_blk->dentry_bitmap);
>  
> +	if (c.lpf_ino) {
> +		int len = strlen(LPF);
> +		f2fs_hash_t hash = f2fs_dentry_hash((unsigned char *)LPF, len);
> +
> +		dent_blk->dentry[2].hash_code = cpu_to_le32(hash);
> +		dent_blk->dentry[2].ino = cpu_to_le32(c.lpf_ino);
> +		dent_blk->dentry[2].name_len = cpu_to_le16(len);
> +		dent_blk->dentry[2].file_type = F2FS_FT_DIR;
> +		memcpy(dent_blk->filename[2], LPF, F2FS_SLOT_LEN);
> +
> +		memcpy(dent_blk->filename[3], LPF + F2FS_SLOT_LEN,
> +				len - F2FS_SLOT_LEN);
> +
> +		test_and_set_bit_le(2, dent_blk->dentry_bitmap);
> +		test_and_set_bit_le(3, dent_blk->dentry_bitmap);
> +	}
> +
>  	data_blk_offset = get_sb(main_blkaddr);
>  	data_blk_offset += c.cur_seg[CURSEG_HOT_DATA] *
>  				c.blks_per_seg;
> @@ -1364,6 +1555,14 @@ static int f2fs_create_root_dir(void)
>  		}
>  	}
>  
> +	if (c.feature & cpu_to_le32(F2FS_FEATURE_LOST_FOUND)) {
> +		err = f2fs_write_lpf_inode();
> +		if (err < 0) {
> +			MSG(1, "\tError: Failed to write lost+found inode!!!\n");
> +			goto exit;
> +		}
> +	}
> +
>  #ifndef WITH_ANDROID
>  	err = f2fs_discard_obsolete_dnode();
>  	if (err < 0) {
> @@ -1437,6 +1636,7 @@ int f2fs_format_device(void)
>  		MSG(0, "\tError: Failed to write the Super Block!!!\n");
>  		goto exit;
>  	}
> +
>  exit:
>  	if (err)
>  		MSG(0, "\tError: Could not format the device!!!\n");
> diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
> index 120eeba..aeda5f4 100644
> --- a/mkfs/f2fs_format_main.c
> +++ b/mkfs/f2fs_format_main.c
> @@ -95,6 +95,8 @@ static void parse_feature(const char *features)
>  		c.feature |= cpu_to_le32(F2FS_FEATURE_QUOTA_INO);
>  	} else if (!strcmp(features, "inode_crtime")) {
>  		c.feature |= cpu_to_le32(F2FS_FEATURE_INODE_CRTIME);
> +	} else if (!strcmp(features, "lost_found")) {
> +		c.feature |= cpu_to_le32(F2FS_FEATURE_LOST_FOUND);
>  	} else {
>  		MSG(0, "Error: Wrong features\n");
>  		mkfs_usage();
> -- 
> 2.14.1

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

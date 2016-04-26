From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 1/3] resize.f2fs: support to expand partition
 size
Date: Mon, 25 Apr 2016 19:17:01 -0700
Message-ID: <20160426021701.GA17338@jaegeuk.gateway>
References: <1461630518-16944-1-git-send-email-jaegeuk@kernel.org>
	<571ECB14.2010305@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1ausYs-0000Xc-5Z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:17:14 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ausYo-0003Ow-Vu
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Apr 2016 02:17:14 +0000
Content-Disposition: inline
In-Reply-To: <571ECB14.2010305@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: He YunLei <heyunlei@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hello,

...

> >+	/* ovp / free segments */
> >+	set_cp(overprov_segment_count, config.new_overprovision);
> >+	set_cp(rsvd_segment_count, config.new_reserved_segments);
> 
> maybe something wrong here:
> 	set_cp(rsvd_segment_count, config.new_reserved_segments);
> 	set_cp(overprov_segment_count, (get_newsb(segment_count_main) -
> 			get_cp(rsvd_segment_count)) *
> 			config.new_overprovision / 100);
> 	set_cp(overprov_segment_count, get_cp(overprov_segment_count) +
> 						get_cp(rsvd_segment_count));
> 

So, could you illustrate the point?
The new_overprovision and new_reserved_segments were calculated from the target
partition size.

Am I missing something?

Thanks,

> >+	free_segment_count = get_cp(free_segment_count);
> >+	new_segment_count = get_newsb(segment_count_main) -
> >+					get_sb(segment_count_main);
> >+
> >+	set_cp(free_segment_count, free_segment_count + new_segment_count);
> >+	set_cp(user_block_count, ((get_sb(segment_count_main) -
> >+			get_cp(overprov_segment_count)) * config.blks_per_seg));
> >+
> >+	if (is_set_ckpt_flags(cp, CP_ORPHAN_PRESENT_FLAG))
> >+		orphan_blks = __start_sum_addr(sbi) - 1;
> >+
> >+	set_cp(cp_pack_start_sum, 1 + get_newsb(cp_payload));
> >+	set_cp(cp_pack_total_block_count, 8 + orphan_blks + get_newsb(cp_payload));
> >+
> >+	/* cur->segno - offset */
> >+	for (i = 0; i < NO_CHECK_TYPE; i++) {
> >+		if (i < CURSEG_HOT_NODE) {
> >+			set_cp(cur_data_segno[i],
> >+					CURSEG_I(sbi, i)->segno - offset);
> >+		} else {
> >+			int n = i - CURSEG_HOT_NODE;
> >+
> >+			set_cp(cur_node_segno[n],
> >+					CURSEG_I(sbi, i)->segno - offset);
> >+		}
> >+	}
> >+
> >+	/* sit / nat ver bitmap bytesize */
> >+	set_cp(sit_ver_bitmap_bytesize,
> >+			((get_newsb(segment_count_sit) / 2) <<
> >+			get_newsb(log_blocks_per_seg)) / 8);
> >+	set_cp(nat_ver_bitmap_bytesize,
> >+			((get_newsb(segment_count_nat) / 2) <<
> >+			get_newsb(log_blocks_per_seg)) / 8);
> >+
> >+	memcpy(new_cp, cp, (unsigned char *)cp->sit_nat_version_bitmap -
> >+						(unsigned char *)cp);
> >+
> >+	crc = f2fs_cal_crc32(F2FS_SUPER_MAGIC, new_cp, CHECKSUM_OFFSET);
> >+	*((__le32 *)((unsigned char *)new_cp + CHECKSUM_OFFSET)) = cpu_to_le32(crc);
> >+
> >+	/* Write a new checkpoint in the other set */
> >+	new_cp_blk_no = old_cp_blk_no = get_sb(cp_blkaddr);
> >+	if (sbi->cur_cp == 2)
> >+		old_cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> >+	else
> >+		new_cp_blk_no += 1 << get_sb(log_blocks_per_seg);
> >+
> >+	/* write first cp */
> >+	ret = dev_write_block(new_cp, new_cp_blk_no++);
> >+	ASSERT(ret >= 0);
> >+
> >+	memset(buf, 0, BLOCK_SZ);
> >+	for (i = 0; i < get_newsb(cp_payload); i++) {
> >+		ret = dev_write_block(buf, new_cp_blk_no++);
> >+		ASSERT(ret >= 0);
> >+	}
> >+
> >+	for (i = 0; i < orphan_blks; i++) {
> >+		block_t orphan_blk_no = old_cp_blk_no + 1 + get_sb(cp_payload);
> >+
> >+		ret = dev_read_block(buf, orphan_blk_no++);
> >+		ASSERT(ret >= 0);
> >+
> >+		ret = dev_write_block(buf, new_cp_blk_no++);
> >+		ASSERT(ret >= 0);
> >+	}
> >+
> >+	/* update summary blocks having nullified journal entries */
> >+	for (i = 0; i < NO_CHECK_TYPE; i++) {
> >+		struct curseg_info *curseg = CURSEG_I(sbi, i);
> >+
> >+		ret = dev_write_block(curseg->sum_blk, new_cp_blk_no++);
> >+		ASSERT(ret >= 0);
> >+	}
> >+
> >+	/* write the last cp */
> >+	ret = dev_write_block(new_cp, new_cp_blk_no++);
> >+	ASSERT(ret >= 0);
> >+
> >+	/* disable old checkpoint */
> >+	memset(buf, 0, BLOCK_SZ);
> >+	ret = dev_write_block(buf, old_cp_blk_no);
> >+	ASSERT(ret >= 0);
> >+
> >+	free(buf);
> >+	free(new_cp);
> >+	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
> >+}
> >+
> >+static void rebuild_superblock(struct f2fs_sb_info *sbi,
> >+				struct f2fs_super_block *new_sb)
> >+{
> >+	int index, ret;
> >+	u_int8_t *buf;
> >+
> >+	buf = calloc(BLOCK_SZ, 1);
> >+
> >+	memcpy(buf + F2FS_SUPER_OFFSET, new_sb, sizeof(*new_sb));
> >+	for (index = 0; index < 2; index++) {
> >+		ret = dev_write_block(buf, index);
> >+		ASSERT(ret >= 0);
> >+	}
> >+	free(buf);
> >+	DBG(0, "Info: Done to rebuild superblock\n");
> >+}
> >+
> >+int f2fs_resize(struct f2fs_sb_info *sbi)
> >+{
> >+	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
> >+	struct f2fs_super_block new_sb_raw;
> >+	struct f2fs_super_block *new_sb = &new_sb_raw;
> >+	block_t end_blkaddr, old_main_blkaddr, new_main_blkaddr;
> >+	unsigned int offset, offset_seg;
> >+	int err = -1;
> >+
> >+	/* flush NAT/SIT journal entries */
> >+	flush_journal_entries(sbi);
> >+
> >+	memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
> >+	if (get_new_sb(sbi, new_sb))
> >+		return -1;
> >+
> >+	/* check nat availability */
> >+	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
> >+		err = shrink_nats(sbi, new_sb);
> >+		if (err) {
> >+			MSG(0, "\tError: Failed to shrink NATs\n");
> >+			return err;
> >+		}
> >+	}
> >+
> >+	config.dbg_lv = 1;
> >+	print_raw_sb_info(sb);
> >+	print_raw_sb_info(new_sb);
> >+	config.dbg_lv = 0;
> >+
> >+	old_main_blkaddr = get_sb(main_blkaddr);
> >+	new_main_blkaddr = get_newsb(main_blkaddr);
> >+	offset = new_main_blkaddr - old_main_blkaddr;
> >+	end_blkaddr = (get_sb(segment_count) << get_sb(log_blocks_per_seg)) +
> >+						get_sb(main_blkaddr);
> >+
> >+	if (old_main_blkaddr > new_main_blkaddr) {
> >+		MSG(0, "\tError: Support resize to expand only\n");
> >+		return -1;
> >+	}
> >+
> >+	err = -EAGAIN;
> >+	offset_seg = offset >> get_sb(log_blocks_per_seg);
> >+
> >+	if (new_main_blkaddr < end_blkaddr) {
> >+		err = f2fs_defragment(sbi, old_main_blkaddr, offset,
> >+						new_main_blkaddr, 0);
> >+		if (err)
> >+			MSG(0, "Skip defragement\n");
> >+	}
> >+	/* move whole data region */
> >+	if (err)
> >+		migrate_main(sbi, new_sb, offset);
> >+
> >+	migrate_ssa(sbi, new_sb, offset_seg);
> >+	migrate_nat(sbi, new_sb);
> >+	migrate_sit(sbi, new_sb, offset_seg);
> >+	rebuild_checkpoint(sbi, new_sb, offset_seg);
> >+	rebuild_superblock(sbi, new_sb);
> >+	return 0;
> >+}
> >diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
> >index 330cbe5..99798d0 100644
> >--- a/include/f2fs_fs.h
> >+++ b/include/f2fs_fs.h
> >@@ -221,18 +221,22 @@ enum f2fs_config_func {
> >  	FSCK,
> >  	DUMP,
> >  	DEFRAG,
> >+	RESIZE,
> >  };
> >
> >  struct f2fs_configuration {
> >  	u_int32_t sector_size;
> >  	u_int32_t reserved_segments;
> >+	u_int32_t new_reserved_segments;
> >  	double overprovision;
> >+	double new_overprovision;
> >  	u_int32_t cur_seg[6];
> >  	u_int32_t segs_per_sec;
> >  	u_int32_t secs_per_zone;
> >  	u_int32_t segs_per_zone;
> >  	u_int32_t start_sector;
> >  	u_int64_t total_sectors;
> >+	u_int64_t target_sectors;
> >  	u_int32_t sectors_per_blk;
> >  	u_int32_t blks_per_seg;
> >  	__u8 init_version[VERSION_LEN + 1];
> >@@ -277,6 +281,9 @@ struct f2fs_configuration {
> >  #define get_sb_le64(member)			le64_to_cpu(sb->member)
> >  #define get_sb_le32(member)			le32_to_cpu(sb->member)
> >  #define get_sb_le16(member)			le16_to_cpu(sb->member)
> >+#define get_newsb_le64(member)			le64_to_cpu(new_sb->member)
> >+#define get_newsb_le32(member)			le32_to_cpu(new_sb->member)
> >+#define get_newsb_le16(member)			le16_to_cpu(new_sb->member)
> >
> >  #define set_sb(member, val)	\
> >  			do {						\
> >@@ -298,6 +305,16 @@ struct f2fs_configuration {
> >  				} 					\
> >  				t; \
> >  			})
> >+#define get_newsb(member)		\
> >+			({						\
> >+				typeof(new_sb->member) t;		\
> >+				switch (sizeof(t)) {			\
> >+				case 8: t = get_newsb_le64(member); break; \
> >+				case 4: t = get_newsb_le32(member); break; \
> >+				case 2: t = get_newsb_le16(member); break; \
> >+				} 					\
> >+				t; \
> >+			})
> >
> >  #define set_cp_le64(member, val)		(cp->member = cpu_to_le64(val))
> >  #define set_cp_le32(member, val)		(cp->member = cpu_to_le32(val))
> >diff --git a/man/Makefile.am b/man/Makefile.am
> >index 256f3c3..6c04de7 100644
> >--- a/man/Makefile.am
> >+++ b/man/Makefile.am
> >@@ -1,3 +1,3 @@
> >  ## Makefile.am
> >
> >-dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8
> >+dist_man_MANS = mkfs.f2fs.8 fsck.f2fs.8 dump.f2fs.8 defrag.f2fs.8 resize.f2fs.8
> >diff --git a/man/defrag.f2fs.8 b/man/defrag.f2fs.8
> >index e18e69f..8c709a7 100644
> >--- a/man/defrag.f2fs.8
> >+++ b/man/defrag.f2fs.8
> >@@ -71,4 +71,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
> >  .SH SEE ALSO
> >  .BR mkfs.f2fs(8),
> >  .BR dump.f2fs(8),
> >-.BR fsck.f2fs(8).
> >+.BR fsck.f2fs(8),
> >+.BR resize.f2fs(8).
> >diff --git a/man/dump.f2fs.8 b/man/dump.f2fs.8
> >index ca5f511..dc1d806 100644
> >--- a/man/dump.f2fs.8
> >+++ b/man/dump.f2fs.8
> >@@ -65,4 +65,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
> >  .SH SEE ALSO
> >  .BR mkfs.f2fs(8),
> >  .BR fsck.f2fs(8),
> >-.BR defrag.f2fs(8).
> >+.BR defrag.f2fs(8),
> >+.BR resize.f2fs(8).
> >diff --git a/man/fsck.f2fs.8 b/man/fsck.f2fs.8
> >index 0ffe6e1..22457c5 100644
> >--- a/man/fsck.f2fs.8
> >+++ b/man/fsck.f2fs.8
> >@@ -64,4 +64,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
> >  .SH SEE ALSO
> >  .BR mkfs.f2fs(8),
> >  .BR dump.f2fs(8),
> >-.BR defrag.f2fs(8).
> >+.BR defrag.f2fs(8),
> >+.BR resize.f2fs(8).
> >diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
> >index cdbde96..b767c0c 100644
> >--- a/man/mkfs.f2fs.8
> >+++ b/man/mkfs.f2fs.8
> >@@ -94,4 +94,5 @@ is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-too
> >  .BR mkfs (8),
> >  .BR fsck.f2fs(8),
> >  .BR dump.f2fs(8),
> >-.BR defrag.f2fs(8).
> >+.BR defrag.f2fs(8),
> >+.BR resize.f2fs(8).
> >diff --git a/man/resize.f2fs.8 b/man/resize.f2fs.8
> >new file mode 100644
> >index 0000000..1920810
> >--- /dev/null
> >+++ b/man/resize.f2fs.8
> >@@ -0,0 +1,49 @@
> >+.\" Copyright (c) 2015 Jaegeuk Kim <jaegeuk@kernel.org>
> >+.\"
> >+.TH RESIZE.F2FS 8
> >+.SH NAME
> >+resize.f2fs \- resize filesystem size
> >+.SH SYNOPSIS
> >+.B resize.f2fs
> >+[
> >+.B \-t
> >+.I target sectors
> >+]
> >+[
> >+.B \-d
> >+.I debugging-level
> >+]
> >+.I device
> >+.SH DESCRIPTION
> >+.B resize.f2fs
> >+is used to resize an f2fs file system (usually in a disk partition).
> >+\fIdevice\fP is the special file corresponding to the device (e.g.
> >+\fI/dev/sdXX\fP).
> >+
> >+Current version only supports expanding the prebuilt filesystem.
> >+
> >+.PP
> >+The exit code returned by
> >+.B resize.f2fs
> >+is 0 on success and -1 on failure.
> >+.SH OPTIONS
> >+.TP
> >+.BI \-t " target sectors"
> >+Specify the size in sectors.
> >+.TP
> >+.BI \-d " debug-level"
> >+Specify the level of debugging options.
> >+The default number is 0, which shows basic debugging messages.
> >+.TP
> >+.SH AUTHOR
> >+This version of
> >+.B resize.f2fs
> >+has been written by Jaegeuk Kim <jaegeuk@kernel.org>.
> >+.SH AVAILABILITY
> >+.B resize.f2fs
> >+is available from git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git.
> >+.SH SEE ALSO
> >+.BR mkfs.f2fs(8),
> >+.BR fsck.f2fs(8),
> >+.BR dump.f2fs(8),
> >+.BR defrag.f2fs(8).
> >

------------------------------------------------------------------------------
Find and fix application performance issues faster with Applications Manager
Applications Manager provides deep performance insights into multiple tiers of
your business applications. It resolves application problems quickly and
reduces your MTTR. Get your free trial!
https://ad.doubleclick.net/ddm/clk/302982198;130105516;z

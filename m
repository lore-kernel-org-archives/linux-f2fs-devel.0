From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH UNTESTED 2/2] f2fs-tools: introduce
 f2fs_update_sparse_file()
Date: Thu, 25 Apr 2019 20:50:10 +0800
Message-ID: <20190425125010.5105-2-yuchao0@huawei.com>
References: <20190425125010.5105-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hJdpY-0001GV-Gr
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Apr 2019 12:50:24 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hJdpW-00DUxx-St
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Apr 2019 12:50:24 +0000
In-Reply-To: <20190425125010.5105-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org, zhaowuyun@wingtech.com

This patch fixes to initialize NAT/SIT/CP.payload region in sparse
file mode for fsck/sload/resize/defrag/dump tools.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/fsck.h      |  1 +
 fsck/main.c      |  5 ++++
 fsck/mount.c     | 77 ++++++++++++++++++++++++++++++++++++++++++++++++
 lib/libf2fs_io.c |  9 ------
 4 files changed, 83 insertions(+), 9 deletions(-)

diff --git a/fsck/fsck.h b/fsck/fsck.h
index dd831de..95bb7d3 100644
--- a/fsck/fsck.h
+++ b/fsck/fsck.h
@@ -181,6 +181,7 @@ extern int fsck_verify(struct f2fs_sb_info *);
 extern void fsck_free(struct f2fs_sb_info *);
 extern int f2fs_do_mount(struct f2fs_sb_info *);
 extern void f2fs_do_umount(struct f2fs_sb_info *);
+extern int f2fs_update_sparse_file(struct f2fs_sb_info *);
 
 extern void flush_journal_entries(struct f2fs_sb_info *);
 extern void zero_journal_entries(struct f2fs_sb_info *);
diff --git a/fsck/main.c b/fsck/main.c
index afdfec9..0670696 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -845,6 +845,11 @@ retry:
 				goto fsck_again;
 		}
 	}
+
+	ret = f2fs_update_sparse_file(sbi);
+	if (ret < 0)
+		return ret;
+
 	ret = f2fs_finalize_device();
 	if (ret < 0)
 		return ret;
diff --git a/fsck/mount.c b/fsck/mount.c
index 843742e..b10847f 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -2721,3 +2721,80 @@ void f2fs_do_umount(struct f2fs_sb_info *sbi)
 	free(sbi->ckpt);
 	free(sbi->raw_super);
 }
+
+#ifdef WITH_ANDROID
+static int sparse_initialize_meta(struct f2fs_sb_info *sbi)
+{
+	struct f2fs_super_block *sb = sbi->raw_super;
+	u_int32_t sit_seg_count, sit_size;
+	u_int32_t nat_seg_count, nat_size;
+	u_int64_t sit_seg_addr, nat_seg_addr, payload_addr;
+	u_int32_t seg_size = 1 << get_sb(log_blocks_per_seg);
+	int ret;
+
+	sit_seg_addr = get_sb(sit_blkaddr);
+	sit_seg_count = get_sb(segment_count_sit);
+	sit_size = sit_seg_count * seg_size;
+
+	DBG(1, "\tSparse: filling sit area at block offset 0x%08"PRIx64"\n",
+								sit_seg_addr);
+	ret = dev_fill(NULL, sit_seg_addr * F2FS_BLKSIZE,
+					sit_size * F2FS_BLKSIZE);
+	if (ret) {
+		MSG(1, "\tError: While zeroing out the sit area "
+				"on disk!!!\n");
+		return -1;
+	}
+
+	nat_seg_addr = get_sb(nat_blkaddr);
+	nat_seg_count = get_sb(segment_count_nat);
+	nat_size = nat_seg_count * seg_size;
+
+	DBG(1, "\tSparse: filling nat area at block offset 0x%08"PRIx64"\n",
+								nat_seg_addr);
+	ret = dev_fill(NULL, nat_seg_addr * F2FS_BLKSIZE,
+					nat_size * F2FS_BLKSIZE);
+	if (ret) {
+		MSG(1, "\tError: While zeroing out the nat area "
+				"on disk!!!\n");
+		return -1;
+	}
+
+	payload_addr = get_sb(segment0_blkaddr) + 1;
+	ret = dev_fill(NULL, payload_addr * F2FS_BLKSIZE,
+					get_sb(cp_payload) * F2FS_BLKSIZE);
+	if (ret) {
+		MSG(1, "\tError: While zeroing out the sit bitmap area "
+				"on disk!!!\n");
+		return -1;
+	}
+
+	payload_addr += seg_size;
+	ret = dev_fill(NULL, payload_addr * F2FS_BLKSIZE,
+					get_sb(cp_payload) * F2FS_BLKSIZE);
+	if (ret) {
+		MSG(1, "\tError: While zeroing out the sit bitmap area "
+				"on disk!!!\n");
+		return -1;
+	}
+	return 0;
+}
+
+int f2fs_update_sparse_file(struct f2fs_sb_info *sbi)
+{
+	int ret;
+
+	if (!c.sparse_mode)
+		return 0;
+
+	sparse_file_destroy(f2fs_sparse_file);
+	ret = ftruncate(c.devices[0].fd, 0);
+	ASSERT(!ret);
+	lseek(c.devices[0].fd, 0, SEEK_SET);
+	f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE, c.device_size);
+
+	return sparse_initialize_meta(sbi);
+}
+#else
+int f2fs_update_sparse_file(struct f2fs_sb_info *sbi) { return 0; }
+#endif
diff --git a/lib/libf2fs_io.c b/lib/libf2fs_io.c
index bab0a0d..be448e0 100644
--- a/lib/libf2fs_io.c
+++ b/lib/libf2fs_io.c
@@ -360,15 +360,6 @@ int f2fs_finalize_device(void)
 		int64_t chunk_start = (blocks[0] == NULL) ? -1 : 0;
 		uint64_t j;
 
-		if (c.func != MKFS) {
-			sparse_file_destroy(f2fs_sparse_file);
-			ret = ftruncate(c.devices[0].fd, 0);
-			ASSERT(!ret);
-			lseek(c.devices[0].fd, 0, SEEK_SET);
-			f2fs_sparse_file = sparse_file_new(F2FS_BLKSIZE,
-							c.device_size);
-		}
-
 		for (j = 0; j < blocks_count; ++j) {
 			if (chunk_start != -1) {
 				if (j - chunk_start >= MAX_CHUNK_COUNT) {
-- 
2.18.0.rc1

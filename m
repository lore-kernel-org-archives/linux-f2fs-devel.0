From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 3/3] f2fs: add an sysfs entry to control the
	directory level
Date: Thu, 27 Feb 2014 20:38:39 +0900
Message-ID: <1393501119-12976-3-git-send-email-jaegeuk.kim@samsung.com>
References: <1393501119-12976-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1WIzKJ-00048L-I4
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:40:31 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WIzKI-00043G-AK
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 11:40:31 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0N1N006TQKF6VL90@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Thu, 27 Feb 2014 20:40:18 +0900 (KST)
In-reply-to: <1393501119-12976-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch adds an sysfs entry to control dir_level used by the large directory.

The description of this entry is:

 dir_level                    This parameter controls the directory level to
			      support large directory. If a directory has a
			      number of files, it can reduce the file lookup
			      latency by increasing this dir_level value.
			      Otherwise, it needs to decrease this value to
			      reduce the space overhead. The default value is 0.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 Documentation/filesystems/f2fs.txt | 7 +++++++
 fs/f2fs/f2fs.h                     | 3 +++
 fs/f2fs/super.c                    | 7 +++++++
 3 files changed, 17 insertions(+)

diff --git a/Documentation/filesystems/f2fs.txt b/Documentation/filesystems/f2fs.txt
index 8eb06b0..803784e 100644
--- a/Documentation/filesystems/f2fs.txt
+++ b/Documentation/filesystems/f2fs.txt
@@ -195,6 +195,13 @@ Files in /sys/fs/f2fs/<devname>
 			      cleaning operations. The default value is 4096
 			      which covers 8GB block address range.
 
+ dir_level                    This parameter controls the directory level to
+			      support large directory. If a directory has a
+			      number of files, it can reduce the file lookup
+			      latency by increasing this dir_level value.
+			      Otherwise, it needs to decrease this value to
+			      reduce the space overhead. The default value is 0.
+
 ================================================================================
 USAGE
 ================================================================================
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a826916..6f88191 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -196,6 +196,8 @@ struct extent_info {
 #define FADVISE_COLD_BIT	0x01
 #define FADVISE_LOST_PINO_BIT	0x02
 
+#define DEF_DIR_LEVEL		0
+
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
@@ -447,6 +449,7 @@ struct f2fs_sb_info {
 	unsigned int total_valid_node_count;	/* valid node block count */
 	unsigned int total_valid_inode_count;	/* valid inode count */
 	int active_logs;			/* # of active logs */
+	int dir_level;				/* directory level */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 475560e..1bd9153 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -184,6 +184,7 @@ F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, max_small_discards, max_discards);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, ipu_policy, ipu_policy);
 F2FS_RW_ATTR(SM_INFO, f2fs_sm_info, min_ipu_util, min_ipu_util);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, max_victim_search, max_victim_search);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 
 #define ATTR_LIST(name) (&f2fs_attr_##name.attr)
 static struct attribute *f2fs_attrs[] = {
@@ -196,6 +197,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(ipu_policy),
 	ATTR_LIST(min_ipu_util),
 	ATTR_LIST(max_victim_search),
+	ATTR_LIST(dir_level),
 	NULL,
 };
 
@@ -359,6 +361,9 @@ static struct inode *f2fs_alloc_inode(struct super_block *sb)
 	if (test_opt(F2FS_SB(sb), INLINE_XATTR))
 		set_inode_flag(fi, FI_INLINE_XATTR);
 
+	/* Will be used by directory only */
+	fi->i_dir_level = F2FS_SB(sb)->dir_level;
+
 	return &fi->vfs_inode;
 }
 
@@ -785,6 +790,8 @@ static void init_sb_info(struct f2fs_sb_info *sbi)
 
 	for (i = 0; i < NR_COUNT_TYPE; i++)
 		atomic_set(&sbi->nr_pages[i], 0);
+
+	sbi->dir_level = DEF_DIR_LEVEL;
 }
 
 /*
-- 
1.8.4.474.g128a96c


------------------------------------------------------------------------------
Flow-based real-time traffic analytics software. Cisco certified tool.
Monitor traffic, SLAs, QoS, Medianet, WAAS etc. with NetFlow Analyzer
Customize your own dashboards, set traffic alerts and generate reports.
Network behavioral analysis & security monitoring. All-in-one tool.
http://pubads.g.doubleclick.net/gampad/clk?id=126839071&iu=/4140/ostg.clktrk

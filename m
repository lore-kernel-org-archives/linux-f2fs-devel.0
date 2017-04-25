From: Jin Qian <jinqian@google.com>
Subject: [PATCH 1/1] f2fs: sanity check segment count
Date: Tue, 25 Apr 2017 16:28:48 -0700
Message-ID: <20170425232848.23078-1-jinqian@android.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jinqian@google.com>) id 1d39tI-0006Po-Jm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 23:29:04 +0000
Received: from mail-pg0-f48.google.com ([74.125.83.48])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1d39tH-0006iM-RI
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 25 Apr 2017 23:29:04 +0000
Received: by mail-pg0-f48.google.com with SMTP id 63so35043884pgh.0
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 25 Apr 2017 16:29:03 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jaegeuk@kernel.org

From: Jin Qian <jinqian@google.com>

F2FS uses 4 bytes to represent block address. As a result, supported
size of disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.

Signed-off-by: Jin Qian <jinqian@google.com>
---
 fs/f2fs/super.c         | 7 +++++++
 include/linux/f2fs_fs.h | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 97c07a5153e9..4cd3bee6775f 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1494,6 +1494,13 @@ static int sanity_check_raw_super(struct f2fs_sb_info *sbi,
 		return 1;
 	}
 
+	if (le32_to_cpu(raw_super->segment_count) > F2FS_MAX_SEGMENT) {
+		f2fs_msg(sb, KERN_INFO,
+			"Invalid segment count (%u)",
+			le32_to_cpu(raw_super->segment_count));
+		return 1;
+	}
+
 	/* check CP/SIT/NAT/SSA/MAIN_AREA area boundary */
 	if (sanity_check_area_boundary(sbi, bh))
 		return 1;
diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index e2d239ed4c60..661200e6d281 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -302,6 +302,12 @@ struct f2fs_nat_block {
 #define SIT_ENTRY_PER_BLOCK (PAGE_SIZE / sizeof(struct f2fs_sit_entry))
 
 /*
+ * F2FS uses 4 bytes to represent block address. As a result, supported size of
+ * disk is 16 TB and it equals to 16 * 1024 * 1024 / 2 segments.
+ */
+#define F2FS_MAX_SEGMENT       ((16 * 1024 * 1024) / 2)
+
+/*
  * Note that f2fs_sit_entry->vblocks has the following bit-field information.
  * [15:10] : allocation type such as CURSEG_XXXX_TYPE
  * [9:0] : valid block count
-- 
2.13.0.rc0.306.g87b477812d-goog


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

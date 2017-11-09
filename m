From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [RFC PATHC 1/2] f2fs: apply write hints to select the type of segments for buffered write
Date: Thu,  9 Nov 2017 14:51:27 +0900
Message-ID: <1510206688-12767-2-git-send-email-hyc.lee@gmail.com>
References: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1510206688-12767-1-git-send-email-hyc.lee@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Write hints helps F2FS to determine which type of segments would be
selected for buffered write.

This patch implements the mapping from write hints to segment types
as shown below.

  hints               segment type
  -----               ------------
  WRITE_LIFE_SHORT    CURSEG_COLD_DATA
  WRITE_LIFE_EXTREME  CURSEG_HOT_DATA
  others              CURSEG_WARM_DATA

the F2FS poliy for hot/cold seperation has precedence over this hints.
And hints are not applied in in-place update.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/segment.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index c695ff4..45aef53 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2258,6 +2258,18 @@ static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
+int rw_hint_to_seg_type(enum rw_hint hint)
+{
+	switch (hint) {
+	case WRITE_LIFE_SHORT:
+		return CURSEG_HOT_DATA;
+	case WRITE_LIFE_EXTREME:
+		return CURSEG_COLD_DATA;
+	default:
+		return CURSEG_WARM_DATA;
+	}
+}
+
 static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
 	if (fio->type == DATA)
@@ -2292,7 +2304,7 @@ static int __get_segment_type_6(struct f2fs_io_info *fio)
 			return CURSEG_COLD_DATA;
 		if (is_inode_flag_set(inode, FI_HOT_DATA))
 			return CURSEG_HOT_DATA;
-		return CURSEG_WARM_DATA;
+		return rw_hint_to_seg_type(inode->i_write_hint);
 	} else {
 		if (IS_DNODE(fio->page))
 			return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
-- 
1.9.1

From: Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH 2/3] f2fs: support passing down write hints to
 block layer with F2FS policy
Date: Mon, 22 Jan 2018 19:49:08 +0900
Message-ID: <1516618149-1495-3-git-send-email-hyc.lee@gmail.com>
References: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <hyc.lee@gmail.com>) id 1edZfp-0003gb-JA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Jan 2018 10:49:57 +0000
Received: from lgeamrelo12.lge.com ([156.147.23.52])
 by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.89)
 id 1edZfn-0007DJ-OA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 22 Jan 2018 10:49:57 +0000
In-Reply-To: <1516618149-1495-1-git-send-email-hyc.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>
Cc: linux-fsdevel@vger.kernel.org, kernel-team@lge.com, Hyunchul Lee <cheol.lee@lge.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Hyunchul Lee <cheol.lee@lge.com>

Add 'whint_mode=fs-based' mount option. In this mode, F2FS passes
down write hints with its policy.

* whint_mode=fs-based. F2FS passes down hints with its policy.

User                  F2FS                     Block
----                  ----                     -----
                      META                     WRITE_LIFE_MEDIUM;
                      HOT_NODE                 WRITE_LIFE_NOT_SET
                      WARM_NODE                "
                      COLD_NODE                WRITE_LIFE_NONE
ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
extension list        "                        "

-- buffered io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
WRITE_LIFE_NONE       "                        "
WRITE_LIFE_MEDIUM     "                        "
WRITE_LIFE_LONG       "                        "

-- direct io
WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG

Many thanks to Chao Yu and Jaegeuk Kim for comments to
implement this patch.

Signed-off-by: Hyunchul Lee <cheol.lee@lge.com>
---
 fs/f2fs/f2fs.h    |  1 +
 fs/f2fs/segment.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++--
 fs/f2fs/super.c   |  5 +++++
 3 files changed, 53 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d7c2797..898f37d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1038,6 +1038,7 @@ enum {
 enum {
 	WHINT_MODE_OFF,		/* not pass down write hints */
 	WHINT_MODE_USER,	/* try to pass down hints given by users */
+	WHINT_MODE_FS,		/* pass down hints with F2FS policy */
 };
 
 struct f2fs_sb_info {
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 8bc1fc1..b7cae61 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2491,6 +2491,32 @@ int rw_hint_to_seg_type(enum rw_hint hint)
  *
  * 2) whint_mode=off. F2FS only passes down WRITE_LIFE_NOT_SET.
  *
+ * 3) whint_mode=fs-based. F2FS passes down hints with its policy.
+ *
+ * User                  F2FS                     Block
+ * ----                  ----                     -----
+ *                       META                     WRITE_LIFE_MEDIUM;
+ *                       HOT_NODE                 WRITE_LIFE_NOT_SET
+ *                       WARM_NODE                "
+ *                       COLD_NODE                WRITE_LIFE_NONE
+ * ioctl(COLD)           COLD_DATA                WRITE_LIFE_EXTREME
+ * extension list        "                        "
+ *
+ * -- buffered io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_LONG
+ * WRITE_LIFE_NONE       "                        "
+ * WRITE_LIFE_MEDIUM     "                        "
+ * WRITE_LIFE_LONG       "                        "
+ *
+ * -- direct io
+ * WRITE_LIFE_EXTREME    COLD_DATA                WRITE_LIFE_EXTREME
+ * WRITE_LIFE_SHORT      HOT_DATA                 WRITE_LIFE_SHORT
+ * WRITE_LIFE_NOT_SET    WARM_DATA                WRITE_LIFE_NOT_SET
+ * WRITE_LIFE_NONE       "                        WRITE_LIFE_NONE
+ * WRITE_LIFE_MEDIUM     "                        WRITE_LIFE_MEDIUM
+ * WRITE_LIFE_LONG       "                        WRITE_LIFE_LONG
  */
 
 enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
@@ -2509,9 +2535,28 @@ enum rw_hint io_type_to_rw_hint(struct f2fs_sb_info *sbi,
 		} else {
 			return WRITE_LIFE_NOT_SET;
 		}
-	} else {
-		return WRITE_LIFE_NOT_SET;
+	} else if (sbi->whint_mode == WHINT_MODE_FS) {
+		if (type == DATA) {
+			switch (temp) {
+			case COLD:
+				return WRITE_LIFE_EXTREME;
+			case HOT:
+				return WRITE_LIFE_SHORT;
+			default:
+				return WRITE_LIFE_LONG;
+			}
+		} else if (type == NODE) {
+			switch (temp) {
+			case COLD:
+				return WRITE_LIFE_NONE;
+			default:
+				return WRITE_LIFE_NOT_SET;
+			}
+		} else if (type == META) {
+			return WRITE_LIFE_MEDIUM;
+		}
 	}
+	return WRITE_LIFE_NOT_SET;
 }
 
 static int __get_segment_type_2(struct f2fs_io_info *fio)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9e22926..2115285 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -691,6 +691,9 @@ static int parse_options(struct super_block *sb, char *options)
 			} else if (strlen(name) == 3 &&
 					!strncmp(name, "off", 3)) {
 				sbi->whint_mode = WHINT_MODE_OFF;
+			} else if (strlen(name) == 8 &&
+					!strncmp(name, "fs-based", 8)) {
+				sbi->whint_mode = WHINT_MODE_FS;
 			} else {
 				kfree(name);
 				return -EINVAL;
@@ -1245,6 +1248,8 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	f2fs_show_quota_options(seq, sbi->sb);
 	if (sbi->whint_mode == WHINT_MODE_USER)
 		seq_printf(seq, ",whint_mode=%s", "user-based");
+	else if (sbi->whint_mode == WHINT_MODE_FS)
+		seq_printf(seq, ",whint_mode=%s", "fs-based");
 
 	return 0;
 }
-- 
1.9.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

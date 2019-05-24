From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH] f2fs-tools: detect corrupted sit journal
Date: Fri, 24 May 2019 16:52:41 +0800
Message-ID: <20190524085241.111087-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1hU5wq-0000eg-Qm
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:53:08 +0000
Received: from szxga02-in.huawei.com ([45.249.212.188] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hU5wo-00CuWD-VH
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 24 May 2019 08:53:08 +0000
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
Cc: jaegeuk@kernel.org

Enables to detect corrupted sit journal
a) total count of entries.
b) segment no. in entry.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fsck/mount.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/fsck/mount.c b/fsck/mount.c
index a627f1d..909c1f4 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -1912,8 +1912,25 @@ static int build_sit_entries(struct f2fs_sb_info *sbi)
 	}
 
 	free(sit_blk);
+
+	if (sits_in_cursum(journal) > SIT_JOURNAL_ENTRIES) {
+		MSG(0, "\tError: build_sit_entries truncate n_sits(%u) to "
+			"SIT_JOURNAL_ENTRIES(%lu)\n",
+			sits_in_cursum(journal), SIT_JOURNAL_ENTRIES);
+		journal->n_sits = cpu_to_le16(SIT_JOURNAL_ENTRIES);
+		c.fix_on = 1;
+	}
+
 	for (i = 0; i < sits_in_cursum(journal); i++) {
 		segno = le32_to_cpu(segno_in_journal(journal, i));
+
+		if (segno >= TOTAL_SEGS(sbi)) {
+			MSG(0, "\tError: build_sit_entries: segno(%u) is invalid!!!\n", segno);
+			journal->n_sits = cpu_to_le16(i);
+			c.fix_on = 1;
+			continue;
+		}
+
 		se = &sit_i->sentries[segno];
 		sit = sit_in_journal(journal, i);
 
-- 
2.18.0.rc1

From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: check curseg space before foreground GC
Date: Mon, 30 Oct 2017 17:49:54 +0800
Message-ID: <20171030094954.80691-2-yuchao0@huawei.com>
References: <20171030094954.80691-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <yuchao0@huawei.com>) id 1e96iY-0001V9-RE
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:50:50 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.76) id 1e96iX-0005sb-BX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 30 Oct 2017 09:50:50 +0000
In-Reply-To: <20171030094954.80691-1-yuchao0@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When we are closing to trigger foreground GC, if there are only a few
of dirty metas, we can log these dirty metas in left space of opened
segments instead of triggering foreground GC.

With this patch, total count of foreground GC triggered by
test/generic/* of fstest suit reduce from 254 to 184.

So let's do the check before foreground GC anyway.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.h | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 245acb34cab5..d1d394cdf61d 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -497,6 +497,33 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 	return GET_SEC_FROM_SEG(sbi, (unsigned int)reserved_segments(sbi));
 }
 
+static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi)
+{
+	unsigned int node_blocks = get_pages(sbi, F2FS_DIRTY_NODES) +
+					get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int dent_blocks = get_pages(sbi, F2FS_DIRTY_DENTS);
+	unsigned int segno, left_blocks;
+	int i;
+
+	/* check current node segment */
+	for (i = CURSEG_HOT_NODE; i <= CURSEG_COLD_NODE; i++) {
+		segno = CURSEG_I(sbi, i)->segno;
+		left_blocks = sbi->blocks_per_seg -
+			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+
+		if (node_blocks > left_blocks)
+			return false;
+	}
+
+	/* check current data segment */
+	segno = CURSEG_I(sbi, CURSEG_HOT_DATA)->segno;
+	left_blocks = sbi->blocks_per_seg -
+			get_seg_entry(sbi, segno)->ckpt_valid_blocks;
+	if (dent_blocks > left_blocks)
+		return false;
+	return true;
+}
+
 static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 					int freed, int needed)
 {
@@ -507,6 +534,9 @@ static inline bool has_not_enough_free_secs(struct f2fs_sb_info *sbi,
 	if (unlikely(is_sbi_flag_set(sbi, SBI_POR_DOING)))
 		return false;
 
+	if (free_sections(sbi) + freed == reserved_sections(sbi) + needed &&
+			has_curseg_enough_space(sbi))
+		return false;
 	return (free_sections(sbi) + freed) <=
 		(node_secs + 2 * dent_secs + imeta_secs +
 		reserved_sections(sbi) + needed);
-- 
2.13.1.388.g69e6b9b4f4a9


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

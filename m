From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: use fio instead of multiple parameters
Date: Wed, 10 May 2017 16:48:16 -0700
Message-ID: <20170510234816.3373-3-jaegeuk@kernel.org>
References: <20170510234816.3373-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1d8bLK-0000p8-Gk
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 23:48:30 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1d8bLJ-0006Iq-Fa
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 10 May 2017 23:48:30 +0000
In-Reply-To: <20170510234816.3373-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch just changes using fio instead of parameters.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.c | 41 +++++++++++++++++++++--------------------
 1 file changed, 21 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 38bb675976e2..c9f3a2faee21 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2039,61 +2039,62 @@ static bool __has_curseg_space(struct f2fs_sb_info *sbi, int type)
 	return false;
 }
 
-static int __get_segment_type_2(struct page *page, enum page_type p_type)
+static int __get_segment_type_2(struct f2fs_io_info *fio)
 {
-	if (p_type == DATA)
+	if (fio->type == DATA)
 		return CURSEG_HOT_DATA;
 	else
 		return CURSEG_HOT_NODE;
 }
 
-static int __get_segment_type_4(struct page *page, enum page_type p_type)
+static int __get_segment_type_4(struct f2fs_io_info *fio)
 {
-	if (p_type == DATA) {
-		struct inode *inode = page->mapping->host;
+	if (fio->type == DATA) {
+		struct inode *inode = fio->page->mapping->host;
 
 		if (S_ISDIR(inode->i_mode))
 			return CURSEG_HOT_DATA;
 		else
 			return CURSEG_COLD_DATA;
 	} else {
-		if (IS_DNODE(page) && is_cold_node(page))
+		if (IS_DNODE(fio->page) && is_cold_node(fio->page))
 			return CURSEG_WARM_NODE;
 		else
 			return CURSEG_COLD_NODE;
 	}
 }
 
-static int __get_segment_type_6(struct page *page, enum page_type p_type)
+static int __get_segment_type_6(struct f2fs_io_info *fio)
 {
-	if (p_type == DATA) {
-		struct inode *inode = page->mapping->host;
+	if (fio->type == DATA) {
+		struct inode *inode = fio->page->mapping->host;
 
-		if (is_cold_data(page) || file_is_cold(inode))
+		if (is_cold_data(fio->page) || file_is_cold(inode))
 			return CURSEG_COLD_DATA;
 		if (is_inode_flag_set(inode, FI_HOT_DATA))
 			return CURSEG_HOT_DATA;
 		return CURSEG_WARM_DATA;
 	} else {
-		if (IS_DNODE(page))
-			return is_cold_node(page) ? CURSEG_WARM_NODE :
+		if (IS_DNODE(fio->page))
+			return is_cold_node(fio->page) ? CURSEG_WARM_NODE :
 						CURSEG_HOT_NODE;
 		return CURSEG_COLD_NODE;
 	}
 }
 
-static int __get_segment_type(struct page *page, enum page_type p_type)
+static int __get_segment_type(struct f2fs_io_info *fio)
 {
-	switch (F2FS_P_SB(page)->active_logs) {
+	switch (fio->sbi->active_logs) {
 	case 2:
-		return __get_segment_type_2(page, p_type);
+		return __get_segment_type_2(fio);
 	case 4:
-		return __get_segment_type_4(page, p_type);
+		return __get_segment_type_4(fio);
 	}
+
 	/* NR_CURSEG_TYPE(6) logs by default */
-	f2fs_bug_on(F2FS_P_SB(page),
-		F2FS_P_SB(page)->active_logs != NR_CURSEG_TYPE);
-	return __get_segment_type_6(page, p_type);
+	f2fs_bug_on(fio->sbi, fio->sbi->active_logs != NR_CURSEG_TYPE);
+
+	return __get_segment_type_6(fio);
 }
 
 void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
@@ -2139,7 +2140,7 @@ void allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 
 static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 {
-	int type = __get_segment_type(fio->page, fio->type);
+	int type = __get_segment_type(fio);
 	int err;
 
 	if (fio->type == NODE || fio->type == DATA)
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH v3] f2fs: only flush the single temp bio cache
 which owns the target page
Date: Tue, 13 Nov 2018 11:57:32 +0800
Message-ID: <1542081452-66059-1-git-send-email-yunlong.song@huawei.com>
References: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yunlong.song@huawei.com>) id 1gMPpx-0001uq-Av
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Nov 2018 03:58:01 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1gMPpq-007H30-7t
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Nov 2018 03:58:01 +0000
In-Reply-To: <1540368651-14353-1-git-send-email-yunlong.song@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, chao@kernel.org, yuchao0@huawei.com, yunlong.song@icloud.com, yunlong.song@huawei.com
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, miaoxie@huawei.com

Previously, when f2fs finds which temp bio cache owns the target page,
it will flush all the three temp bio caches, but we only need to flush
one single bio cache indeed, which can help to keep bio merged.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 37 ++++++++++---------------------------
 1 file changed, 10 insertions(+), 27 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6e0ffb1..cd8f670 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -372,29 +372,6 @@ static bool __has_merged_page(struct f2fs_bio_info *io, struct inode *inode,
 	return false;
 }
 
-static bool has_merged_page(struct f2fs_sb_info *sbi, struct inode *inode,
-						struct page *page, nid_t ino,
-						enum page_type type)
-{
-	enum page_type btype = PAGE_TYPE_OF_BIO(type);
-	enum temp_type temp;
-	struct f2fs_bio_info *io;
-	bool ret = false;
-
-	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
-		io = sbi->write_io[btype] + temp;
-
-		down_read(&io->io_rwsem);
-		ret = __has_merged_page(io, inode, page, ino);
-		up_read(&io->io_rwsem);
-
-		/* TODO: use HOT temp only for meta pages now. */
-		if (ret || btype == META)
-			break;
-	}
-	return ret;
-}
-
 static void __f2fs_submit_merged_write(struct f2fs_sb_info *sbi,
 				enum page_type type, enum temp_type temp)
 {
@@ -420,13 +397,19 @@ static void __submit_merged_write_cond(struct f2fs_sb_info *sbi,
 				nid_t ino, enum page_type type, bool force)
 {
 	enum temp_type temp;
-
-	if (!force && !has_merged_page(sbi, inode, page, ino, type))
-		return;
+	bool ret = true;
 
 	for (temp = HOT; temp < NR_TEMP_TYPE; temp++) {
+		if (!force)	{
+			enum page_type btype = PAGE_TYPE_OF_BIO(type);
+			struct f2fs_bio_info *io = sbi->write_io[btype] + temp;
 
-		__f2fs_submit_merged_write(sbi, type, temp);
+			down_read(&io->io_rwsem);
+			ret = __has_merged_page(io, inode, page, ino);
+			up_read(&io->io_rwsem);
+		}
+		if (ret)
+			__f2fs_submit_merged_write(sbi, type, temp);
 
 		/* TODO: use HOT temp only for meta pages now. */
 		if (type >= META)
-- 
1.8.5.2

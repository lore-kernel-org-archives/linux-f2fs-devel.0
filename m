From: Yunlong Song <yunlong.song@huawei.com>
Subject: [PATCH 1/2] f2fs: enable to gc page whose inode already
 atomic commit
Date: Sat, 3 Feb 2018 10:47:47 +0800
Message-ID: <1517626068-49739-1-git-send-email-yunlong.song@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-3.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <yunlong.song@huawei.com>) id 1ehnsF-00007v-69
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 03 Feb 2018 02:48:15 +0000
Received: from [45.249.212.35] (helo=huawei.com)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1ehnsC-0005X3-VT
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 03 Feb 2018 02:48:15 +0000
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
Cc: shengyong1@huawei.com, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, heyunlei@huawei.com, linux-fsdevel@vger.kernel.org, miaoxie@huawei.com

If inode has already started to atomic commit, then set_page_dirty will
not mix the gc pages with the inmem atomic pages, so the page can be
gced safely.

Signed-off-by: Yunlong Song <yunlong.song@huawei.com>
---
 fs/f2fs/data.c | 5 ++---
 fs/f2fs/gc.c   | 6 ++++--
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7435830..edafcb6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1580,14 +1580,13 @@ bool should_update_outplace(struct inode *inode, struct f2fs_io_info *fio)
 		return true;
 	if (S_ISDIR(inode->i_mode))
 		return true;
-	if (f2fs_is_atomic_file(inode))
-		return true;
 	if (fio) {
 		if (is_cold_data(fio->page))
 			return true;
 		if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
 			return true;
-	}
+	} else if (f2fs_is_atomic_file(inode))
+		return true;
 	return false;
 }
 
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b9d93fd..84ab3ff 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -622,7 +622,8 @@ static void move_data_block(struct inode *inode, block_t bidx,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) &&
+		!f2fs_is_commit_atomic_write(inode))
 		goto out;
 
 	if (f2fs_is_pinned_file(inode)) {
@@ -729,7 +730,8 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off))
 		goto out;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) &&
+		!f2fs_is_commit_atomic_write(inode))
 		goto out;
 	if (f2fs_is_pinned_file(inode)) {
 		if (gc_type == FG_GC)
-- 
1.8.5.2


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

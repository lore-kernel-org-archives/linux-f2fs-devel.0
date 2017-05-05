From: Hou Pengyang <houpengyang@huawei.com>
Subject: [PATCH 3/3] f2fs: try IPU if sync io is blocked by cp
Date: Fri, 5 May 2017 09:12:29 +0000
Message-ID: <20170505091229.156181-4-houpengyang@huawei.com>
References: <20170505091229.156181-1-houpengyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <houpengyang@huawei.com>) id 1d6ZII-00042G-Sj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:58 +0000
Received: from szxga03-in.huawei.com ([45.249.212.189])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d6ZIH-0000bp-Ha
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 05 May 2017 09:12:58 +0000
In-Reply-To: <20170505091229.156181-1-houpengyang@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: chao@kernel.org, linux-f2fs-devel@lists.sourceforge.net

For sync io, if it is blocked by cp, we try to do IPU for this page.

Signed-off-by: Hou Pengyang <houpengyang@huawei.com>
---
 fs/f2fs/data.c | 36 ++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h |  5 +++++
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e41f5ed..26362ae 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1329,9 +1329,9 @@ static int encrypt_one_page(struct f2fs_io_info *fio)
 	return PTR_ERR(fio->encrypted_page);
 }
 
-static inline bool need_inplace_update(struct f2fs_io_info *fio)
+static inline bool safe_for_ipu(struct f2fs_io_info *fio)
 {
-	struct inode *inode = fio->page->mapping->host;
+	struct inode *inode = fio->page->mapping->host;
 
 	if (S_ISDIR(inode->i_mode) || f2fs_is_atomic_file(inode))
 		return false;
@@ -1339,6 +1339,16 @@ static inline bool need_inplace_update(struct f2fs_io_info *fio)
 		return false;
 	if (IS_ATOMIC_WRITTEN_PAGE(fio->page))
 		return false;
+	return true;
+
+}
+
+static inline bool need_inplace_update(struct f2fs_io_info *fio)
+{
+	struct inode *inode = fio->page->mapping->host;
+
+	if (!safe_for_ipu(fio))
+		return false;
 
 	return need_inplace_update_policy(inode, fio);
 }
@@ -1352,6 +1362,13 @@ static inline bool valid_ipu_blkaddr(struct f2fs_io_info *fio)
 	return true;
 }
 
+static inline bool is_sync_io(struct f2fs_io_info *fio)
+{
+	if (fio && fio->op == REQ_OP_WRITE && fio->op_flags & REQ_SYNC)
+		return true;
+	return false;
+}
+
 int do_write_data_page(struct f2fs_io_info *fio)
 {
 	struct page *page = fio->page;
@@ -1393,8 +1410,19 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	} else
 		return err;
 
-	if (fio->need_lock)
-		f2fs_lock_op(fio->sbi);
+	/*
+	 * After checking all the IPU senario, we try to lock_op
+	 * If lock_op fail, we do another IPU try for sync io.
+	 */
+	if (fio->need_lock && !f2fs_try_lock_op(fio->sbi)) {
+		if (valid_ipu_blkaddr(fio) &&
+				is_sync_io(fio) && safe_for_ipu(fio)) {
+			fio->need_lock = false;
+			ipu_force = true;
+		} else {
+			f2fs_lock_op(fio->sbi);
+		}
+	}
 
 	if (!dn.node_page_locked) {
 		/*
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2d50d7b..e820253 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1268,6 +1268,11 @@ static inline bool enabled_nat_bits(struct f2fs_sb_info *sbi,
 	return (cpc) ? (cpc->reason & CP_UMOUNT) && set : set;
 }
 
+static inline int f2fs_try_lock_op(struct f2fs_sb_info *sbi)
+{
+	return down_read_trylock(&sbi->cp_rwsem);
+}
+
 static inline void f2fs_lock_op(struct f2fs_sb_info *sbi)
 {
 	down_read(&sbi->cp_rwsem);
-- 
2.10.1


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

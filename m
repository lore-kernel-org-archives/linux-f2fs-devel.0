From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/2] f2fs: unlock cp_rwsem early for IPU writes
Date: Tue, 18 Apr 2017 19:23:39 +0800
Message-ID: <20170418112340.96171-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1d0RFC-0005Ak-KU
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 11:24:26 +0000
Received: from szxga01-in.huawei.com ([45.249.212.187]
	helo=dggrg01-dlp.huawei.com)
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1d0RFA-0003BR-Bm
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 18 Apr 2017 11:24:26 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: chao@kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

For IPU writes, there won't be any udpates in dnode page since we
will reuse old block address instead of allocating new one, so we
don't need to lock cp_rwsem during IPU IO submitting.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/data.c | 6 +++++-
 fs/f2fs/f2fs.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e984a42eabf4..32d5a3b38a3f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1357,6 +1357,8 @@ int do_write_data_page(struct f2fs_io_info *fio)
 			!is_cold_data(page) &&
 			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
+		f2fs_unlock_op(F2FS_I_SB(inode));
+		fio->cp_rwsem_locked = false;
 		err = rewrite_data_page(fio);
 		set_inode_flag(inode, FI_UPDATE_WRITE);
 		trace_f2fs_do_write_data_page(page, IPU);
@@ -1392,6 +1394,7 @@ static int __write_data_page(struct page *page, bool *submitted,
 		.page = page,
 		.encrypted_page = NULL,
 		.submitted = false,
+		.cp_rwsem_locked = true,
 	};
 
 	trace_f2fs_writepage(page, DATA);
@@ -1449,7 +1452,8 @@ static int __write_data_page(struct page *page, bool *submitted,
 		err = do_write_data_page(&fio);
 	if (F2FS_I(inode)->last_disk_size < psize)
 		F2FS_I(inode)->last_disk_size = psize;
-	f2fs_unlock_op(sbi);
+	if (fio.cp_rwsem_locked)
+		f2fs_unlock_op(sbi);
 done:
 	if (err && err != -ENOENT)
 		goto redirty_out;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index a39749412803..5c3e60551df5 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -795,6 +795,7 @@ struct f2fs_io_info {
 	struct page *page;	/* page to be written */
 	struct page *encrypted_page;	/* encrypted page */
 	bool submitted;		/* indicate IO submission */
+	bool cp_rwsem_locked;	/* indicate cp_rwsem is held */
 };
 
 #define is_read_io(rw) ((rw) == READ)
-- 
2.12.2.510.ge1104a5ee539


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

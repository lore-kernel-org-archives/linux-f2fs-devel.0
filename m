From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2] f2fs: commit atomic written page in LFS mode
Date: Wed, 28 Oct 2015 17:56:14 +0800
Message-ID: <01ab01d11166$f9579ce0$ec06d6a0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We should always commit atomic written pages in LFS mode, otherwise data
will become corrupted if we encounter suddent power cut after partial
pages committed in IPU mode.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e070ac0..509caee 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1093,6 +1093,7 @@ int do_write_data_page(struct f2fs_io_info *fio)
 	 */
 	if (unlikely(fio->blk_addr != NEW_ADDR &&
 			!is_cold_data(page) &&
+			!IS_ATOMIC_WRITTEN_PAGE(page) &&
 			need_inplace_update(inode))) {
 		rewrite_data_page(fio);
 		set_inode_flag(F2FS_I(inode), FI_UPDATE_WRITE);
-- 
2.6.1

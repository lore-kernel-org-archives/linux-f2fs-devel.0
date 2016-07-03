From: Chao Yu <chao@kernel.org>
Subject: [PATCH 3/4] f2fs: fix to redirty page if fail to gc data
	page
Date: Sun,  3 Jul 2016 22:05:13 +0800
Message-ID: <1467554714-5125-3-git-send-email-chao@kernel.org>
References: <1467554714-5125-1-git-send-email-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1bJi3Z-0006pe-Us
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:33 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1bJi3Z-0005c3-04
	for linux-f2fs-devel@lists.sourceforge.net;
	Sun, 03 Jul 2016 14:07:33 +0000
In-Reply-To: <1467554714-5125-1-git-send-email-chao@kernel.org>
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

If we fail to move data page during foreground GC, we should give another
chance to writeback that page which was set dirty previously by writer.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index d888490..b744465 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -653,12 +653,23 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type)
 			.page = page,
 			.encrypted_page = NULL,
 		};
+		bool is_dirty = PageDirty(page);
+		int err;
+
+retry:
 		set_page_dirty(page);
 		f2fs_wait_on_page_writeback(page, DATA, true);
 		if (clear_page_dirty_for_io(page))
 			inode_dec_dirty_pages(inode);
+
 		set_cold_data(page);
-		do_write_data_page(&fio);
+
+		err = do_write_data_page(&fio);
+		if (err == -ENOMEM && is_dirty) {
+			congestion_wait(BLK_RW_ASYNC, HZ/50);
+			goto retry;
+		}
+
 		clear_cold_data(page);
 	}
 out:
-- 
2.7.2


------------------------------------------------------------------------------
Attend Shape: An AT&T Tech Expo July 15-16. Meet us at AT&T Park in San
Francisco, CA to explore cutting-edge tech and listen to tech luminaries
present their vision of the future. This family event has something for
everyone, including kids. Get more information and register today.
http://sdm.link/attshape

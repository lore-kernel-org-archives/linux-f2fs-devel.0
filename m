From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/2] f2fs: fix error path of move_data_page
Date: Mon, 28 May 2018 16:59:27 +0800
Message-ID: <20180528085927.91965-2-yuchao0@huawei.com>
References: <20180528085927.91965-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180528085927.91965-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes error path of move_data_page:
- clear cold data flag if it fails to write page.
- redirty page for non-ENOMEM case.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/gc.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 50bb8fc25275..885032fc3a61 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -780,9 +780,14 @@ static void move_data_page(struct inode *inode, block_t bidx, int gc_type,
 		set_cold_data(page);
 
 		err = do_write_data_page(&fio);
-		if (err == -ENOMEM && is_dirty) {
-			congestion_wait(BLK_RW_ASYNC, HZ/50);
-			goto retry;
+		if (err) {
+			clear_cold_data(page);
+			if (err == -ENOMEM) {
+				congestion_wait(BLK_RW_ASYNC, HZ/50);
+				goto retry;
+			}
+			if (is_dirty)
+				set_page_dirty(page);
 		}
 	}
 out:
-- 
2.17.0.391.g1f1cddd558b5

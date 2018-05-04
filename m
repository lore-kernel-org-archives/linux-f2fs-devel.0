From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH] f2fs: avoid fsync() failure caused by EAGAIN in writepage()
Date: Fri,  4 May 2018 10:52:10 -0700
Message-ID: <20180504175210.26903-1-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

pageout() in MM traslates EAGAIN, so calls handle_write_error()
 -> mapping_set_error() -> set_bit(AS_EIO, ...).
 file_write_and_wait_range() will see EIO error, which is critical
 to return value of fsync() followed by atomic_write failure to user.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5477fc09c3cd..ac8720fa5868 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1904,7 +1904,13 @@ static int __write_data_page(struct page *page, bool *submitted,
 
 redirty_out:
 	redirty_page_for_writepage(wbc, page);
-	if (!err)
+	/*
+	 * pageout() in MM traslates EAGAIN, so calls handle_write_error()
+	 * -> mapping_set_error() -> set_bit(AS_EIO, ...).
+	 * file_write_and_wait_range() will see EIO error, which is critical
+	 * to return value of fsync() followed by atomic_write failure to user.
+	 */
+	if (!err || wbc->for_reclaim)
 		return AOP_WRITEPAGE_ACTIVATE;
 	unlock_page(page);
 	return err;
-- 
2.17.0.484.g0c8726318c-goog

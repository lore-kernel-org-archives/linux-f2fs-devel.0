From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 3/3] f2fs: fix conflict on page->private usage
Date: Fri, 29 Jan 2016 16:52:38 -0800
Message-ID: <1454115158-81227-3-git-send-email-jaegeuk@kernel.org>
References: <1454115158-81227-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1454115158-81227-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

This patch fixes confilct on page->private value between f2fs_trace_pid and
atomic page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/segment.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index ee44d34..cd7111b 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -183,7 +183,7 @@ struct segment_allocation {
  * this value is set in page as a private data which indicate that
  * the page is atomically written, and it is in inmem_pages list.
  */
-#define ATOMIC_WRITTEN_PAGE		0x0000ffff
+#define ATOMIC_WRITTEN_PAGE		((unsigned long)-1)
 
 #define IS_ATOMIC_WRITTEN_PAGE(page)			\
 		(page_private(page) == (unsigned long)ATOMIC_WRITTEN_PAGE)
-- 
2.6.3

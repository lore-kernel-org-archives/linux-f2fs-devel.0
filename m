From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] f2fs: make clean the page before writing
Date: Tue, 25 Nov 2014 15:39:56 -0800
Message-ID: <1416958796-39186-2-git-send-email-jaegeuk@kernel.org>
References: <1416958796-39186-1-git-send-email-jaegeuk@kernel.org>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1416958796-39186-1-git-send-email-jaegeuk@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

If a page is set to be written to the disk, we can make clean the page.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inline.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 914b6d3..7c96c27 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -110,6 +110,9 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	kunmap_atomic(dst_addr);
 	SetPageUptodate(page);
 no_update:
+	/* clear dirty state */
+	clear_page_dirty_for_io(page);
+
 	/* write data page to try to make data consistent */
 	set_page_writeback(page);
 
-- 
2.1.1

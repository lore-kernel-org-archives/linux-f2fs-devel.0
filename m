From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/3] f2fs: fix to clear GCed flag for atomic written page
Date: Thu, 22 Oct 2015 18:18:11 +0800
Message-ID: <031801d10cb3$0ba86680$22f93380$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Atomic write page can be GCed, after committing this kind of page, we should
clear the GCed flag for it.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 7efd96ad..f77b325 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -253,6 +253,7 @@ int commit_inmem_pages(struct inode *inode, bool abort)
 					unlock_page(cur->page);
 					break;
 				}
+				clear_cold_data(cur->page);
 				submit_bio = true;
 			}
 		} else {
-- 
2.6.1

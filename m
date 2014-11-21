From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH] f2fs: fix wrong data structure when create slab
Date: Fri, 21 Nov 2014 15:42:07 +0900
Message-ID: <1416552127-15899-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

It used nat_entry_set when create slab for sit_entry_set.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/segment.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index e094675..9de857f 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2231,7 +2231,7 @@ int __init create_segment_manager_caches(void)
 		goto fail;
 
 	sit_entry_set_slab = f2fs_kmem_cache_create("sit_entry_set",
-			sizeof(struct nat_entry_set));
+			sizeof(struct sit_entry_set));
 	if (!sit_entry_set_slab)
 		goto destory_discard_entry;
 
-- 
1.9.1


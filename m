From: Changman Lee <cm224.lee@samsung.com>
Subject: [PATCH 2/2] f2fs: no more dirty_nat_entires when flushing
Date: Tue, 25 Nov 2014 12:44:24 +0900
Message-ID: <1416887064-21207-2-git-send-email-cm224.lee@samsung.com>
References: <1416887064-21207-1-git-send-email-cm224.lee@samsung.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <1416887064-21207-1-git-send-email-cm224.lee@samsung.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Changman Lee <cm224.lee@samsung.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

After flushing dirty nat entries, it has to be no more dirty nat
entries.

Signed-off-by: Changman Lee <cm224.lee@samsung.com>
---
 fs/f2fs/node.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index f6bd222..fc1077b 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1925,10 +1925,10 @@ static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
 	else
 		f2fs_put_page(page, 1);
 
-	if (!set->entry_cnt) {
-		radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
-		kmem_cache_free(nat_entry_set_slab, set);
-	}
+	f2fs_bug_on(sbi, set->entry_cnt);
+
+	radix_tree_delete(&NM_I(sbi)->nat_set_root, set->set);
+	kmem_cache_free(nat_entry_set_slab, set);
 }
 
 /*
-- 
1.9.1


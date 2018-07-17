From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 2/5] f2fs: clean up with get_current_nat_page
Date: Tue, 17 Jul 2018 20:41:46 +0800
Message-ID: <20180717124149.32523-2-yuchao0@huawei.com>
References: <20180717124149.32523-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180717124149.32523-1-yuchao0@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Just cleanup, no logic change.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/node.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 99dc1a1d02e3..021d095dc3c5 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -113,25 +113,22 @@ static void clear_node_page_dirty(struct page *page)
 
 static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
-	pgoff_t index = current_nat_addr(sbi, nid);
-	return f2fs_get_meta_page_nofail(sbi, index);
+	return f2fs_get_meta_page_nofail(sbi, current_nat_addr(sbi, nid));
 }
 
 static struct page *get_next_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
 {
 	struct page *src_page;
 	struct page *dst_page;
-	pgoff_t src_off;
 	pgoff_t dst_off;
 	void *src_addr;
 	void *dst_addr;
 	struct f2fs_nm_info *nm_i = NM_I(sbi);
 
-	src_off = current_nat_addr(sbi, nid);
-	dst_off = next_nat_addr(sbi, src_off);
+	dst_off = next_nat_addr(sbi, current_nat_addr(sbi, nid));
 
 	/* get current nat block page with lock */
-	src_page = f2fs_get_meta_page(sbi, src_off);
+	src_page = get_current_nat_page(sbi, nid);
 	dst_page = f2fs_grab_meta_page(sbi, dst_off);
 	f2fs_bug_on(sbi, PageDirty(src_page));
 
-- 
2.18.0.rc1

From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH v2] f2fs: reuse read_inline_data for f2fs_convert_inline_page
Date: Fri, 19 Feb 2016 16:02:51 +0800
Message-ID: <1455868971-1493-1-git-send-email-shawn.lin@rock-chips.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net
Cc: Chao Yu <chao2.yu@samsung.com>, linux-kernel@vger.kernel.org, Shawn Lin <shawn.lin@rock-chips.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

f2fs_convert_inline_page introduce what read_inline_data
already does for copying out the inline data from inode_page.
We can use read_inline_data instead to simplify the code.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

Changes in v2:
- rework the commit msg to fit the changes
- further simplify the code suggested by Chao Yu

 fs/f2fs/inline.c | 16 +---------------
 1 file changed, 1 insertion(+), 15 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index d27347e..3e3bc26 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -105,7 +105,6 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 
 int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 {
-	void *src_addr, *dst_addr;
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(dn->inode),
 		.type = DATA,
@@ -115,8 +114,6 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 	};
 	int dirty, err;
 
-	f2fs_bug_on(F2FS_I_SB(dn->inode), page->index);
-
 	if (!f2fs_exist_data(dn->inode))
 		goto clear_out;
 
@@ -125,19 +122,8 @@ int f2fs_convert_inline_page(struct dnode_of_data *dn, struct page *page)
 		return err;
 
 	f2fs_bug_on(F2FS_P_SB(page), PageWriteback(page));
-	if (PageUptodate(page))
-		goto no_update;
 
-	zero_user_segment(page, MAX_INLINE_DATA, PAGE_CACHE_SIZE);
-
-	/* Copy the whole inline data block */
-	src_addr = inline_data_addr(dn->inode_page);
-	dst_addr = kmap_atomic(page);
-	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
-	flush_dcache_page(page);
-	kunmap_atomic(dst_addr);
-	SetPageUptodate(page);
-no_update:
+	read_inline_data(page, dn->inode_page);
 	set_page_dirty(page);
 
 	/* clear dirty state */
-- 
2.3.7

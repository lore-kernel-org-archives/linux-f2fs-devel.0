From: Chao Yu <chao2.yu@samsung.com>
Subject: [f2fs-dev][PATCH 1/2] f2fs: handle inline data independently in
 f2fs_bmap
Date: Tue, 22 Apr 2014 13:34:01 +0800
Message-ID: <001901cf5dec$7a6ccf10$6f466d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-language: zh-cn
Sender: linux-fsdevel-owner@vger.kernel.org
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

We'd better handle inline data case independently in f2fs_bmap().
It can reduce our handling time in f2fs_bmap().

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/data.c |    5 +++++
 1 file changed, 5 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 6b89b25..150c12a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1058,6 +1058,11 @@ static int f2fs_set_data_page_dirty(struct page *page)
 
 static sector_t f2fs_bmap(struct address_space *mapping, sector_t block)
 {
+	struct inode *inode = mapping->host;
+
+	if (f2fs_has_inline_data(inode))
+		return 0;
+
 	return generic_block_bmap(mapping, block, get_data_block);
 }
 
-- 
1.7.9.5



From: Chao Yu <yuchao0@huawei.com>
Subject: [PATCH 1/3] f2fs: fix to wait page writeback during revoking atomic write
Date: Mon, 23 Apr 2018 10:36:13 +0800
Message-ID: <20180423023615.33247-1-yuchao0@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org, Chao Yu <yuchao0@huawei.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

After revoking atomic write, related LBA can be reused by others, so we
need to wait page writeback before reusing the LBA, in order to avoid
interference between old atomic written in-flight IO and new IO.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/segment.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index cba59fc58eb6..24299f81f80d 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -231,6 +231,8 @@ static int __revoke_inmem_pages(struct inode *inode,
 
 		lock_page(page);
 
+		f2fs_wait_on_page_writeback(page, DATA, true);
+
 		if (recover) {
 			struct dnode_of_data dn;
 			struct node_info ni;
-- 
2.15.0.55.gc2ece9dc4de6

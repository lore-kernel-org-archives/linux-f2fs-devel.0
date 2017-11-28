From: "LiFan" <fanofcode.li@samsung.com>
Subject: [f2fs-dev] [PATCH] f2fs: remove a redundant conditional expression
Date: Tue, 28 Nov 2017 20:17:41 +0800
Message-ID: <000b01d36842$fed887d0$fc899770$@samsung.com>
References: <CGME20171128121829epcas5p1d7a840229243b79f5b82d56d0b4dc38d@epcas5p1.samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Chao Yu' <yuchao0@huawei.com>, 'Chao Yu' <chao@kernel.org>, 'Jaegeuk Kim' <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Avoid checking is_inode repeatedly, and make the logic 
a little bit clearer.

Signed-off-by: Fan li <fanofcode.li@samsung.com>
---
 fs/f2fs/f2fs.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4acdca4..95cc4ef 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1995,11 +1995,11 @@ static inline block_t datablock_addr(struct inode *inode,
 	raw_node = F2FS_NODE(node_page);
 
 	/* from GC path only */
-	if (!inode) {
-		if (is_inode)
+	if (is_inode) {
+		if (!inode)
 			base = offset_in_addr(&raw_node->i);
-	} else if (f2fs_has_extra_attr(inode) && is_inode) {
-		base = get_extra_isize(inode);
+		else if (f2fs_has_extra_attr(inode))
+			base = get_extra_isize(inode);
 	}
 
 	addr_array = blkaddr_in_node(raw_node);
-- 
2.7.4

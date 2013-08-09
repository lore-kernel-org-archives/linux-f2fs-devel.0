From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [PATCH 1/3] f2fs: fix the use of XATTR_NODE_OFFSET
Date: Fri, 09 Aug 2013 15:20:28 +0900
Message-ID: <1376029230-303-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1V7g4U-00017f-9A
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:10 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1V7g4S-0001yF-Eh for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 06:21:10 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout4.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MR900KYX2Z1YL60@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 09 Aug 2013 15:21:01 +0900 (KST)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch fixes the use of XATTR_NODE_OFFSET.

o The offset should not use several MSB bits which are used by marking node
blocks.

o IS_DNODE should handle XATTR_NODE_OFFSET to avoid potential abnormality
during the fsync call.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/f2fs.h | 12 +++++++-----
 fs/f2fs/node.h |  4 ++++
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index d8e386ce..eb8c45b 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -135,11 +135,13 @@ static inline int update_sits_in_cursum(struct f2fs_summary_block *rs, int i)
 /*
  * For INODE and NODE manager
  */
-#define XATTR_NODE_OFFSET	(-1)	/*
-					 * store xattrs to one node block per
-					 * file keeping -1 as its node offset to
-					 * distinguish from index node blocks.
-					 */
+/*
+ * XATTR_NODE_OFFSET stores xattrs to one node block per file keeping -1
+ * as its node offset to distinguish from index node blocks.
+ * But some bits are used to mark the node block.
+ */
+#define XATTR_NODE_OFFSET	((((unsigned int)-1) << OFFSET_BIT_SHIFT) \
+				>> OFFSET_BIT_SHIFT)
 enum {
 	ALLOC_NODE,			/* allocate a new node page if needed */
 	LOOKUP_NODE,			/* look up a node without readahead */
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 87349c4..3496bb3 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -229,6 +229,10 @@ static inline block_t next_blkaddr_of_node(struct page *node_page)
 static inline bool IS_DNODE(struct page *node_page)
 {
 	unsigned int ofs = ofs_of_node(node_page);
+
+	if (ofs == XATTR_NODE_OFFSET)
+		return false;
+
 	if (ofs == 3 || ofs == 4 + NIDS_PER_BLOCK ||
 			ofs == 5 + 2 * NIDS_PER_BLOCK)
 		return false;
-- 
1.8.3.1.437.g0dbd812


------------------------------------------------------------------------------
Get 100% visibility into Java/.NET code with AppDynamics Lite!
It's a free troubleshooting tool designed for production.
Get down to code-level detail for bottlenecks, with <2% overhead. 
Download for free and get started troubleshooting in minutes. 
http://pubads.g.doubleclick.net/gampad/clk?id=48897031&iu=/4140/ostg.clktrk

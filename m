From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 1/5] f2fs: add infra macro and sturct for inline
	dir
Date: Sat, 09 Aug 2014 10:46:01 +0800
Message-ID: <00bf01cfb37c$28d136b0$7a73a410$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XFwgJ-00059m-08
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:46:55 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XFwgH-0007Y0-KG
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 02:46:54 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0NA000CU0QDXKD00@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Sat, 09 Aug 2014 11:46:45 +0900 (KST)
Content-language: zh-cn
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Changman Lee <cm224.lee@samsung.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch defines macro and inline dentry struct for inline dir infrastructure.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 include/linux/f2fs_fs.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/include/linux/f2fs_fs.h b/include/linux/f2fs_fs.h
index 6ff0b0b..a79726b 100644
--- a/include/linux/f2fs_fs.h
+++ b/include/linux/f2fs_fs.h
@@ -423,6 +423,24 @@ struct f2fs_dentry_block {
 	__u8 filename[NR_DENTRY_IN_BLOCK][F2FS_SLOT_LEN];
 } __packed;
 
+/* for inline dir */
+#define NR_INLINE_DENTRY	(MAX_INLINE_DATA * BITS_PER_BYTE / \
+				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
+				BITS_PER_BYTE + 1))
+#define INLINE_DENTRY_BITMAP_SIZE	((NR_INLINE_DENTRY + \
+					BITS_PER_BYTE - 1) / BITS_PER_BYTE)
+#define INLINE_RESERVED_SIZE	(MAX_INLINE_DATA - \
+				((SIZE_OF_DIR_ENTRY + F2FS_SLOT_LEN) * \
+				NR_INLINE_DENTRY + INLINE_DENTRY_BITMAP_SIZE))
+
+/* inline directory entry structure */
+struct f2fs_inline_dentry {
+	__u8 dentry_bitmap[INLINE_DENTRY_BITMAP_SIZE];
+	__u8 reserved[INLINE_RESERVED_SIZE];
+	struct f2fs_dir_entry dentry[NR_INLINE_DENTRY];
+	__u8 filename[NR_INLINE_DENTRY][F2FS_SLOT_LEN];
+} __packed;
+
 /* file types used in inode_info->flags */
 enum {
 	F2FS_FT_UNKNOWN,
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------

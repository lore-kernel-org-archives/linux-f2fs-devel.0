From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 2/2 v2] f2fs: invalidate xattr node page when
 evict inode
Date: Mon, 04 Aug 2014 09:54:58 +0800
Message-ID: <001d01cfaf87$3664dfa0$a32e9ee0$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1XE7VH-0004EP-PY
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 01:55:59 +0000
Received: from mailout4.samsung.com ([203.254.224.34])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1XE7VF-0001ar-47
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 01:55:59 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout4.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N9R0058XEP0S3A0@mailout4.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 04 Aug 2014 10:55:48 +0900 (KST)
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
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

When inode is evicted, all the page cache belong to this inode should be
released including the xattr node page. But previously we didn't do this, this
patch fixed this issue.

v2:
 o reposition invalidate_mapping_pages() to the right place suggested by
Jaegeuk Kim.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 0e69aa9..2c39999 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -267,6 +267,7 @@ int f2fs_write_inode(struct inode *inode, struct writeback_control *wbc)
 void f2fs_evict_inode(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	nid_t xnid = F2FS_I(inode)->i_xattr_nid;
 
 	trace_f2fs_evict_inode(inode);
 	truncate_inode_pages_final(&inode->i_data);
@@ -296,6 +297,8 @@ void f2fs_evict_inode(struct inode *inode)
 	sb_end_intwrite(inode->i_sb);
 no_delete:
 	invalidate_mapping_pages(NODE_MAPPING(sbi), inode->i_ino, inode->i_ino);
+	if (xnid)
+		invalidate_mapping_pages(NODE_MAPPING(sbi), xnid, xnid);
 	if (is_inode_flag_set(F2FS_I(inode), FI_APPEND_WRITE))
 		add_dirty_inode(sbi, inode->i_ino, APPEND_INO);
 	if (is_inode_flag_set(F2FS_I(inode), FI_UPDATE_WRITE))
-- 
2.0.1.474.g72c7794



------------------------------------------------------------------------------
Infragistics Professional
Build stunning WinForms apps today!
Reboot your WinForms applications with our WinForms controls. 
Build a bridge from your legacy apps to the future.
http://pubads.g.doubleclick.net/gampad/clk?id=153845071&iu=/4140/ostg.clktrk

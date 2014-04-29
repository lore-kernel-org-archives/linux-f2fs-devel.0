From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3 v2] f2fs: fix to truncate inline data in
 inode page when setattr
Date: Tue, 29 Apr 2014 09:03:03 +0800
Message-ID: <000001cf6346$dfbc8bd0$9f35a370$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1WewSg-0007VC-Uf
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Apr 2014 01:03:54 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1WewSe-0004hb-OT
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Apr 2014 01:03:54 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0N4R006N6PM9LE80@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 29 Apr 2014 10:03:45 +0900 (KST)
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
To: ??? <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Previous we do not truncate inline data in inode page when setattr, so following
case could still read the inline data which has already truncated:

1.write inline data
2.ftruncate size to 0
3.ftruncate size to max inline data size
4.read from offset 0

This patch introduces truncate_inline_data() to fix this problem.

change log from v1:
 o fix a bug and do not truncate first page data after truncate inline data.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/f2fs.h   |    1 +
 fs/f2fs/file.c   |    3 +++
 fs/f2fs/inline.c |   18 ++++++++++++++++++
 3 files changed, 22 insertions(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 2b67679..676a2c6 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1410,5 +1410,6 @@ bool f2fs_may_inline(struct inode *);
 int f2fs_read_inline_data(struct inode *, struct page *);
 int f2fs_convert_inline_data(struct inode *, pgoff_t);
 int f2fs_write_inline_data(struct inode *, struct page *, unsigned int);
+void truncate_inline_data(struct inode *, u64);
 int recover_inline_data(struct inode *, struct page *);
 #endif
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d99d173..1b27bd6 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -332,6 +332,9 @@ static void truncate_partial_data_page(struct inode *inode, u64 from)
 	unsigned offset = from & (PAGE_CACHE_SIZE - 1);
 	struct page *page;
 
+	if (f2fs_has_inline_data(inode))
+		return truncate_inline_data(inode, from);
+
 	if (!offset)
 		return;
 
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 3258c7c..d215dbb 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -176,6 +176,24 @@ int f2fs_write_inline_data(struct inode *inode,
 	return 0;
 }
 
+void truncate_inline_data(struct inode *inode, u64 from)
+{
+	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
+	struct page *ipage;
+
+	if (from >= MAX_INLINE_DATA)
+		return;
+
+	ipage = get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage))
+		return;
+
+	zero_user_segment(ipage, INLINE_DATA_OFFSET + from,
+				INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+	set_page_dirty(ipage);
+	f2fs_put_page(ipage, 1);
+}
+
 int recover_inline_data(struct inode *inode, struct page *npage)
 {
 	struct f2fs_sb_info *sbi = F2FS_SB(inode->i_sb);
-- 
1.7.9.5



------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs

From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH 3/3 V2] f2fs: introduce f2fs_cache_node_page() to
 add page into node_inode cache
Date: Fri, 06 Dec 2013 17:10:00 +0800
Message-ID: <000501cef263$1c57e710$5507b530$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VorRT-0007a3-TH
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 09:11:23 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VorRR-00079F-W0
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 09:11:23 +0000
Received: from epcpsbgm1.samsung.com (epcpsbgm1 [203.254.230.26])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MXD00A42O6O92E0@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Fri, 06 Dec 2013 18:11:12 +0900 (KST)
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
To: '???' <jaegeuk.kim@samsung.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This patch introduces f2fs_cache_node_page(), in this function, page which is
readed ahead will be copy to node_inode's mapping cache.
It will avoid rereading these node pages.

change log:
 o check validity of grabbed page suggested by Jaegeuk Kim.

Suggested-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/node.c |   35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 099f06f..3ff98fa 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1600,6 +1600,39 @@ static int ra_sum_pages(struct f2fs_sb_info *sbi, struct list_head *pages,
 	return 0;
 }
 
+/*
+ * f2fs_cache_node_page() copy updated page data to node_inode cache page.
+ */
+void f2fs_cache_node_page(struct f2fs_sb_info *sbi, struct page *page,
+						nid_t nid)
+{
+	struct address_space *mapping = sbi->node_inode->i_mapping;
+	struct page *npage;
+
+	npage = find_get_page(mapping, nid);
+	if (unlikely(npage && PageUptodate(npage))) {
+		f2fs_put_page(npage, 0);
+		return;
+	}
+	f2fs_put_page(npage, 0);
+
+	npage = grab_cache_page(mapping, nid);
+	if (unlikely(!npage))
+		return;
+
+	if (unlikely(PageUptodate(npage))) {
+		f2fs_put_page(npage, 1);
+		return;
+	}
+
+	memcpy(page_address(npage), page_address(page), PAGE_CACHE_SIZE);
+
+	SetPageUptodate(npage);
+	f2fs_put_page(npage, 1);
+
+	return;
+}
+
 int restore_node_summary(struct f2fs_sb_info *sbi,
 			unsigned int segno, struct f2fs_summary_block *sum)
 {
@@ -1633,6 +1666,8 @@ int restore_node_summary(struct f2fs_sb_info *sbi,
 				sum_entry->version = 0;
 				sum_entry->ofs_in_node = 0;
 				sum_entry++;
+				f2fs_cache_node_page(sbi, page,
+					le32_to_cpu(rn->footer.nid));
 			} else {
 				err = -EIO;
 			}
-- 
1.7.9.5


------------------------------------------------------------------------------
Sponsored by Intel(R) XDK 
Develop, test and display web and hybrid apps with a single code base.
Download it for free now!
http://pubads.g.doubleclick.net/gampad/clk?id=111408631&iu=/4140/ostg.clktrk

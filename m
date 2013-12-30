From: Chao Yu <chao2.yu@samsung.com>
Subject: [PATCH] f2fs: avoid to read inline data except first page
Date: Mon, 30 Dec 2013 10:00:43 +0800
Message-ID: <000401cf0503$0d122f10$27368d30$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao2.yu@samsung.com>) id 1VxSAr-0006SP-7j
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Dec 2013 02:01:45 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VxSAn-0005dZ-Tz
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Dec 2013 02:01:45 +0000
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
	by mailout1.samsung.com
	(Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit
	(built Nov
	17 2011)) with ESMTP id <0MYL00CCAKAHCL70@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 30 Dec 2013 11:01:29 +0900 (KST)
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

Here is a case which could read inline page data not from first page.

1. write inline data
2. lseek to offset 4096
3. read 4096 bytes from offset 4096
	(read_inline_data read inline data page to non-first page,
	And previously VFS has add this page to page cache)
4. ftruncate offset 8192
5. read 4096 bytes from offset 4096
	(we meet this updated page with inline data in cache)

So we should leave this page with inited data and uptodate flag
for this case.

Signed-off-by: Chao Yu <chao2.yu@samsung.com>
---
 fs/f2fs/inline.c |    6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 33a07e1..4796037 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -44,6 +44,12 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 	struct page *ipage;
 	void *src_addr, *dst_addr;
 
+	if (page->index) {
+		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
+		SetPageUptodate(page);
+		return 0;
+	}
+
 	ipage = get_node_page(sbi, inode->i_ino);
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
-- 
1.7.9.5


------------------------------------------------------------------------------
Rapidly troubleshoot problems before they affect your business. Most IT 
organizations don't have a clear picture of how application performance 
affects their revenue. With AppDynamics, you get 100% visibility into your 
Java,.NET, & PHP application. Start your 15-day FREE TRIAL of AppDynamics Pro!
http://pubads.g.doubleclick.net/gampad/clk?id=84349831&iu=/4140/ostg.clktrk

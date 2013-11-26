From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH V2 0/6] f2fs: Enable f2fs support inline data
Date: Tue, 26 Nov 2013 16:45:05 +0900
Message-ID: <1385451905.2417.3.camel@kjgkr>
References: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1VlDLV-0001SC-KR
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Nov 2013 07:46:09 +0000
Received: from mailout1.samsung.com ([203.254.224.24])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.76) id 1VlDLT-00055B-Ht
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Nov 2013 07:46:09 +0000
Received: from epcpsbgr3.samsung.com
	(u143.gpu120.samsung.co.kr [203.254.230.143])
	by mailout1.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MWV00D7P1KOYR10@mailout1.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Tue, 26 Nov 2013 16:46:00 +0900 (KST)
In-reply-to: <1384096401-25169-1-git-send-email-huajun.li.lee@gmail.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Huajun Li <huajun.li.lee@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, Huajun Li <huajun.li@intel.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Hi Huajun,

Please adjust the following bug fixes in your patches.

---
 fs/f2fs/data.c   |  2 +-
 fs/f2fs/file.c   | 12 +++++++-----
 fs/f2fs/inline.c | 19 +++++++++++--------
 3 files changed, 19 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2eed6e3..e44f0ba 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -534,8 +534,8 @@ static int get_data_block_ro(struct inode *inode,
sector_t iblock,
 
 static int f2fs_read_data_page(struct file *file, struct page *page)
 {
+	struct inode *inode = page->mapping->host;
 	int ret;
-	struct inode *inode = file->f_mapping->host;

>> The file pointer is NULL if this page contains file's symlink data,
which induces NULL pointer error.
 
 	/* If the file has inline data, try to read it directlly */
 	if (f2fs_has_inline_data(inode))
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ffafcb9..52bb211 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -257,8 +257,7 @@ static int truncate_blocks(struct inode *inode, u64
from)
 	unsigned int blocksize = inode->i_sb->s_blocksize;
 	struct dnode_of_data dn;
 	pgoff_t free_from;
-	int count = 0;
-	int err;
+	int count = 0, err = 0;
 
 	trace_f2fs_truncate_blocks_enter(inode, from);
 
@@ -266,6 +265,10 @@ static int truncate_blocks(struct inode *inode, u64
from)
 			((from + blocksize - 1) >> (sbi->log_blocksize));
 
 	f2fs_lock_op(sbi);
+
+	if (f2fs_has_inline_data(inode))
+		goto done;
+

>> We don't need to do the below actions. Let's skip that.

 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, free_from, LOOKUP_NODE);
 	if (err) {
@@ -291,9 +294,8 @@ static int truncate_blocks(struct inode *inode, u64
from)
 
 	f2fs_put_dnode(&dn);
 free_next:
-
-	if (!f2fs_has_inline_data(inode))
-		err = truncate_inode_blocks(inode, free_from);
+	err = truncate_inode_blocks(inode, free_from);
+done:
 	f2fs_unlock_op(sbi);
 
 	/* lastly zero out the first data page */
diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e9b33d7..6c301cc 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -48,13 +48,14 @@ int f2fs_read_inline_data(struct inode *inode,
struct page *page)
 	if (IS_ERR(ipage))
 		return PTR_ERR(ipage);
 
-	src_addr = inline_data_addr(ipage);
-	dst_addr = page_address(page);
-
 	zero_user_segment(page, INLINE_DATA_OFFSET,
 				INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+
 	/* Copy the whole inline data block */
+	src_addr = inline_data_addr(ipage);
+	dst_addr = kmap(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
+	kunmap(page);

>> We should do kmap/kunmap for normal data pages.

 	f2fs_put_page(ipage, 1);
 
 	SetPageUptodate(page);
@@ -89,12 +90,13 @@ static int __f2fs_convert_inline_data(struct inode
*inode, struct page *page)
 		return err;
 	}
 
-	src_addr = inline_data_addr(ipage);
-	dst_addr = page_address(page);
 	zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 
 	/* Copy the whole inline data block */
+	src_addr = inline_data_addr(ipage);
+	dst_addr = kmap(page);
 	memcpy(dst_addr, src_addr, MAX_INLINE_DATA);
+	kunmap(page);

>> ditto.
 
 	/* write data page to try to make data consistent */
 	old_blk_addr = dn.data_blkaddr;
@@ -152,12 +154,13 @@ int f2fs_write_inline_data(struct inode *inode,
 		return err;
 	ipage = dn.inode_page;
 
-	src_addr = page_address(page);
-	dst_addr = inline_data_addr(ipage);
-
 	zero_user_segment(ipage, INLINE_DATA_OFFSET,
 				 INLINE_DATA_OFFSET + MAX_INLINE_DATA);
+
+	src_addr = kmap(page);
+	dst_addr = inline_data_addr(ipage);
 	memcpy(dst_addr, src_addr, size);
+	kunmap(page);

>> ditto.
 
 	/* Release the first data block if it is allocated */
 	if (!f2fs_has_inline_data(inode)) {
-- 
1.8.4.474.g128a96c



-- 
Jaegeuk Kim
Samsung


------------------------------------------------------------------------------
Shape the Mobile Experience: Free Subscription
Software experts and developers: Be at the forefront of tech innovation.
Intel(R) Software Adrenaline delivers strategic insight and game-changing 
conversations that shape the rapidly evolving mobile landscape. Sign up now. 
http://pubads.g.doubleclick.net/gampad/clk?id=63431311&iu=/4140/ostg.clktrk

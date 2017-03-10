From: Yunlei He <heyunlei@huawei.com>
Subject: [PATCH 2/2] f2fs: avoid move encrypted block in BG_GC if
	it has been in memory
Date: Fri, 10 Mar 2017 17:50:47 +0800
Message-ID: <20170310095047.14540-2-heyunlei@huawei.com>
References: <20170310095047.14540-1-heyunlei@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <heyunlei@huawei.com>) id 1cmH8m-0000aP-Tj
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:47:16 +0000
Received: from [45.249.212.188] (helo=dggrg02-dlp.huawei.com)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cmH8h-0000fG-DO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 10 Mar 2017 09:47:16 +0000
In-Reply-To: <20170310095047.14540-1-heyunlei@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, linux-f2fs-devel@lists.sourceforge.net

If an encrypted block has been read to memory, we just dirty it
and return directly.

Signed-off-by: Yunlei He <heyunlei@huawei.com>
---
 fs/f2fs/gc.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 418fd98..ca94518 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -564,7 +564,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 }
 
 static void move_encrypted_block(struct inode *inode, block_t bidx,
-							unsigned int segno, int off)
+					int gc_type, unsigned int segno, int off)
 {
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
@@ -607,6 +607,12 @@ static void move_encrypted_block(struct inode *inode, block_t bidx,
 	 */
 	f2fs_wait_on_page_writeback(page, DATA, true);
 
+	if (gc_type == BG_GC && PageUptodate(page) &&
+				fscrypt_has_encryption_key(inode)) {
+		set_page_dirty(page);
+		goto put_out;
+	}
+
 	get_node_info(fio.sbi, dn.nid, &ni);
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
@@ -827,7 +833,8 @@ static void gc_data_segment(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 			start_bidx = start_bidx_of_node(nofs, inode)
 								+ ofs_in_node;
 			if (f2fs_encrypted_inode(inode) && S_ISREG(inode->i_mode))
-				move_encrypted_block(inode, start_bidx, segno, off);
+				move_encrypted_block(inode, start_bidx,
+								gc_type, segno, off);
 			else
 				move_data_page(inode, start_bidx, gc_type, segno, off);
 
-- 
2.10.1


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford

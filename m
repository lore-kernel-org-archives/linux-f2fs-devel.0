From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 4/4] f2fs: use __set{__claer}_bit_le
Date: Tue,  7 Mar 2017 14:13:03 -0800
Message-ID: <20170307221303.6757-4-jaegeuk@kernel.org>
References: <20170307221303.6757-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1clNM5-0004MI-V2
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:17 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1clNM5-0007GB-5z
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 07 Mar 2017 22:13:17 +0000
In-Reply-To: <20170307221303.6757-1-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch uses __set{__clear}_bit_le for highter speed.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/dir.c  |  2 +-
 fs/f2fs/node.c | 16 ++++++++--------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 4650c9b85de7..8d5c62b07b28 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -750,7 +750,7 @@ void f2fs_delete_entry(struct f2fs_dir_entry *dentry, struct page *page,
 	dentry_blk = page_address(page);
 	bit_pos = dentry - dentry_blk->dentry;
 	for (i = 0; i < slots; i++)
-		clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
+		__clear_bit_le(bit_pos + i, &dentry_blk->dentry_bitmap);
 
 	/* Let's check and deallocate this dentry page */
 	bit_pos = find_next_bit_le(&dentry_blk->dentry_bitmap,
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 342742754a09..3377a512e299 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1825,9 +1825,9 @@ void update_free_nid_bitmap(struct f2fs_sb_info *sbi, nid_t nid,
 		return;
 
 	if (set)
-		set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+		__set_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
 	else
-		clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
+		__clear_bit_le(nid_ofs, nm_i->free_nid_bitmap[nat_ofs]);
 
 	spin_lock(&nm_i->free_nid_lock);
 	if (set)
@@ -1849,7 +1849,7 @@ static void scan_nat_page(struct f2fs_sb_info *sbi,
 	if (test_bit_le(nat_ofs, nm_i->nat_block_bitmap))
 		return;
 
-	set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
+	__set_bit_le(nat_ofs, nm_i->nat_block_bitmap);
 
 	i = start_nid % NAT_ENTRY_PER_BLOCK;
 
@@ -2339,16 +2339,16 @@ void __update_nat_bits(struct f2fs_sb_info *sbi, nid_t start_nid,
 			valid++;
 	}
 	if (valid == 0) {
-		set_bit_le(nat_index, nm_i->empty_nat_bits);
-		clear_bit_le(nat_index, nm_i->full_nat_bits);
+		__set_bit_le(nat_index, nm_i->empty_nat_bits);
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 		return;
 	}
 
-	clear_bit_le(nat_index, nm_i->empty_nat_bits);
+	__clear_bit_le(nat_index, nm_i->empty_nat_bits);
 	if (valid == NAT_ENTRY_PER_BLOCK)
-		set_bit_le(nat_index, nm_i->full_nat_bits);
+		__set_bit_le(nat_index, nm_i->full_nat_bits);
 	else
-		clear_bit_le(nat_index, nm_i->full_nat_bits);
+		__clear_bit_le(nat_index, nm_i->full_nat_bits);
 }
 
 static void __flush_nat_entry_set(struct f2fs_sb_info *sbi,
-- 
2.11.0


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford

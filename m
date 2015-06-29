From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Make the function check_dnode have a return
	type of bool
Date: Mon, 29 Jun 2015 16:07:01 -0400
Message-ID: <1435608421-5951-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1Z9fKh-00040a-7A
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 20:07:11 +0000
Received: from mail-ig0-f169.google.com ([209.85.213.169])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Z9fKg-0007Sq-GV
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 29 Jun 2015 20:07:11 +0000
Received: by igrv9 with SMTP id v9so48264095igr.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 29 Jun 2015 13:07:05 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

This makes the function check_dnode have a return type of bool
due to this particular function only ever returning either one
or zero as its return value.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/gc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e1e7361..ebd4c6c 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -487,7 +487,7 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
 	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
 }
 
-static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+static bool check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		struct node_info *dni, block_t blkaddr, unsigned int *nofs)
 {
 	struct page *node_page;
@@ -500,13 +500,13 @@ static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 
 	node_page = get_node_page(sbi, nid);
 	if (IS_ERR(node_page))
-		return 0;
+		return false;
 
 	get_node_info(sbi, nid, dni);
 
 	if (sum->version != dni->version) {
 		f2fs_put_page(node_page, 1);
-		return 0;
+		return false;
 	}
 
 	*nofs = ofs_of_node(node_page);
@@ -514,8 +514,8 @@ static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 	f2fs_put_page(node_page, 1);
 
 	if (source_blkaddr != blkaddr)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 static void move_encrypted_block(struct inode *inode, block_t bidx)
-- 
2.1.4


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

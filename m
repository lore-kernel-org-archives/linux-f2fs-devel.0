From: Nicholas Krause <xerofoify@gmail.com>
Subject: [PATCH] f2fs:Make the function check_dnode have a return
	type of bool and change it's name to is_alive
Date: Tue, 30 Jun 2015 21:37:21 -0400
Message-ID: <1435714641-31351-1-git-send-email-xerofoify@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <xerofoify@gmail.com>) id 1ZA6xu-0005dR-Nz
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:37:30 +0000
Received: from mail-ig0-f174.google.com ([209.85.213.174])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZA6xu-0003iM-1c
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 01 Jul 2015 01:37:30 +0000
Received: by igrv9 with SMTP id v9so64104919igr.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Tue, 30 Jun 2015 18:37:25 -0700 (PDT)
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
or zero as its return value and changes the name of the function
to is_alive in order to better explain this function's intended
work of checking if a dnode is still in use by the filesystem.

Signed-off-by: Nicholas Krause <xerofoify@gmail.com>
---
 fs/f2fs/gc.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index e1e7361..1270259 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -487,7 +487,7 @@ block_t start_bidx_of_node(unsigned int node_ofs, struct f2fs_inode_info *fi)
 	return bidx * ADDRS_PER_BLOCK + ADDRS_PER_INODE(fi);
 }
 
-static int check_dnode(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
+static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
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
@@ -658,7 +658,7 @@ next_step:
 		}
 
 		/* Get an inode by ino with checking validity */
-		if (check_dnode(sbi, entry, &dni, start_addr + off, &nofs) == 0)
+		if (is_alive(sbi, entry, &dni, start_addr + off, &nofs) == 0)
 			continue;
 
 		if (phase == 1) {
-- 
2.1.4


------------------------------------------------------------------------------
Don't Limit Your Business. Reach for the Cloud.
GigeNET's Cloud Solutions provide you with the tools and support that
you need to offload your IT needs and focus on growing your business.
Configured For All Businesses. Start Your Cloud Today.
https://www.gigenetcloud.com/

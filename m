From: =?UTF-8?q?Piotr=20Soko=C5=82owski?= <piosoko1@student.pg.edu.pl>
Subject: [PATCH] f2fs-tools: fix printing block adresses
Date: Wed, 26 Jul 2017 19:16:37 +0200
Message-ID: <1501089397-10422-1-git-send-email-piosoko1@student.pg.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps (TLSv1:DHE-RSA-AES256-SHA:256)
 (Exim 4.89) (envelope-from <piosoko1@student.pg.edu.pl>)
 id 1daQCI-0005PO-40
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 17:34:10 +0000
Received: from smtp.student.pg.edu.pl ([153.19.40.202])
 by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
 (Exim 4.76) id 1daQCG-0008Ss-7A
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 26 Jul 2017 17:34:10 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: jackupie@student.pg.edu.pl, magstach@student.pg.edu.pl

This patch allows properly printing all addresses in an inode.
It is useful in commands like dump.f2fs.

---
 fsck/mount.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index a0b0bea..4d7ac6a 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -92,12 +92,14 @@ void print_inode_info(struct f2fs_inode *inode, int name)
 	DISP_u32(inode, i_addr[2]);	/* Pointers to data blocks */
 	DISP_u32(inode, i_addr[3]);	/* Pointers to data blocks */
 
-	for (i = 4; i < ADDRS_PER_INODE(inode); i++) {
+	for (i = 0; i < ADDRS_PER_INODE(inode); i++) {
 		if (inode->i_addr[i] != 0x0) {
-			printf("i_addr[0x%x] points data block\r\t\t[0x%4x]\n",
-					i, le32_to_cpu(inode->i_addr[i]));
-			break;
+			if (i>3)
+				printf("i_addr[0x%x] points data block\t\t[0x%4x]\n",
+						i, le32_to_cpu(inode->i_addr[i]));
 		}
+		else
+			break;
 	}
 
 	DISP_u32(inode, i_nid[0]);	/* direct */
-- 
2.1.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: [f2fs-dev] [PATCH 06/15] f2fs: skip get_node_page if locked node
	page is passed
Date: Mon, 20 May 2013 12:32:20 +0900
Message-ID: <1369020743-18520-6-git-send-email-jaegeuk.kim@samsung.com>
References: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk.kim@samsung.com>) id 1UeGrT-0007bb-Hd
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:34:11 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1UeGrL-000513-OI for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 03:34:11 +0000
Received: from epcpsbgr4.samsung.com
	(u144.gpu120.samsung.co.kr [203.254.230.144])
	by mailout3.samsung.com (Oracle Communications Messaging Server
	7u4-24.01 (7.0.4.24.0) 64bit (built Nov 17 2011))
	with ESMTP id <0MN2000TKV7K42I0@mailout3.samsung.com> for
	linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 May 2013 12:33:34 +0900 (KST)
In-reply-to: <1369020743-18520-1-git-send-email-jaegeuk.kim@samsung.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

If get_dnode_of_data gets a locked node page, let's skip redundant
get_node_page calls.
This is for the futher enhancement.

Signed-off-by: Jaegeuk Kim <jaegeuk.kim@samsung.com>
---
 fs/f2fs/node.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9641534..f63f0a4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -408,10 +408,13 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	level = get_node_path(index, offset, noffset);
 
 	nids[0] = dn->inode->i_ino;
-	npage[0] = get_node_page(sbi, nids[0]);
-	if (IS_ERR(npage[0]))
-		return PTR_ERR(npage[0]);
+	npage[0] = dn->inode_page;
 
+	if (!npage[0]) {
+		npage[0] = get_node_page(sbi, nids[0]);
+		if (IS_ERR(npage[0]))
+			return PTR_ERR(npage[0]);
+	}
 	parent = npage[0];
 	if (level != 0)
 		nids[1] = get_nid(parent, offset[0], true);
-- 
1.8.1.3.566.gaa39828


------------------------------------------------------------------------------
AlienVault Unified Security Management (USM) platform delivers complete
security visibility with the essential security capabilities. Easily and
efficiently configure, manage, and operate all of your security controls
from a single console and one unified framework. Download a free trial.
http://p.sf.net/sfu/alienvault_d2d

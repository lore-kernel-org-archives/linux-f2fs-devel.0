From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 8/8] f2fs: check inline flag ahead for
	get_dnode_of_data
Date: Fri, 11 Mar 2016 11:29:23 +0800
Message-ID: <1457666963-14641-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDtN-0008VY-8m
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:33 +0000
Received: from lucky1.263xmail.com ([211.157.147.132])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aeDtM-0007aR-Ef for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:33 +0000
In-Reply-To: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Shawn Lin <shawn.lin@rock-chips.com>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

Check inline data flag ahead, so we can save some
cpu cycle.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/node.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 771166d..69467bd 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -534,6 +534,11 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 	int err = 0;
 
 	level = get_node_path(dn->inode, index, offset, noffset);
+	/* if inline_data is set, should not report any block indices */
+	if (f2fs_has_inline_data(dn->inode) && index) {
+		err = -ENOENT;
+		goto release_out;
+	}
 
 	nids[0] = dn->inode->i_ino;
 	npage[0] = dn->inode_page;
@@ -544,13 +549,6 @@ int get_dnode_of_data(struct dnode_of_data *dn, pgoff_t index, int mode)
 			return PTR_ERR(npage[0]);
 	}
 
-	/* if inline_data is set, should not report any block indices */
-	if (f2fs_has_inline_data(dn->inode) && index) {
-		err = -ENOENT;
-		f2fs_put_page(npage[0], 1);
-		goto release_out;
-	}
-
 	parent = npage[0];
 	if (level != 0)
 		nids[1] = get_nid(parent, offset[0], true);
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

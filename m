From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 1/8] f2fs: check inline flag ahead for
	f2fs_write_inline_data
Date: Fri, 11 Mar 2016 11:28:18 +0800
Message-ID: <1457666898-14352-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDsJ-00049s-EO
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:27 +0000
Received: from lucky1.263xmail.com ([211.157.147.132])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aeDsI-0004ro-KP for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:27 +0000
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

No matter inline data flag is set or not, current code is
going to new a dnode. But actually we can avoid it by puting
the check of inline data flag in advance to save this cpu cycle.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>

---

 fs/f2fs/inline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 358214e..0926eab 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -195,16 +195,14 @@ int f2fs_write_inline_data(struct inode *inode, struct page *page)
 	struct dnode_of_data dn;
 	int err;
 
+	if (!f2fs_has_inline_data(inode))
+		return -EAGAIN;
+
 	set_new_dnode(&dn, inode, NULL, NULL, 0);
 	err = get_dnode_of_data(&dn, 0, LOOKUP_NODE);
 	if (err)
 		return err;
 
-	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_dnode(&dn);
-		return -EAGAIN;
-	}
-
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
 
 	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true);
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

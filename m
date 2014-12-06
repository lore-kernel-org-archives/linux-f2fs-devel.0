From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/5] f2fs: count inline_xx in do_read_inode
Date: Sat,  6 Dec 2014 11:55:36 -0800
Message-ID: <1417895739-15251-2-git-send-email-jaegeuk@kernel.org>
References: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1XxLSJ-00005o-VB
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:52 +0000
Received: from mail.kernel.org ([198.145.19.201])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1XxLSJ-000487-7r for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 06 Dec 2014 19:55:51 +0000
In-Reply-To: <1417895739-15251-1-git-send-email-jaegeuk@kernel.org>
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

In do_read_inode, if we failed __recover_inline_status, the inode has inline
flag without increasing its count.
Later, f2fs_evict_inode will decrease the count, which causes -1.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 9fe110e..196cc78 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -148,6 +148,10 @@ static int do_read_inode(struct inode *inode)
 	__get_inode_rdev(inode, ri);
 
 	f2fs_put_page(node_page, 1);
+
+	stat_inc_inline_inode(inode);
+	stat_inc_inline_dir(inode);
+
 	return err;
 }
 
@@ -199,8 +203,6 @@ make_now:
 		goto bad_inode;
 	}
 	unlock_new_inode(inode);
-	stat_inc_inline_inode(inode);
-	stat_inc_inline_dir(inode);
 	trace_f2fs_iget(inode);
 	return inode;
 
-- 
2.1.1


------------------------------------------------------------------------------
Download BIRT iHub F-Type - The Free Enterprise-Grade BIRT Server
from Actuate! Instantly Supercharge Your Business Reports and Dashboards
with Interactivity, Sharing, Native Excel Exports, App Integration & more
Get technology previously reserved for billion-dollar corporations, FREE
http://pubads.g.doubleclick.net/gampad/clk?id=164703151&iu=/4140/ostg.clktrk

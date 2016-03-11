From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 3/8] f2fs: check inline flag ahead for
	f2fs_read_inline_data
Date: Fri, 11 Mar 2016 11:28:34 +0800
Message-ID: <1457666914-14434-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDsh-0003w6-0b
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:51 +0000
Received: from lucky1.263xmail.com ([211.157.147.131])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aeDsg-0007YD-0Y
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:50 +0000
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

No matter inline data flag is set or not, get_node_page is
going work now. But actually we can avoid it by puting the
check of inline data flag in advance to save this cpu cycle.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/inline.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 0926eab..69a4806 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -81,17 +81,15 @@ int f2fs_read_inline_data(struct inode *inode, struct page *page)
 {
 	struct page *ipage;
 
+	if (!f2fs_has_inline_data(inode))
+		return -EAGAIN;
+
 	ipage = get_node_page(F2FS_I_SB(inode), inode->i_ino);
 	if (IS_ERR(ipage)) {
 		unlock_page(page);
 		return PTR_ERR(ipage);
 	}
 
-	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_page(ipage, 1);
-		return -EAGAIN;
-	}
-
 	if (page->index)
 		zero_user_segment(page, 0, PAGE_CACHE_SIZE);
 	else
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

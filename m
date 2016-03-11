From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 4/8] f2fs: remove redundant checking of inline
	data flag
Date: Fri, 11 Mar 2016 11:28:48 +0800
Message-ID: <1457666928-14475-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDsm-0008Th-Fh
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:56 +0000
Received: from lucky1.263xmail.com ([211.157.147.133])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aeDsl-0007YK-MK for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:36:56 +0000
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

Remove the f2fs_has_inline_data for f2fs_read_data_page,
and let f2fs_read_inline_data take over gatekeeper of
checking inline data flag.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/data.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 38c834e..d60d5f0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1047,9 +1047,9 @@ static int f2fs_read_data_page(struct file *file, struct page *page)
 
 	trace_f2fs_readpage(page, DATA);
 
-	/* If the file has inline data, try to read it directly */
-	if (f2fs_has_inline_data(inode))
-		ret = f2fs_read_inline_data(inode, page);
+	/* Firstly, let's try to read inline data directly */
+	ret = f2fs_read_inline_data(inode, page);
+
 	if (ret == -EAGAIN)
 		ret = f2fs_mpage_readpages(page->mapping, NULL, page, 1);
 	return ret;
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 6/8] f2fs: remove checing inline data flag for
	f2fs_fiemap
Date: Fri, 11 Mar 2016 11:29:06 +0800
Message-ID: <1457666946-14559-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDt7-0008Ug-N2
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:17 +0000
Received: from lucky1.263xmail.com ([211.157.147.131])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aeDt5-0004tO-R9
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:17 +0000
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

Remove the f2fs_has_inline_data for f2fs_fiemap, and let
f2fs_inline_data_fiemap take over gatekeeper of checking
inline data flag.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/data.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d60d5f0..c88d79c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -817,11 +817,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (ret)
 		return ret;
 
-	if (f2fs_has_inline_data(inode)) {
-		ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
-		if (ret != -EAGAIN)
-			return ret;
-	}
+	ret = f2fs_inline_data_fiemap(inode, fieinfo, start, len);
+	if (ret != -EAGAIN)
+		return ret;
 
 	inode_lock(inode);
 
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

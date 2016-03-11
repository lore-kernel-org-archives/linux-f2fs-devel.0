From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 2/2] f2fs: remove checing inline data flag for
	f2fs_write_data_page
Date: Fri, 11 Mar 2016 10:48:58 +0800
Message-ID: <1457664538-2900-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDGI-0002il-0d
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 02:57:10 +0000
Received: from lucky1.263xmail.com ([211.157.147.131])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1aeDGH-0006c4-4E
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 02:57:10 +0000
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

Remove the f2fs_has_inline_data for f2fs_write_data_page,
and let f2fs_write_inline_data take over gatekeeper of
checking inline data flag.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/data.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e5c762b..38c834e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1192,8 +1192,7 @@ write:
 
 	err = -EAGAIN;
 	f2fs_lock_op(sbi);
-	if (f2fs_has_inline_data(inode))
-		err = f2fs_write_inline_data(inode, page);
+	err = f2fs_write_inline_data(inode, page);
 	if (err == -EAGAIN)
 		err = do_write_data_page(&fio);
 	f2fs_unlock_op(sbi);
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

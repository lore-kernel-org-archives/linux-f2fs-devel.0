From: Shawn Lin <shawn.lin@rock-chips.com>
Subject: [PATCH 7/8] f2fs: remove unnecessary inline checking for
	f2fs_convert_inline_inode
Date: Fri, 11 Mar 2016 11:29:15 +0800
Message-ID: <1457666955-14600-1-git-send-email-shawn.lin@rock-chips.com>
References: <1457666880-14311-1-git-send-email-shawn.lin@rock-chips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <shawn.lin@rock-chips.com>) id 1aeDtC-0004CV-U6
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:22 +0000
Received: from lucky1.263xmail.com ([211.157.147.133])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aeDtC-0006Vz-3O for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 11 Mar 2016 03:37:22 +0000
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

If failing to check inline data flag for f2fs_convert_inline_inode,
it will return 0. So we don't need to check it twice before we are
going to do f2fs_convert_inline_page.

Signed-off-by: Shawn Lin <shawn.lin@rock-chips.com>
---

 fs/f2fs/inline.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index 394feee..76e096a 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -173,8 +173,7 @@ int f2fs_convert_inline_inode(struct inode *inode)
 
 	set_new_dnode(&dn, inode, ipage, ipage, 0);
 
-	if (f2fs_has_inline_data(inode))
-		err = f2fs_convert_inline_page(&dn, page);
+	err = f2fs_convert_inline_page(&dn, page);
 
 	f2fs_put_dnode(&dn);
 out:
-- 
2.3.7



------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785111&iu=/4140

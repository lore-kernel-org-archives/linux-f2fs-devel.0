From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH] f2fs: remove duplicated code in the f2fs_lookup()
Date: Thu, 16 Apr 2015 17:42:43 +0900
Message-ID: <1429173763-12707-1-git-send-email-ap420073@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ap420073@gmail.com>) id 1YifNz-0006Po-PH
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 08:42:59 +0000
Received: from mail-pd0-f176.google.com ([209.85.192.176])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1YifNy-0001xm-VR
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 16 Apr 2015 08:42:59 +0000
Received: by pdbqa5 with SMTP id qa5so84376688pdb.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 16 Apr 2015 01:42:53 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, cm224.lee@samsung.com, linux-f2fs-devel@lists.sourceforge.net

in the f2fs_lookup(), checks that inode isn't null
but d_splice_alias() has same routine at first line.
so i remove this routine.

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 fs/f2fs/namei.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/fs/f2fs/namei.c b/fs/f2fs/namei.c
index e79639a9..f17b4b5 100644
--- a/fs/f2fs/namei.c
+++ b/fs/f2fs/namei.c
@@ -204,8 +204,6 @@ static struct dentry *f2fs_lookup(struct inode *dir, struct dentry *dentry,
 		f2fs_put_page(page, 0);
 
 		inode = f2fs_iget(dir->i_sb, ino);
-		if (IS_ERR(inode))
-			return ERR_CAST(inode);
 	}
 
 	return d_splice_alias(inode, dentry);
-- 
1.9.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF

From: Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH] f2fs: Add offset check routine before
	punch_hole() in f2fs_fallocate()
Date: Mon, 20 Apr 2015 17:46:14 +0900
Message-ID: <1429519574-5110-1-git-send-email-ap420073@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <ap420073@gmail.com>) id 1Yk7Mt-00089B-SA
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Apr 2015 08:47:51 +0000
Received: from mail-pa0-f52.google.com ([209.85.220.52])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Yk7Mt-000874-0I
	for linux-f2fs-devel@lists.sourceforge.net;
	Mon, 20 Apr 2015 08:47:51 +0000
Received: by pacyx8 with SMTP id yx8so200235839pac.1
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Mon, 20 Apr 2015 01:47:45 -0700 (PDT)
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

In the punch_hole(), if offset bigger than inode size, it returns SUCCESS.
Then f2fs_fallocate() will update time and dirty mark.
In that case, inode has not been modified actually.
So I have added offset check routine that prevent to call the punch_hole().

Signed-off-by: Taehee Yoo <ap420073@gmail.com>
---
 fs/f2fs/file.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a6f3f61..6470831 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -830,15 +830,19 @@ static long f2fs_fallocate(struct file *file, int mode,
 				loff_t offset, loff_t len)
 {
 	struct inode *inode = file_inode(file);
-	long ret;
+	long ret = 0;
 
 	if (mode & ~(FALLOC_FL_KEEP_SIZE | FALLOC_FL_PUNCH_HOLE))
 		return -EOPNOTSUPP;
 
 	mutex_lock(&inode->i_mutex);
 
-	if (mode & FALLOC_FL_PUNCH_HOLE)
+	if (mode & FALLOC_FL_PUNCH_HOLE) {
+		if (offset >= inode->i_size)
+			goto out;
+
 		ret = punch_hole(inode, offset, len);
+	}
 	else
 		ret = expand_inode_data(inode, offset, len, mode);
 
@@ -847,6 +851,7 @@ static long f2fs_fallocate(struct file *file, int mode,
 		mark_inode_dirty(inode);
 	}
 
+out:
 	mutex_unlock(&inode->i_mutex);
 
 	trace_f2fs_fallocate(inode, mode, offset, len, ret);
-- 
1.9.1


------------------------------------------------------------------------------
BPM Camp - Free Virtual Workshop May 6th at 10am PDT/1PM EDT
Develop your own process in accordance with the BPMN 2 standard
Learn Process modeling best practices with Bonita BPM through live exercises
http://www.bonitasoft.com/be-part-of-it/events/bpm-camp-virtual- event?utm_
source=Sourceforge_BPM_Camp_5_6_15&utm_medium=email&utm_campaign=VA_SF

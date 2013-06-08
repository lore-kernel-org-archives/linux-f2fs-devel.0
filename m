From: Namjae Jeon <linkinjeon@gmail.com>
Subject: [f2fs-dev] [PATCH 3/4] f2fs: use the F2FS sepcifice flags in
	f2fs_ioctl()
Date: Sat,  8 Jun 2013 21:25:28 +0900
Message-ID: <1370694328-2806-1-git-send-email-linkinjeon@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <linkinjeon@gmail.com>) id 1UlIDG-0003Vq-HR
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:42 +0000
Received: from mail-pb0-f49.google.com ([209.85.160.49])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1UlIDF-0007aH-Su
	for linux-f2fs-devel@lists.sourceforge.net;
	Sat, 08 Jun 2013 12:25:42 +0000
Received: by mail-pb0-f49.google.com with SMTP id jt11so5641185pbb.22
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Sat, 08 Jun 2013 05:25:36 -0700 (PDT)
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk.kim@samsung.com
Cc: Namjae Jeon <linkinjeon@gmail.com>, Namjae Jeon <namjae.jeon@samsung.com>, Pankaj Kumar <pankaj.km@samsung.com>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Namjae Jeon <namjae.jeon@samsung.com>

In f2fs_ioctl() function, it is using generic flags.
Since F2FS specific flags are defined. So lets use
those flags.

Signed-off-by: Namjae Jeon <namjae.jeon@samsung.com>
Signed-off-by: Pankaj Kumar <pankaj.km@samsung.com>
---
 fs/f2fs/file.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 8dfc1da..6071ff5 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -538,10 +538,10 @@ long f2fs_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
 	int ret;
 
 	switch (cmd) {
-	case FS_IOC_GETFLAGS:
+	case F2FS_IOC_GETFLAGS:
 		flags = fi->i_flags & FS_FL_USER_VISIBLE;
 		return put_user(flags, (int __user *) arg);
-	case FS_IOC_SETFLAGS:
+	case F2FS_IOC_SETFLAGS:
 	{
 		unsigned int oldflags;
 
-- 
1.7.9.5


------------------------------------------------------------------------------
How ServiceNow helps IT people transform IT departments:
1. A cloud service to automate IT design, transition and operations
2. Dashboards that offer high-level views of enterprise services
3. A single system of record for all IT processes
http://p.sf.net/sfu/servicenow-d2d-j

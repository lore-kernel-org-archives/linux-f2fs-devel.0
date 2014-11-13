From: Pieter Smith <pieter@boesman.nl>
Subject: [PATCH 21/56] fs/f2fs: support compiling out splice
Date: Thu, 13 Nov 2014 22:22:58 +0100
Message-ID: <1415913813-362-22-git-send-email-pieter@boesman.nl>
References: <pieter@boesman.nl>
	<1415913813-362-1-git-send-email-pieter@boesman.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <smipi01@gmail.com>) id 1Xp1xf-0007VR-MG
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 21:29:51 +0000
Received: from mail-wi0-f179.google.com ([209.85.212.179])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1Xp1xe-00066k-8C
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 13 Nov 2014 21:29:51 +0000
Received: by mail-wi0-f179.google.com with SMTP id ex7so905905wid.6
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 13 Nov 2014 13:29:44 -0800 (PST)
In-Reply-To: <1415913813-362-1-git-send-email-pieter@boesman.nl>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: pieter@boesman.nl
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Josh Triplett <josh@joshtriplett.org>, open list <linux-kernel@vger.kernel.org>, "open list:F2FS FILE SYSTEM" <linux-f2fs-devel@lists.sourceforge.net>

Compile out splice support from f2fs when the splice-family of syscalls is not
supported by the system (i.e. CONFIG_SYSCALL_SPLICE is undefined).

Signed-off-by: Pieter Smith <pieter@boesman.nl>
---
 fs/f2fs/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 208f1a9..57c6d40 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -853,6 +853,6 @@ const struct file_operations f2fs_file_operations = {
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= f2fs_compat_ioctl,
 #endif
-	.splice_read	= generic_file_splice_read,
-	.splice_write	= iter_file_splice_write,
+	SPLICE_READ_INIT(generic_file_splice_read)
+	SPLICE_WRITE_INIT(iter_file_splice_write)
 };
-- 
1.9.1


------------------------------------------------------------------------------
Comprehensive Server Monitoring with Site24x7.
Monitor 10 servers for $9/Month.
Get alerted through email, SMS, voice calls or mobile push notifications.
Take corrective actions from your mobile device.
http://pubads.g.doubleclick.net/gampad/clk?id=154624111&iu=/4140/ostg.clktrk

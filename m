From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/2] man: modify mkfs.f2fs man page
Date: Tue, 22 Dec 2015 17:00:29 -0800
Message-ID: <1450832429-29211-2-git-send-email-jaegeuk@kernel.org>
References: <1450832429-29211-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1aBXnK-0008In-Rf
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 01:00:46 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1aBXnD-0007z9-FJ for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 23 Dec 2015 01:00:40 +0000
In-Reply-To: <1450832429-29211-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch adds missing [sectors] option in mkfs.f2fs, and removes
meaningless version.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 man/mkfs.f2fs.8 | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/man/mkfs.f2fs.8 b/man/mkfs.f2fs.8
index 068c4c1..cdbde96 100644
--- a/man/mkfs.f2fs.8
+++ b/man/mkfs.f2fs.8
@@ -2,7 +2,7 @@
 .\"             http://www.samsung.com/
 .\"  Written by Jaegeuk Kim <jaegeuk.kim@samsung.com>
 .\"
-.TH MKFS.F2FS 8 "January 2013" "f2fs-tools version 1.2.0"
+.TH MKFS.F2FS 8
 .SH NAME
 mkfs.f2fs \- create an F2FS file system
 .SH SYNOPSIS
@@ -36,11 +36,13 @@ mkfs.f2fs \- create an F2FS file system
 .I debugging-level
 ]
 .I device
+.I [sectors]
 .SH DESCRIPTION
 .B mkfs.f2fs
 is used to create a f2fs file system (usually in a disk partition).
 \fIdevice\fP is the special file corresponding to the device (e.g.
 \fI/dev/sdXX\fP).
+\fIsectors\fP is optionally given for specifing the filesystem size.
 .PP
 The exit code returned by
 .B mkfs.f2fs
-- 
2.5.4 (Apple Git-61)


------------------------------------------------------------------------------

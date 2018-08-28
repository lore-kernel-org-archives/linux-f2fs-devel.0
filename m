From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] f2fs-tools: Fix cross-build problem caused by
 AC_CHECK_FILE abuse
Date: Mon, 27 Aug 2018 20:29:41 -0400
Message-ID: <20180828002941.7507-1-tytso@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <tytso@thunk.org>) id 1fuRtQ-0003Ky-Ea
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 00:30:00 +0000
Received: from imap.thunk.org ([74.207.234.97])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fuRtO-000L7k-0X
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 28 Aug 2018 00:30:00 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Helmut Grohne <helmut@subdivi.de>, Theodore Ts'o <tytso@mit.edu>

From: Helmut Grohne <helmut@subdivi.de>

f2fs-tools fails to cross build from source, because its upstream
build system wrongly uses AC_CHECK_FILE. The purpose of the macro is
checking for files on the host system. However here it is used to
check whether a .git directory exists, which is a property of the
build place. A simple "test -d" should be used here. After doing so,
f2fs-tools cross builds successfully.

Addresses-Debian-Bug: #896909

Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---

This was a FTCBFS problem reported by a Debian user:

	https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=896909

 configure.ac | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 62c18eb..f3e12d8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -20,14 +20,14 @@ AC_DEFINE([F2FS_MINOR_VERSION], m4_bpatsubst(f2fs_tools_version,
 				[\([0-9]*\).\([0-9]*\)\(\w\|\W\)*], [\2]),
 				[Minor version for f2fs-tools])
 
-AC_CHECK_FILE(.git,
+AS_IF([test -d .git],[
 	AC_DEFINE([F2FS_TOOLS_DATE],
 		"m4_bpatsubst(f2fs_tools_gitdate,
 		[\([0-9-]*\)\(\w\|\W\)*], [\1])",
-		[f2fs-tools date based on Git commits]),
+		[f2fs-tools date based on Git commits])],[
 	AC_DEFINE([F2FS_TOOLS_DATE],
 		"f2fs_tools_date",
-		[f2fs-tools date based on Source releases]))
+		[f2fs-tools date based on Source releases])])
 
 AC_CONFIG_SRCDIR([config.h.in])
 AC_CONFIG_HEADER([config.h])
-- 
2.18.0.rc0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot

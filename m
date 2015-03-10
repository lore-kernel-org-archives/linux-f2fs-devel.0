From: Gustavo Zacarias <gustavo@zacarias.com.ar>
Subject: [PATCH] configure: add check for fallocate
Date: Tue, 10 Mar 2015 15:53:17 -0300
Message-ID: <1426013597-24801-1-git-send-email-gustavo@zacarias.com.ar>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <gustavo@zacarias.com.ar>) id 1YVPfO-0007Bo-Sv
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 19:18:11 +0000
Received: from www.zacarias.com.ar ([176.9.42.171])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1YVPfL-0000kn-J8
	for linux-f2fs-devel@lists.sourceforge.net;
	Tue, 10 Mar 2015 19:18:10 +0000
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

We need to check for fallocate() rather than just linux/falloc.h +
FALLOC_FL_PUNCH_HOLE since in uClibc we've got both but still not
fallocate() itself since it's only implemented in newer unreleased
versions.

Signed-off-by: Gustavo Zacarias <gustavo@zacarias.com.ar>
---
 configure.ac             | 1 +
 mkfs/f2fs_format_utils.c | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index ae451b8..900b84a 100644
--- a/configure.ac
+++ b/configure.ac
@@ -68,6 +68,7 @@ AC_TYPE_SIZE_T
 # Checks for library functions.
 AC_FUNC_GETMNTENT
 AC_CHECK_FUNCS_ONCE([
+	fallocate
 	getmntent
 	memset
 ])
diff --git a/mkfs/f2fs_format_utils.c b/mkfs/f2fs_format_utils.c
index a0f85f5..ddeafeb 100644
--- a/mkfs/f2fs_format_utils.c
+++ b/mkfs/f2fs_format_utils.c
@@ -46,7 +46,7 @@ int f2fs_trim_device()
 #if defined(WITH_BLKDISCARD) && defined(BLKDISCARD)
 	MSG(0, "Info: Discarding device\n");
 	if (S_ISREG(stat_buf.st_mode)) {
-#ifdef FALLOC_FL_PUNCH_HOLE
+#if defined(HAVE_FALLOCATE) && defined(FALLOC_FL_PUNCH_HOLE)
 		if (fallocate(config.fd, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				range[0], range[1]) < 0) {
 			MSG(0, "Info: fallocate(PUNCH_HOLE|KEEP_SIZE) is failed\n");
-- 
2.0.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/

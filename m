From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 1/2] f2fscrypt: avoid to fail android build
Date: Mon,  4 Mar 2019 14:17:15 -0800
Message-ID: <20190304221716.36174-1-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1h0vtm-0006HC-Mh
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:17:26 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1h0vtj-003Sbp-Qw
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 04 Mar 2019 22:17:26 +0000
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This fixes some static build errors.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/android_config.h | 4 ----
 tools/f2fscrypt.c        | 8 +++++---
 tools/f2fstat.c          | 2 +-
 3 files changed, 6 insertions(+), 8 deletions(-)

diff --git a/include/android_config.h b/include/android_config.h
index 4582887..0613400 100644
--- a/include/android_config.h
+++ b/include/android_config.h
@@ -18,13 +18,11 @@
 #define HAVE_SYS_XATTR_H 1
 #define HAVE_UNISTD_H 1
 
-#define HAVE_ADD_KEY 1
 #define HAVE_FALLOCATE 1
 #define HAVE_FSETXATTR 1
 #define HAVE_FSTAT 1
 #define HAVE_FSTAT64 1
 #define HAVE_GETMNTENT 1
-#define HAVE_KEYCTL 1
 #define HAVE_LLSEEK 1
 #define HAVE_LSEEK64 1
 #define HAVE_MEMSET 1
@@ -48,13 +46,11 @@
 #define HAVE_SYS_XATTR_H 1
 #define HAVE_UNISTD_H 1
 
-#define HAVE_ADD_KEY 1
 #define HAVE_FALLOCATE 1
 #define HAVE_FSETXATTR 1
 #define HAVE_FSTAT 1
 #define HAVE_FSTAT64 1
 #define HAVE_GETMNTENT 1
-#define HAVE_KEYCTL 1
 #define HAVE_LLSEEK 1
 #define HAVE_MEMSET 1
 
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index 81ef830..fe3e0ff 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -275,7 +275,8 @@ static void clear_secrets(void)
 	memset(in_passphrase, 0, sizeof(in_passphrase));
 }
 
-static void die_signal_handler(int signum, siginfo_t *siginfo, void *context)
+static void die_signal_handler(int UNUSED(signum),
+		siginfo_t *UNUSED(siginfo), void *UNUSED(context))
 {
 	clear_secrets();
 	exit(-1);
@@ -837,7 +838,8 @@ static void do_get_policy(int argc, char **argv, const struct cmd_desc *cmd)
 "Give the invoking process (typically a shell) a new session keyring,\n" \
 "discarding its old session keyring.\n"
 
-static void do_new_session(int argc, char **argv, const struct cmd_desc *cmd)
+static void do_new_session(int argc, char **UNUSED(argv),
+					const struct cmd_desc *cmd)
 {
 	long keyid, ret;
 
@@ -872,7 +874,7 @@ const struct cmd_desc cmd_list[] = {
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-static void do_help(int argc, char **argv, const struct cmd_desc *cmd)
+static void do_help(int argc, char **argv, const struct cmd_desc *UNUSED(cmd))
 {
 	const struct cmd_desc *p;
 
diff --git a/tools/f2fstat.c b/tools/f2fstat.c
index 7f485b0..e0b1677 100644
--- a/tools/f2fstat.c
+++ b/tools/f2fstat.c
@@ -81,7 +81,7 @@ void f2fstat(struct options *opt)
 	int ret;
 	char keyname[32];
 	char buf[4096];
-	struct mm_table key = { keyname, NULL };
+	struct mm_table key = { keyname, NULL, 0 };
 	struct mm_table *found;
 	int f2fstat_table_cnt;
 	char *head, *tail;
-- 
2.19.0.605.g01d371f741-goog

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 713F4C48260
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Feb 2024 03:47:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rapCS-0006bN-Mi;
	Fri, 16 Feb 2024 03:47:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1rapCR-0006bG-KQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 03:47:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ryoyOSs7E32GkaAUq912e9OHNqIdLV7qQpjRCJbHuJ0=; b=WyyDA6/effxeK60mmvtYi+1BzC
 jwDz5ajIOOoNKnGttfzjTyeYBJ3E62sTNQ8PxQ8OZ4gtcFCkXWrWWhOGoW/H1LqycaC8kN4j4s/iT
 FHenmVL6hD58HCRuDLJwNw94aiwPybA5ZY3PCecOnUD+OuBHhVcWhqCcqqEXkLlAgTG0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ryoyOSs7E32GkaAUq912e9OHNqIdLV7qQpjRCJbHuJ0=; b=d
 9PtmxHI8fB5EwikvxD57ZIaeI1Z4FY8OG3qUlk6n9WgGHw29U/rEqSWgtX4u/MxhSFrb4Q+k7oQuN
 D1XqEwvDK23xC7jIK6Swnnm7OgOPGencbAjoJLeHDdtFh3E4Eb+zCVjA4wb+ZQzW4ZnnZaWu+xRif
 +dmLNwcziDT8sNuE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rapCM-000273-HX for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Feb 2024 03:47:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 341E461EDE;
 Fri, 16 Feb 2024 03:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C653EC433F1;
 Fri, 16 Feb 2024 03:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708055253;
 bh=FuuzrVg/ySCmf62ASq4uKebzCnUfFcKuq9Rgbs8miyQ=;
 h=From:To:Cc:Subject:Date:From;
 b=jIWUdp9Hx2xVCDNchmocz0WjJN+TV4UodYonoTQzSRA6L4pCk64VxIr/R4OBvL4fQ
 voU+3WClhDUPqMltY00657XAZ0FdJMTGrfugEX4xHfYANoicoqne3bYJkzWVd478lf
 wYTmyMABuWa08hXTr50aIyWxLnuLF4TD+6oC4ykpJ3sPH2bDs3vU62tmr0UbTxBTdE
 S2snOkVZVcpQjo7km+ydWDIRiI62czXRyua2DNRFmSotl0nY1y8Bs/0N4z9LD4LSSb
 tN/WGtTSDa9PcAOY9LdFXDVNgqTrVJEcVwgjmDYn0dmDQeo6KV4GixKbM4KcIrvdvL
 yLzc9GZUX6qvg==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 15 Feb 2024 19:47:32 -0800
Message-ID: <20240216034732.4152498-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
MIME-Version: 1.0
X-Headers-End: 1rapCM-000273-HX
Subject: [f2fs-dev] [PATCH] f2fs_io: add write_advice command
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Konstantin Vyshetsky <vkon@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Konstantin Vyshetsky <vkon@google.com>

Add a write_advice command with same behavior as existing write command
with the exception that data should be treated as hot or cold.

Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/f2fs_io/f2fs_io.c | 114 ++++++++++++++++++++++++++++++----------
 tools/f2fs_io/f2fs_io.h |   4 ++
 2 files changed, 90 insertions(+), 28 deletions(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 1df9034acdd9..7059cbfab40d 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -597,26 +597,8 @@ static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
-#define write_desc "write data into file"
-#define write_help					\
-"f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path] {delay}\n\n"	\
-"Write given patten data in file_path\n"		\
-"pattern can be\n"					\
-"  zero          : zeros\n"				\
-"  inc_num       : incrementing numbers\n"		\
-"  rand          : random numbers\n"			\
-"IO can be\n"						\
-"  buffered      : buffered IO\n"			\
-"  dio           : O_DIRECT\n"				\
-"  dsync         : O_DIRECT | O_DSYNC\n"		\
-"  osync         : O_SYNC\n"				\
-"  atomic_commit : atomic write & commit\n"		\
-"  atomic_abort  : atomic write & abort\n"		\
-"  atomic_rcommit: atomic replace & commit\n"	\
-"  atomic_rabort : atomic replace & abort\n"	\
-"{delay} is in ms unit and optional only for atomic operations\n"
-
-static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
+static void do_write_with_advice(int argc, char **argv,
+			const struct cmd_desc *cmd, bool with_advice)
 {
 	u64 buf_size = 0, inc_num = 0, written = 0;
 	u64 offset;
@@ -630,12 +612,6 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 
 	srand(time(0));
 
-	if (argc < 7 || argc > 8) {
-		fputs("Excess arguments\n\n", stderr);
-		fputs(cmd->cmd_help, stderr);
-		exit(1);
-	}
-
 	bs = atoi(argv[1]);
 	if (bs > 1024)
 		die("Too big chunk size - limit: 4MB");
@@ -672,7 +648,28 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 		die("Wrong IO type");
 	}
 
-	fd = xopen(argv[6], O_CREAT | O_WRONLY | flags, 0755);
+	if (!with_advice) {
+		fd = xopen(argv[6], O_CREAT | O_WRONLY | flags, 0755);
+	} else {
+		unsigned char advice;
+		int ret;
+
+		if (!strcmp(argv[6], "hot"))
+			advice = FADVISE_HOT_BIT;
+		else if (!strcmp(argv[6], "cold"))
+			advice = FADVISE_COLD_BIT;
+		else
+			die("Wrong Advise type");
+
+		fd = xopen(argv[7], O_CREAT | O_WRONLY | flags, 0755);
+
+		ret = fsetxattr(fd, F2FS_SYSTEM_ADVISE_NAME,
+				    (char *)&advice, 1, XATTR_CREATE);
+		if (ret) {
+			fputs("fsetxattr advice failed\n", stderr);
+			exit(1);
+		}
+	}
 
 	if (atomic_commit || atomic_abort) {
 		int ret;
@@ -739,6 +736,67 @@ static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define write_desc "write data into file"
+#define write_help					\
+"f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path] {delay}\n\n"	\
+"Write given patten data in file_path\n"		\
+"pattern can be\n"					\
+"  zero          : zeros\n"				\
+"  inc_num       : incrementing numbers\n"		\
+"  rand          : random numbers\n"			\
+"IO can be\n"						\
+"  buffered      : buffered IO\n"			\
+"  dio           : O_DIRECT\n"				\
+"  dsync         : O_DIRECT | O_DSYNC\n"		\
+"  osync         : O_SYNC\n"				\
+"  atomic_commit : atomic write & commit\n"		\
+"  atomic_abort  : atomic write & abort\n"		\
+"  atomic_rcommit: atomic replace & commit\n"		\
+"  atomic_rabort : atomic replace & abort\n"		\
+"{delay} is in ms unit and optional only for atomic operations\n"
+
+static void do_write(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	if (argc < 7 || argc > 8) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+	do_write_with_advice(argc, argv, cmd, false);
+}
+
+#define write_advice_desc "write data into file with a hint"
+#define write_advice_help					\
+"f2fs_io write_advice [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [advise] [file_path] {delay}\n\n"	\
+"Write given patten data in file_path\n"		\
+"pattern can be\n"					\
+"  zero          : zeros\n"				\
+"  inc_num       : incrementing numbers\n"		\
+"  rand          : random numbers\n"			\
+"IO can be\n"						\
+"  buffered      : buffered IO\n"			\
+"  dio           : O_DIRECT\n"				\
+"  dsync         : O_DIRECT | O_DSYNC\n"		\
+"  osync         : O_SYNC\n"				\
+"  atomic_commit : atomic write & commit\n"		\
+"  atomic_abort  : atomic write & abort\n"		\
+"  atomic_rcommit: atomic replace & commit\n"		\
+"  atomic_rabort : atomic replace & abort\n"		\
+"advise can be\n"					\
+"  cold : indicate a cold file\n"			\
+"  hot  : indicate a hot file\n"			\
+"{delay} is in ms unit and optional only for atomic operations\n"
+
+static void do_write_advice(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	if (argc < 8 || argc > 9) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+	do_write_with_advice(argc, argv, cmd, true);
+}
+
 #define read_desc "read data from file"
 #define read_help					\
 "f2fs_io read [chunk_size in 4kb] [offset in chunk_size] [count] [IO] [print_nbytes] [file_path]\n\n"	\
@@ -1588,7 +1646,6 @@ static void do_listxattr(int argc, char **argv, const struct cmd_desc *cmd)
 
 #define setxattr_desc "setxattr"
 #define setxattr_help "f2fs_io setxattr [name] [value] [file_path]\n\n"
-#define F2FS_SYSTEM_ADVISE_NAME	"system.advise"
 
 static void do_setxattr(int argc, char **argv, const struct cmd_desc *cmd)
 {
@@ -1704,6 +1761,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(fallocate),
 	CMD(erase),
 	CMD(write),
+	CMD(write_advice),
 	CMD(read),
 	CMD(randread),
 	CMD(fiemap),
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index b4aa9cfeac02..d2641cbb6970 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -167,6 +167,10 @@ struct fscrypt_get_policy_ex_arg {
 #define F2FS_IOC_FSGETXATTR		FS_IOC_FSGETXATTR
 #define F2FS_IOC_FSSETXATTR		FS_IOC_FSSETXATTR
 
+#define F2FS_SYSTEM_ADVISE_NAME	"system.advise"
+#define FADVISE_COLD_BIT	0x01
+#define FADVISE_HOT_BIT		0x20
+
 #ifndef FS_IMMUTABLE_FL
 #define FS_IMMUTABLE_FL			0x00000010 /* Immutable file */
 #endif
-- 
2.44.0.rc0.258.g7320e95886-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

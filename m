Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD813C5CFCF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Aug 2026 16:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=EoT0WUwNBcdQeUc2kMcPNDgM/26Ee1Qc2tx90Bn9TLw=; b=gfdqAExCsmwa00ln5QiUzBDaCS
	rkp2PgOPsNnx6Hrao79QDFfKSRaBwwETnwpoMmn9RQZbVTEzxp/2siwFdhx9TCvOTny9cd2lp4gmK
	bJ9vgMQPkxWjwz44sUIaqA8wFUt4Cv/LF+yK2VG3leyoOs+e4u5FSDyD6wCYReSt6aBU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wuv79-0006CX-JQ;
	Fri, 14 Aug 2026 16:50:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <yangyongpeng.storage@gmail.com>) id 1wuv6w-0006By-ND
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:50:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FKQYe757dVza+zfn+crk8LzBCJ2wEr3hC+1rkx+8QP0=; b=BJAq998c2mr7Vo9EW1bJRE5sB+
 ig2XCq/oZkfFSy+z26eyV31LywSKxg47x5K5/xBaqefExEJBhhSNA69jnuh3DG6lcsmtFQ89bQKCo
 +mtSBusAzNX+8lQdPGg6jPf5JXM6WoV6Hj9l9hQduPNB/SWFy6rHVEDUdzuFerVhHuYo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FKQYe757dVza+zfn+crk8LzBCJ2wEr3hC+1rkx+8QP0=; b=D
 7+TqQBiGYrkCKM8RfsEttZ5kpHlNbhiDafGpzO+tm2x+MiNq9enCEz6iwoCpTO4M/GWrYLjZiiqTM
 A+NSzrleMToTSqRa99EKwXdwcyT1lVIxfug0Vxh4hB9vgRsELqefgMlt3FgIbS0i6SeQGcvQ7+UD+
 w2z84UvhPXr8OtfI=;
Received: from mail-wr1-f45.google.com ([209.85.221.45])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wuv6w-0007EY-Vb for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Aug 2026 16:50:27 +0000
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-47f7872abb6so709578f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Aug 2026 09:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786726220; x=1787331020; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=FKQYe757dVza+zfn+crk8LzBCJ2wEr3hC+1rkx+8QP0=;
 b=NPmf7hBNx0mTkJx+2x/THIcaznd72Tucsp6evvIwGjHEDWutL7gkW6ynB8JMb//fCs
 lYzgWUrBWalBAro4352Q3TqUIPuMz/RSxR0aWmpQXdwmY0GwLu/P7FyLzV103w1jD3HW
 ZGN84zHXpXOq2ddu3uE3O9L512hfK5FC6RP+qxe30yFpIUth1CQHwe5ISRSmvUUOUFWH
 2NTO0RRdeXCMKPdAf2Ku75wL4qo5MqF3pvntekdijY0Jx9phxxBQnKG/wyADQlNTmoAv
 jVFdmSWq+89VH2MyX1W5YEOsTHUaSPDcDQbxBRpArdnSn9q1jOiX3Z0YYDCMOZ5vfC/7
 N6yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786726220; x=1787331020;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FKQYe757dVza+zfn+crk8LzBCJ2wEr3hC+1rkx+8QP0=;
 b=bLYBDrC7WjrQIbM2pxRoqkS/1nqGZtCVu8yXk8IOkeVc0E5vi11FhgTojI5EXrmR7p
 P2ormVC6ofufqX3VD7j29c1draCpJzNm002IfvsRTRSJCyfEGv2VgnLBz9PpzNAOWzQp
 fohnp4xft8EuJJ5pvGHybWrwwSBLEg03XyLirVu87MzXYoWZjOfCwjBO1yYmaTuaIHqz
 HFOO+qqr+6nFhijBcHedTSEcn4BgYJ29xc61flmTKtCi4Y6Glcf2IAhi9JDG/8ocCMd/
 +aDieILAP48+ZRiPYHmHZBOFdmcjb21qCrJVP0B9/PqhdlVfMY6aRU4xr5VwTfiQef9m
 Zo9A==
X-Gm-Message-State: AOJu0YxEj/uUhV1cCzC5kIdfxqmEbD1jIkAuC+5qwO2fIWNlIZf5LeJf
 A/M/uSzEMyhC/keFTeO5l7JLaCGfjA+H+dptov6bINwhK4/GJmkvRqm/
X-Gm-Gg: AR+sD12e6vs1dSMkMx/ReAKWrDf9yC1oZ+rynkOkbYi8Hi6AKb0kDVZG2/Z2r66Tpwd
 BurSz86lt6RT1YRfkcmqMHm0ag1AtPkC1sIso8cLYtHvziBP6n4PFGni/Pkx3afh6Ief9M60WIR
 be/q5ukm8FY4yUb+h+iPbY3tEEaFn+CCXFmYXXLk05kasppeFhhBmZxoG3hrkLpudoElygrtieA
 lLOhkecz1xha304/kwyiDGIyp/K78oGOdD+15s/99zhICzHzlC6TsIrCQvm6jE3bKAho7pJFhS+
 DiRXnbPRUHpte89F7rRULDlOegWV2jObrOfcmXwuDiFO5op2TPWMFSrTmt8DpgG8m6tTfFbjfO9
 KgmFE9saROkfC/vlRaxKz09Dmou4gnTDme2NSyscrXfTOgDWZvJIA6Z587vGaRQ8Yv/DejVG1bE
 59KiK2bViqm7UrBH9z7Z2QfVKgllB5hksZA/yPFSrI+c7Bq3Sg2ZUY4YHbRZ8/bUtsEFrP5cxHL
 xry5Cng4sbW7axL7qnUa7DQirbwpOWPfLs=
X-Received: by 2002:a05:6000:2606:b0:482:6faf:4078 with SMTP id
 ffacd0b85a97d-4826faf4102mr5282684f8f.21.1786726220311; 
 Fri, 14 Aug 2026 09:50:20 -0700 (PDT)
Received: from xiaomi-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4815f1fff25sm15116681f8f.3.2026.08.14.09.50.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 14 Aug 2026 09:50:19 -0700 (PDT)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Sat, 15 Aug 2026 00:50:08 +0800
Message-ID: <20260814165008.693980-1-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wuv6w-0007EY-Vb
Subject: [f2fs-dev] [PATCH] f2fs_io: add extent_cache command to dump read
 extent cache
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

Add an "extent_cache" subcommand that dumps the in-memory read extent
cache of a given file to the kernel log, by passing the file's
descriptor to the /sys/fs/f2fs/<dev>/extent_cache_debug sysfs entry
introduced by the kernel counterpart patch.

The dump itself is emitted by the kernel via f2fs_info(),  inspect it
with "dmesg | grep ino=<ino>".

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 tools/f2fs_io/f2fs_io.c | 65 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 65 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 06e0ea0..3025b7b 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -33,6 +33,7 @@
 #include <sys/mman.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
+#include <sys/sysmacros.h>
 #include <sys/types.h>
 #include <termios.h>
 #include <time.h>
@@ -1965,6 +1966,69 @@ static void do_precache_extents(int argc, char **argv, const struct cmd_desc *cm
 	exit(0);
 }
 
+#define extent_cache_desc "dump the in-memory read extent cache of a file"
+#define extent_cache_help							\
+"f2fs_io extent_cache [file_path]\n\n"					\
+"Dump the in-memory read extent cache (largest extent plus every rbtree\n" \
+"node, as fofs/blk/len) of the given file to the kernel log by passing\n" \
+"its file descriptor to the per-sb sysfs entry\n"			\
+"/sys/fs/f2fs/<dev>/extent_cache_debug.\n\n"				\
+"Read the file beforehand so its extent tree is populated, then run\n" \
+"this command and inspect the dump with 'dmesg | grep ino=<ino>'.\n"
+
+static void do_extent_cache(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	struct stat st;
+	char fd_str[32];
+	char devlink[PATH_MAX];
+	char devname[NAME_MAX + 1];
+	char sysfs_path[PATH_MAX];
+	char *base;
+	ssize_t rlen;
+	int fd, sfd, ret;
+
+	if (argc != 2) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	/* Open the target file; its fd is handed to the kernel. */
+	fd = xopen(argv[1], O_RDONLY, 0);
+	if (fstat(fd, &st) < 0)
+		die_errno("fstat %s failed", argv[1]);
+	if (!S_ISREG(st.st_mode))
+		die("%s is not a regular file", argv[1]);
+
+	/* Resolve the kernel device name (sb->s_id) from st_dev. */
+	ret = snprintf(devlink, sizeof(devlink), "/sys/dev/block/%u:%u",
+		       major(st.st_dev), minor(st.st_dev));
+	if (ret < 0 || (size_t)ret >= sizeof(devlink))
+		die("device path too long");
+	rlen = readlink(devlink, sysfs_path, sizeof(sysfs_path) - 1);
+	if (rlen < 0)
+		die_errno("readlink %s failed", devlink);
+	sysfs_path[rlen] = '\0';
+	base = basename(sysfs_path);
+	snprintf(devname, sizeof(devname), "%s", base);
+
+	ret = snprintf(sysfs_path, sizeof(sysfs_path),
+		       "/sys/fs/f2fs/%s/extent_cache_debug", devname);
+	if (ret < 0 || (size_t)ret >= sizeof(sysfs_path))
+		die("sysfs path too long");
+
+	/* Pass the fd to the kernel; the dump is written to the kernel log. */
+	snprintf(fd_str, sizeof(fd_str), "%d", fd);
+	sfd = xopen(sysfs_path, O_WRONLY, 0);
+	full_write(sfd, fd_str, strlen(fd_str));
+	close(sfd);
+
+	printf("ino=%lu extent cache dump written to kernel log\n"
+	       "inspect with: dmesg | grep ino=%lu\n", st.st_ino, st.st_ino);
+	close(fd);
+	exit(0);
+}
+
 #define move_range_desc "moving a range of data blocks from source file to destination file"
 #define move_range_help						\
 "f2fs_io move_range [src_path] [dst_path] [src_start] [dst_start] "	\
@@ -2636,6 +2700,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(gc),
 	CMD(checkpoint),
 	CMD(precache_extents),
+	CMD(extent_cache),
 	CMD(move_range),
 	CMD(gc_range),
 	CMD(listxattr),
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=cFgK=DU=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5C4C433E7
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2020 20:15:17 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22984208D5;
	Tue, 13 Oct 2020 20:15:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.b="G55omDtj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GeQWFHvL";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="SjH98nNf";
	dkim=neutral (0-bit key) header.d=google.com header.i=@google.com header.b="BKuOba0L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22984208D5
Authentication-Results: mail.kernel.org; dmarc=pass (p=none dis=none) header.from=lists.sourceforge.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Mime-Version:Message-Id:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=zlJgysOZW32DaJLKlC6zWcdB7C794tjY3XySJdD0AF0=; b=G55omDtjGs2huG0EQyl774n/4p
	YQ1/hmfly8RoYmhLdJU7/xJj8pqiwc+7YnloogOm01uNz+aKMFB6caQ+vCvFg0lW73PeslJTsaFXH
	OdImAsxA9d8kSV12WA9K9pGwQ6Rbzpmr6YeDdVyDW0ZU7NEGDlKJM73+l3x3ItfrnYQw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kSQhX-00078z-BZ; Tue, 13 Oct 2020 20:15:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3ZOKFXwkKAEMthjfshmjslttlqj.htr@flex--oceanchen.bounces.google.com>)
 id 1kSQhW-00078r-3i
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Oct 2020 20:15:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Mime-Version:
 Message-Id:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=; b=GeQWFHvLJ8NTrnYeRy3Ds7QU9g
 6qfZd16V/osuXWQASXENCeMUyqaCWP5cxmvISK8DR0xh7+M71fjFPpd6SyySm4AewAQXY2xqcu+KO
 XhUaUWxLfm2FZ3Re2muBalT9Y8731F2HP6KW6gJlpJHvPWwVurUSU9FMm4pvQUohPKcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Mime-Version:Message-Id:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=; b=S
 jH98nNfs/OBV5XxiSHU6r0oCzXoaJ6RGdUtNbszjdwkwqGxrrYpOqnqOFIi5zlY3085Y7F3+P0JG0
 1N0BLx62+RkBMOIVjrgxfhE1gnWRCejt8hXplAaDkGVM7dq4cI9kiLGZgnn7aVPVFcb++qDdvT4cl
 y7jWczUeLNIe2ptk=;
Received: from mail-pj1-f73.google.com ([209.85.216.73])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kSQhT-0094IX-Ub
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 13 Oct 2020 20:15:14 +0000
Received: by mail-pj1-f73.google.com with SMTP id d5so39440pjm.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2020 13:15:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=sender:date:message-id:mime-version:subject:from:to:cc;
 bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=;
 b=BKuOba0LLtscjZtPuBYP4WXvOyvG/bSv+0NGruQNLLHY71uSi0QBsSJschwv1erfrn
 plbRPvm6XWLdju+9q1V/WNG0LphZYwUqUjHxmLBakesLvmxjn3yQ9ZttJ4RcDt61mYyp
 MPBzOtiQREz9JVR9aFcec2vAV/6/C8gaMpRSnGKMfcQ/pFxsRh+fZYp2skY/i7KkM4cc
 uoTrZBKGpyTaPsyEF+F4qTmnBrUw6e4IxPXoEoSnvSysUJkXhvoaSR4In+UAKc9UePHx
 Z4GbUq36yG6mE10NAS98aNlVTGfrUmUHvHV4Vq2YzRUjymIkyxsezvWVDTPIqmbKlYrJ
 To6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:date:message-id:mime-version:subject:from
 :to:cc;
 bh=ljkCIQrwrjsGy0cTJoQSe2caDNaXNxndtQSxnTEHTS4=;
 b=QQzxT1nOvZb6dXYpoKYDzF8dSHCjQsQFvQmv3xvQfJBUlDc0D4Ex2OScg6rX6lhwiO
 GG/XDrsi121VUVK6PYjEfEzzaSsQKRTBmqHKeXyFHABj0+sG+krGo2Gmly+bph+KPQ06
 UfJOTffHMEEvveQGKe5LTvXDvIEIMS/S1ZhGb1wQU7sgbnlZnNKkxInxWSrAVFxxilFt
 vD4GJcBsEymKFbWCZtcZRdQj0LTu+yLPoJAdqWEIw6lw9mZIyFITX9FmTE25FODCtKB1
 JoHk+KOj5g8vJxSP/MjrMI4qqWGGZDSioMd+MN5PCbEWB+y7cHoJMKSV0V7HybmLOOLF
 voyg==
X-Gm-Message-State: AOAM532GGMZdXfQUJAVgskGIYHAjOMfoLUC2t8n7T3ozWnX+cJyhvLen
 xtdVlVhS4MiRdFBznCYozKTorllKLlJ0vm0=
X-Google-Smtp-Source: ABdhPJwOYz0tBvfJQWBtJ+py1RvlZXpskuwJH022we9jVgVviHz7OnEEQUQ17BRNuoLLBOZH7eG/m1s/P75r2UI=
X-Received: from oceanchen.tao.corp.google.com
 ([2401:fa00:fd:2:3e52:82ff:fe5e:f3ed])
 (user=oceanchen job=sendgmr) by 2002:a0c:8c4c:: with SMTP id
 o12mr671849qvb.46.1602609764207; Tue, 13 Oct 2020 10:22:44 -0700 (PDT)
Date: Wed, 14 Oct 2020 01:22:40 +0800
Message-Id: <20201013172240.251899-1-oceanchen@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
To: jaegeuk@kernel.org, yuchao0@huawei.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
X-Headers-End: 1kSQhT-0094IX-Ub
Subject: [f2fs-dev] [PATCH] f2fs_io: add erase option
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
From: Ocean Chen via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Ocean Chen <oceanchen@google.com>
Cc: oceanchen@google.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_io erase [block_device_path]

Signed-off-by: Ocean Chen <oceanchen@google.com>
---
 tools/f2fs_io/f2fs_io.c | 53 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 52 insertions(+), 1 deletion(-)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index 1ca82f1..cef32b1 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -24,13 +24,13 @@
 #include <getopt.h>
 #include <inttypes.h>
 #include <limits.h>
+#include <linux/fs.h>
 #include <signal.h>
 #include <stdarg.h>
 #include <stdbool.h>
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
-#include <string.h>
 #include <sys/mman.h>
 #include <sys/sendfile.h>
 #include <sys/stat.h>
@@ -432,6 +432,56 @@ static void do_fallocate(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define erase_desc "erase a block device"
+#define erase_help				\
+"f2fs_io erase [block_device_path]\n\n"		\
+"Send DISCARD | BLKSECDISCARD comamnd to"	\
+"block device in block_device_path\n"		\
+
+static void do_erase(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, ret;
+	struct stat st;
+	u64 range[2];
+
+	if (argc != 2) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	if (stat(argv[1], &st) != 0) {
+		fputs("stat error\n", stderr);
+		exit(1);
+	}
+
+	if (!S_ISBLK(st.st_mode)) {
+		fputs(argv[1], stderr);
+		fputs(" is not a block device\n", stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[1], O_WRONLY, 0);
+
+	range[0] = 0;
+	ret = ioctl(fd, BLKGETSIZE64, &range[1]);
+	if (ret < 0) {
+		fputs("get size failed\n", stderr);
+		exit(1);
+	}
+
+	ret = ioctl(fd, BLKSECDISCARD, &range);
+	if (ret < 0) {
+		ret = ioctl(fd, BLKDISCARD, &range);
+		if (ret < 0) {
+			fputs("Discard failed\n", stderr);
+			exit(1);
+		}
+	}
+
+	exit(0);
+}
+
 #define write_desc "write data into file"
 #define write_help					\
 "f2fs_io write [chunk_size in 4kb] [offset in chunk_size] [count] [pattern] [IO] [file_path]\n\n"	\
@@ -951,6 +1001,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(shutdown),
 	CMD(pinfile),
 	CMD(fallocate),
+	CMD(erase),
 	CMD(write),
 	CMD(read),
 	CMD(randread),
-- 
2.28.0.1011.ga647a8990f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

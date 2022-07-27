Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD147C04A68
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 Jul 2022 15:09:52 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oGifV-0007hl-H1; Wed, 27 Jul 2022 15:09:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oGifT-0007hf-MQ
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jul 2022 15:09:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LHmdI07e7CQujUltONE8g+psJBOLVrsNFjZ8/2CPzUc=; b=TvGeRHoBAhH2OR3P0WHMer/r+w
 Mcfj/MTuVj08A678N8W3yOP+0Wcq4uY/w2U/wv7JBvDUaGjikwJgSHw6Np8yZatYvG4BxkMwawH9A
 WpiODyeHxTYGX7qiZaOljp//O5VSHP3ER4z1XLnyMMyIvmcfuA07ZD+/F4C72j//Kxd0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LHmdI07e7CQujUltONE8g+psJBOLVrsNFjZ8/2CPzUc=; b=W
 e2y5yq04/MYTGDxsLmLAs74ZEQToXnRfo7kMUuyaTfdDvtxt4auDgKAUZqWxjd7EzB+kvooHm2/1M
 qxxq9QwxWfj1dn34YYbwXv7oZt8nBM792n2GhVmi5160WjvagV8+nEtekLm2vAeNXN7CXCap9+LJV
 PTsT1XYWIyb9r3JU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oGifS-0005ZQ-QX
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 Jul 2022 15:09:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 62B7CB82198;
 Wed, 27 Jul 2022 15:09:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11A5C433D7;
 Wed, 27 Jul 2022 15:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658934578;
 bh=2zVKL05JFFdmF0O+nwk28zeVSf9sdJnK0AtR9koYPf8=;
 h=From:To:Cc:Subject:Date:From;
 b=XeuN683XXK6oXUWdxJxv+ojjctS6Joeg6CtaGxvGYF4RXV9BHW0wXK6EUrecjPD8o
 0u37hj0jAqjqrKpZa8XJ2lDzAYkRqZuZYnoTnxbegopVSCnlAD7D/NYfS+yPvnbw7H
 R39QUh2AnFFaLJpraAVm8+Ev/zxtFmUzkmT0R3LPmmOPdSKVUw7TMhI3ejWFa38JhG
 KYaxirmUU8dDybV43aXWlvcAZiZBm3hM34XjEGOTWayAmydwe4I+0CaxHHPaIVf6U2
 +o+kmHUMwX4QMZdR6KHOrprUIdSbFQtWGKmwvmoG8odl8qP/FxT/xjc2r+Xsswr0NB
 iy/ZVZXbiZ+KA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed, 27 Jul 2022 23:09:25 +0800
Message-Id: <20220727150925.1983251-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oGifS-0005ZQ-QX
Subject: [f2fs-dev] [PATCH] f2fs_io: support triggering filesystem GC via
 ioctl
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao.yu@oppo.com>

Support 'gc' sub command to trigger filesystem GC via ioctl in f2fs.

Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 man/f2fs_io.8           |  3 +++
 tools/f2fs_io/f2fs_io.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/man/f2fs_io.8 b/man/f2fs_io.8
index af7325a..33789c2 100644
--- a/man/f2fs_io.8
+++ b/man/f2fs_io.8
@@ -132,6 +132,9 @@ Release compressed blocks to get free space.
 .TP
 \fBreserve_cblocks\fR \fI[file]\fR
 Reserve free blocks to prepare decompressing blocks in the file.
+.TP
+\fBgc\fR \fI[sync_mode] [file]\fR
+Trigger filesystem GC
 .SH AUTHOR
 This version of
 .B f2fs_io
diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index e735983..5be7b9e 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -1270,6 +1270,33 @@ static void do_rename(int argc, char **argv, const struct cmd_desc *cmd)
 	exit(0);
 }
 
+#define gc_desc "trigger filesystem GC"
+#define gc_help "f2fs_io gc sync_mode [file_path]\n\n"
+
+static void do_gc(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	u32 sync;
+	int ret, fd;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	sync = atoi(argv[1]);
+
+	fd = xopen(argv[2], O_RDONLY, 0);
+
+	ret = ioctl(fd, F2FS_IOC_GARBAGE_COLLECT, &sync);
+	if (ret < 0)
+		die_errno("F2FS_IOC_GARBAGE_COLLECT failed");
+
+	printf("trigger %s gc ret=%d\n",
+		sync ? "synchronous" : "asynchronous", ret);
+	exit(0);
+}
+
 #define CMD_HIDDEN 	0x0001
 #define CMD(name) { #name, do_##name, name##_desc, name##_help, 0 }
 #define _CMD(name) { #name, do_##name, NULL, NULL, CMD_HIDDEN }
@@ -1301,6 +1328,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(compress),
 	CMD(get_filename_encrypt_mode),
 	CMD(rename),
+	CMD(gc),
 	{ NULL, NULL, NULL, NULL, 0 }
 };
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30466C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 16:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WroH6VWB9IIVHMXNlVWf2d8BFSFjMh51+k2D+PQiGoE=; b=ACqIOXmW2COg+pD7rKYf4gQhE0
	uXB4hznGFM+/e0lDMSirfZ/+NlYMsNXkFPEJmnefRaqT0A6Ho4Pf3juPX+qUvEKRNgKewjbQ/sN9I
	f8mTJlvIhC9JGXRW0XJFSoGclNBSUYK4XUOQmYmdcQ2sI7VQ5eHN37+RUGobaVUVCnmg=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqvXw-0005I1-8M;
	Mon, 03 Aug 2026 16:29:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wqvXu-0005Hv-2l
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 16:29:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Hu9icVjrHsBVioQppm2stSlUejm4enh11auG+1pjE+s=; b=bDmzvr+jevMtqYZGiKzHHbMqK5
 btQk/wccrSS6Yg7mf1h2WmgvfepMogEHMOT2nkacD5gcg6tPKzqkg6O2AObj/fZC/qW3gsXtc/dZP
 rQqXEz4AfaTs4T2IJzyFVvxEhcgX843gM7+aMcsD0hQzBwHJQFLM0dm1U6JDe4wvFt5Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Hu9icVjrHsBVioQppm2stSlUejm4enh11auG+1pjE+s=; b=l
 arpVu1Ek4moCfE0paVs99tiVuCMNoTwcfLJwvpDFFOZCxA4w+3aL5+ldTYVic0nLE0R3q4+NEJO9g
 BTBY7vTCfM7Rp05nU1+iMjSfB2HI2Xl/s03X1PJjInM+bPRPqtdmVWsnMF9LmzL+s3LWQ5AcdzOM6
 axvbiZWa8B3lgfIE=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqvXx-0001hd-2f for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 16:29:46 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-38ec1402b05so2592334a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 09:29:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785774580; x=1786379380; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Hu9icVjrHsBVioQppm2stSlUejm4enh11auG+1pjE+s=;
 b=k883WFmmRDqiHFWX1cdbxvzYXzejK4e2Vf/EcamPEQiSJiDSpob0cexjPXE8ZcSKpo
 a3kL5EjqL3uxnMcE34A1ivUy+Gf9WVPJm8i8RekpJQfcpWrJNu651O7bu/nH0VmyC8KM
 jPUMYmf0dY0hHUfG461fty1+cWNRpR0U3Rsp2hGR3lZUk78MQvfYqKbEUPmetNHv9tx7
 Qa+6Z2xwY+Ruyk2aaNcn3tlD93yviYj78H/v6I2dQBR6KnHamFDBtuOhmqWT3nvZvFlY
 3ov9Kup5L5ytlU2rEAnjytCGJ4q0ju6vaiewXsa9A/8+RXGfuesXViZSTLr6FWNusEFi
 ekUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785774580; x=1786379380;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Hu9icVjrHsBVioQppm2stSlUejm4enh11auG+1pjE+s=;
 b=M5PHmNTM4DfbmRGnNC0/l6jVv0Pt5I2YxvuM9u6fKetXSAfPbTI/sBdmtn2FJ6ZMnb
 Ei+H1TGB07AIA7qwHyLosWNhskyQPRQKaqI8FIBwQNTzu5njmeGCkos4XwThlIMuyX2B
 V/oAfZ6pP0xLVx0iWjzW/VYUdd0ZLrdjfhYqQXdTqMW+1+LRE7GiqoyVCbceKehJEAPY
 Bi/OdJq7aQ4IOHABxiMBaHcm2ANusMGNdT/7Uzu792D8F9GkdlMWzdnnuh27xAq9Sh4X
 OrCnj9hwaz1eGa15apcJLZKqKcRwZaW+j+D6+zBtRZLjq18JkbBuA5orbck0dfkjDEIL
 nz7g==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro+P6Q46IpnnmselKSFcVEH82BfviY8o5opTENo2ltbJzZAWmyZrVAR1zzEftl4T8nhmFrsDZRgQuIv2yR0tNI1@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwFyMHynzpCg0Z+CfHppjfqE2JyEEXpBB5l8GZpO3CUyz5g333p
 yOU5X1YvYVwS6oFEO4zaQ10MvCWEEiGOlEV6s5zgcy2DN3RFFSK7P0Hi
X-Gm-Gg: AR+sD100ssj752tPIwQMVavlNkX1z4Vo/mnVOJFjlFTPaOLTg7x/fflON9kQkqA6ZyA
 kov4dSHJftQ6tLAIdySWZQTuMkkFZPAPLWWrVDdicGYI7k+GDDDXT071XpR/zXBUN9lUkK9knQW
 fr6eMVTfSzRRI5Ms1tZ9VVO7FbPW/IBdxaIujeMwQktonEmk9CGjHsOJpv9/4/siSCY8hhg7uUL
 zBZnAQPMIAUwEiBHZkZDg2mVmRBaha1Xr4hMOJ64mnv9VpjstsO1GPrjmlhLtHS98zigHaAifGg
 59BF1N+aHA7T+heOFoyPedWpqqYbfQJia6UwSFSVFfOI0I0TbzSV5ib4i3rMuMbaKi+v3yeums/
 JLK5GOzgobJAcclvB0bvaD3l6wslWxXhe1C2YJ+4wgSHKfTbGurdklCcHQ6Y3QIQ93QUXR+zx0m
 9hF1HQOuAEYyGuC0+wkw6HmaaUp1z07cjn03tQKRv576dMTHCPlIP5wF/P8kZUNvrnDxgoqITZX
 WYLqBn8ALVPJne8yifuITJ8GQftpLskEltzCyWWEVsmXgVCfuQF0MwmQ/34WfWHJD790Aa5WK4A
 LmATIXGyeMb/
X-Received: by 2002:a17:90b:3947:b0:38e:5b59:c2ff with SMTP id
 98e67ed59e1d1-38fbc3f2522mr9145126a91.3.1785774579654; 
 Mon, 03 Aug 2026 09:29:39 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:d709:21da:d427:ef7d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab4cb50dsm54574228c88.10.2026.08.03.09.29.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 09:29:38 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  3 Aug 2026 09:29:35 -0700
Message-ID: <20260803162935.2056391-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wqvXx-0001hd-2f
Subject: [f2fs-dev] [PATCH v3] f2fs_io: add dev_alias command for dynamic
 device aliasing management
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

This commit adds a new 'dev_alias' command to f2fs_io tool to support
dynamic release, reservation and status querying of device alias ranges.

Signed-off-by: Daeho Jeong <daehojeong@google.com>

---
v3: renamed the interfaces for dev_alias.
v2: remove a f2fs specific flag from getflags.
---
 tools/f2fs_io/f2fs_io.c | 46 +++++++++++++++++++++++++++++++++++++++++
 tools/f2fs_io/f2fs_io.h |  7 +++++++
 2 files changed, 53 insertions(+)

diff --git a/tools/f2fs_io/f2fs_io.c b/tools/f2fs_io/f2fs_io.c
index c977f4d..1a219b8 100644
--- a/tools/f2fs_io/f2fs_io.c
+++ b/tools/f2fs_io/f2fs_io.c
@@ -2509,6 +2509,51 @@ static void do_test_lookup_perf(int argc, char **argv, const struct cmd_desc *cm
 	exit(0);
 }
 
+#define dev_alias_desc "device alias control"
+#define dev_alias_help						\
+"f2fs_io dev_alias [release|reserve|status] [file]\n\n"			\
+"release, reserve or status a range of device alias given the file\n"
+
+static void do_dev_alias(int argc, char **argv, const struct cmd_desc *cmd)
+{
+	int fd, ret;
+
+	if (argc != 3) {
+		fputs("Excess arguments\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	fd = xopen(argv[2], O_RDWR, 0);
+
+	if (!strcmp(argv[1], "reserve")) {
+		ret = ioctl(fd, F2FS_IOC_RESERVE_DEV_ALIAS);
+		if (ret < 0)
+			die_errno("F2FS_IOC_RESERVE_DEV_ALIAS failed");
+		printf("%s device alias range of %s\n", argv[1], argv[2]);
+	} else if (!strcmp(argv[1], "release")) {
+		ret = ioctl(fd, F2FS_IOC_RELEASE_DEV_ALIAS);
+		if (ret < 0)
+			die_errno("F2FS_IOC_RELEASE_DEV_ALIAS failed");
+		printf("%s device alias range of %s\n", argv[1], argv[2]);
+	} else if (!strcmp(argv[1], "status")) {
+		u32 status = 0;
+
+		ret = ioctl(fd, F2FS_IOC_GET_DEV_ALIAS_STATUS, &status);
+		if (ret < 0)
+			die_errno("F2FS_IOC_GET_DEV_ALIAS_STATUS failed");
+
+		printf("device alias status of %s: %s\n", argv[2],
+			status == F2FS_DEV_ALIAS_STATUS_RESERVED ? "reserved" : "released");
+	} else {
+		fputs("Wrong request type\n\n", stderr);
+		fputs(cmd->cmd_help, stderr);
+		exit(1);
+	}
+
+	exit(0);
+}
+
 #define freeze_desc "freeze filesystem"
 #define freeze_help "f2fs_io freeze [directory_path]\n\n"
 
@@ -2603,6 +2648,7 @@ const struct cmd_desc cmd_list[] = {
 	CMD(get_advise),
 	CMD(ioprio),
 	CMD(ftruncate),
+	CMD(dev_alias),
 	CMD(test_create_perf),
 	CMD(test_lookup_perf),
 	CMD(freeze),
diff --git a/tools/f2fs_io/f2fs_io.h b/tools/f2fs_io/f2fs_io.h
index b0d4099..41387f2 100644
--- a/tools/f2fs_io/f2fs_io.h
+++ b/tools/f2fs_io/f2fs_io.h
@@ -96,6 +96,9 @@ typedef u32	__be32;
 #define F2FS_IOC_START_ATOMIC_REPLACE	_IO(F2FS_IOCTL_MAGIC, 25)
 #define F2FS_IOC_GET_DEV_ALIAS_FILE	_IOR(F2FS_IOCTL_MAGIC, 26, __u32)
 #define F2FS_IOC_IO_PRIO		_IOW(F2FS_IOCTL_MAGIC, 27, __u32)
+#define F2FS_IOC_RESERVE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 28)
+#define F2FS_IOC_RELEASE_DEV_ALIAS	_IO(F2FS_IOCTL_MAGIC, 29)
+#define F2FS_IOC_GET_DEV_ALIAS_STATUS	_IOR(F2FS_IOCTL_MAGIC, 30, __u32)
 
 #ifndef FSCRYPT_POLICY_V1
 #define FSCRYPT_POLICY_V1		0
@@ -200,6 +203,10 @@ enum {
 	F2FS_IOPRIO_WRITE = 1,  /* high write priority */
 };
 
+/* for F2FS_IOC_GET_DEV_ALIAS_STATUS */
+#define F2FS_DEV_ALIAS_STATUS_RELEASED	0
+#define F2FS_DEV_ALIAS_STATUS_RESERVED	1
+
 #ifndef FS_IMMUTABLE_FL
 #define FS_IMMUTABLE_FL			0x00000010 /* Immutable file */
 #endif
-- 
2.55.0.571.g244d577d93-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

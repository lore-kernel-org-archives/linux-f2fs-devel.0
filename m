Return-Path: <SRS0=Ksgo=FM=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D31EBC4361B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:15:16 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BA5B23A51
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Dec 2020 08:15:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8BA5B23A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kmY9T-0003wb-Ab; Tue, 08 Dec 2020 08:15:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <robinh3123@gmail.com>) id 1kmY9K-0003vo-GJ
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:15:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=; b=khX/zs+560WIXa0rsgo64ycSNF
 eQ4bG5Ag/GDdtWQlyHZN88R8XbGUUQkv7ynCB+nrdw7y/T+zEIee7+H9NFduR6vW3HSkqTHbotfWq
 SfTzPZsddD5/K04cmUoMHQdznUJXRetY06DXwpfQGb82g/2na69NgNuIa53vcIS9cQNk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=; b=L8rUgbApZkm+Hqo5e57/cW0aSb
 RL2hb0yz8h6wZaN3Sf7iRS3tYvBpSjlKYeI2ehaTRVLSEsAkXIqJF6a8ZR6CAoMXk5wYMfYoeevdR
 hGOJ+m2YBjCg69eTjH1Fd7XM7QuNwrXdYwyt+VjW7e71BOxbOKq6tx0/dqbk1FCjxsAI=;
Received: from mail-pl1-f195.google.com ([209.85.214.195])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kmY9A-0039yn-7b
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Dec 2020 08:15:06 +0000
Received: by mail-pl1-f195.google.com with SMTP id x15so6603162pll.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Dec 2020 00:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
 b=pwpBCMF7Ac589F0MWudfWG4J+an8qdcMMOsk0y9sgAoZarcFOYz8DrfioDizcINnOT
 7pOvQlqWZg8T6tGF+YsQ4xMUkKPEVbbJ4tpd42ELM/9PtVfTTj9l16wvIU/TqaYY0/gA
 mMN1G4EHG9fQTICKsAhVYuBAPaVQEA3lzjTeoCOA9p2IiLkG6FjSiv/1UutWpjwZ8dHO
 X1QLEWdcWCTfc/Yt6B/TUgW24EpKhB9pYv3ysNuXKwFGeemzinErYjz9s+71mnLioFwc
 pmaijRgmPQehqjO+c2UwgoJWBmISmgX2yeYJLwjdevljYvKnOzfKyE84dRrC70Q/bWKA
 dZWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=jirsaBDzo/DYSNUUoXouAzzmgq1svQEaxyCrEMF0PXQ=;
 b=n04J/hnTyhUhL41WbmtOxj01E4JJyOM1EQuRTQuFCXl0IGJpguTXxlfS1WntvO6p47
 mmiXx54I6VbInwhm8FXBQdAS60WAwccDwPwNMV9I6T0Sgn3wqzKcaeSMj+98Gw3OtVow
 WRcqOJ2VU59JkMngwKeWWMnzYnTSwWhK/rLRniARwd09LKWmCevo6ChsWQ0Qa3yKyvO7
 SRzgnp8Ukynz3+O35CnT19bVZv+XhPxUGSigb0zahxB98guBwSBrbHTrf1stE1Ctro1r
 0Xci8Jp97R1+hoXwdwiWkAS8Y2nLTlU80hmCOOPUr8RPcDhxrfkriHLol27EV0pSnE77
 XZsA==
X-Gm-Message-State: AOAM532rkqxbh++ebNCGlgOH1bJW/IvMnxodraRXs2NcNUoOKM8AkwFD
 F6aJkhFdZ2yPOK3Qs8lkl3wloc6FZ6Y=
X-Google-Smtp-Source: ABdhPJwaUxxTgog3OXfOln84McY3YXKOUbbMLj8G6MGMSX3lgwUOYCqXLjNNBRPTyLr5s68ommc2Ag==
X-Received: by 2002:a17:902:d385:b029:da:c6e4:5cab with SMTP id
 e5-20020a170902d385b02900dac6e45cabmr20235431pld.7.1607415290168; 
 Tue, 08 Dec 2020 00:14:50 -0800 (PST)
Received: from robinhsu-p520.ntc.corp.google.com
 ([2401:fa00:fc:202:1ea0:b8ff:fe77:fe45])
 by smtp.gmail.com with ESMTPSA id 19sm2665387pfu.85.2020.12.08.00.14.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Dec 2020 00:14:49 -0800 (PST)
From: Robin Hsu <robinh3123@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, jaegeuk@kernel.org, chao@kernel.org
Date: Tue,  8 Dec 2020 16:13:44 +0800
Message-Id: <20201208081344.652430-4-robinh3123@gmail.com>
X-Mailer: git-send-email 2.29.2.576.ga3fc446d84-goog
In-Reply-To: <20201208081344.652430-1-robinh3123@gmail.com>
References: <20201208081344.652430-1-robinh3123@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1kmY9A-0039yn-7b
Subject: [f2fs-dev] [PATCH 3/3] f2fs-tools:sload.f2fs compress: Fixed
 automake
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
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Robin Hsu <robinhsu@google.com>

Fixed automake for sload.f2fs compression support

./configure automatcally compile in liblzo2 (for sload to support -a LZO)
and liblz4 (for sload to support -a LZ4), whhen the libraries present.

Signed-off-by: Robin Hsu <robinhsu@google.com>
---
 configure.ac     | 12 ++++++++++++
 fsck/Makefile.am |  9 ++++++---
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/configure.ac b/configure.ac
index 1e5619d..01d1a05 100644
--- a/configure.ac
+++ b/configure.ac
@@ -52,6 +52,18 @@ AC_PATH_PROG([LDCONFIG], [ldconfig],
        [$PATH:/sbin])
 
 # Checks for libraries.
+AC_CHECK_LIB([lzo2], [main],
+	[AC_SUBST([liblzo2_LIBS], ["-llzo2"])
+		AC_DEFINE([HAVE_LIBLZO2], [1],
+		[Define if you have liblzo2])
+	], [], [])
+
+AC_CHECK_LIB([lz4], [main],
+	[AC_SUBST([liblz4_LIBS], ["-llz4"])
+		AC_DEFINE([HAVE_LIBLZ4], [1],
+		[Define if you have liblz4])
+	], [], [])
+
 PKG_CHECK_MODULES([libuuid], [uuid])
 
 AS_IF([test "x$with_selinux" != "xno"],
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index 1fc7310..74bc4b8 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -3,12 +3,15 @@
 AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall
 sbin_PROGRAMS = fsck.f2fs
-noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h quotaio_tree.h quotaio_v2.h xattr.h
+noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h \
+		quotaio_tree.h quotaio_v2.h xattr.h compress_wrapper.h
 include_HEADERS = $(top_srcdir)/include/quota.h
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c \
-		node.c segment.c dir.c sload.c xattr.c \
+		node.c segment.c dir.c sload.c xattr.c compress_wrapper.c \
 		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c
-fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} $(top_builddir)/lib/libf2fs.la
+fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} \
+	${liblzo2_LIBS} ${liblz4_LIBS} \
+	$(top_builddir)/lib/libf2fs.la
 
 install-data-hook:
 	ln -sf fsck.f2fs $(DESTDIR)/$(sbindir)/dump.f2fs
-- 
2.29.2.576.ga3fc446d84-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

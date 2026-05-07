Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0ED23CD3442
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 11:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1GBntzsjR0aNs7fdnF8PpyFbcGD2k2AM2/YAqdg/ZN0=; b=Jxx5TY8GbyS4vCSg2/IoJm5iIG
	5OwuD59F2mA9lb/HHz5KL0rK8sPSascz1uqrqcG17UWZMtqTK0JukvlDeukASqgo3ZitEZw8uUmFd
	C2b5xH6c3RXQ9april3/wWZ429Wz0IPB+N3iAxawxV9ZFwegQ5UIHisIBR2APjn5hwnk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKxAe-0005uG-64;
	Thu, 07 May 2026 11:45:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1wKxAd-0005uA-Bl
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6i9HXOjniT5m+MLDEfWhmgk5ZaEGVCk9oS0kHc0ep8g=; b=Ax+0Vp04Jsih6+OHdtspSydjMQ
 2XqcxOQwzm5Wqi7LhkUONOeZqFTyfwacS61IZwoBzDBLLRvX8T1D5uWGa/p90PTdM3RxVmphGfvKv
 Mp7w5JB4KlGpCzXATzi2zSi4G7JlQdtBSqi0R44geFm7kT2QjP+YJdVM2F9r4SqbpBtw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6i9HXOjniT5m+MLDEfWhmgk5ZaEGVCk9oS0kHc0ep8g=; b=kI9wq9c7A4bI+YU4B6pJZk6M8n
 GHKJwiMJg0Eo3Np4Jaj6k5qIZ3CWxXQdd1+lWNV823Cd/10OwjL2O1bamjxQIQlx4RKeaNyCASVqx
 1VNpFyw389tkS4xpAhLMk0SROMHlG89ic/UmL6h4AnedP2McGfUbEhqyvmF7sc+eZ/5A=;
Received: from r3-20.sinamail.sina.com.cn ([202.108.3.20])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKxAZ-00038p-8R for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 11:45:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1778154331; bh=6i9HXOjniT5m+MLDEfWhmgk5ZaEGVCk9oS0kHc0ep8g=;
 h=From:Subject:Date:Message-ID;
 b=iMZ7ishU3RXtxe8JdL8YN0CdRHYAQMdyR1vrIUIJID1ZWOVhsjM6vGtk61Y6rqD++
 y4iKG9pRzKEmTJNJSor3sCzbpxIJM/zMbbhEjtIbNN4cMKMrHb/NmCpE13dD7H9Ddm
 lPMVtoNXO14xwLKTlaCT5kSbPnksfRH+e23iXNNA=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.32) with ESMTP
 id 69FC7B44000045CE; Thu, 7 May 2026 19:45:23 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 779194456687
X-SMAIL-UIID: 9B9FA294F10E4B9091B4D5FDA3501A02-20260507-194523-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Thu,  7 May 2026 19:44:36 +0800
Message-ID: <20260507114434.1353908-6-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260507114434.1353908-2-monty_pavel@sina.com>
References: <20260507114434.1353908-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1wKxAZ-00038p-8R
Subject: [f2fs-dev] [RFC PATCH 2/3] build: add inline extent build support
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

Add build system configuration for inline extent feature:
- Add --disable-inline-extent configure option (enabled by default)
- Add iextent.c and iextent.h to fsck build sources
- Define HAVE_INLINE_EXTENT macro when feature is enabled

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 configure.ac     | 10 ++++++++++
 fsck/Makefile.am |  4 ++--
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/configure.ac b/configure.ac
index 4d91605f..0d140b45 100644
--- a/configure.ac
+++ b/configure.ac
@@ -62,6 +62,16 @@ AC_ARG_WITH([lz4],
 	[],
 	[with_lz4=check])
 
+AC_ARG_ENABLE([inline-extent],
+	[AS_HELP_STRING([--disable-inline-extent],
+	  [Disable inline extent support (enabled by default)])],
+	[],
+	[enable_inline_extent=yes])
+
+AS_IF([test "x$enable_inline_extent" = "xyes"],
+	[AC_DEFINE([HAVE_INLINE_EXTENT], [1],
+		[Define if inline extent support is enabled])])
+
 # Checks for programs.
 AC_PROG_CC
 AM_PROG_AR
diff --git a/fsck/Makefile.am b/fsck/Makefile.am
index f0d7f872..96945388 100644
--- a/fsck/Makefile.am
+++ b/fsck/Makefile.am
@@ -4,12 +4,12 @@ AM_CPPFLAGS = ${libuuid_CFLAGS} -I$(top_srcdir)/include
 AM_CFLAGS = -Wall -D_FILE_OFFSET_BITS=64
 sbin_PROGRAMS = fsck.f2fs
 noinst_HEADERS = common.h dict.h dqblk_v2.h f2fs.h fsck.h node.h quotaio.h \
-		quotaio_tree.h quotaio_v2.h xattr.h compress.h inject.h
+		quotaio_tree.h quotaio_v2.h xattr.h compress.h inject.h iextent.h
 include_HEADERS = $(top_srcdir)/include/quota.h
 fsck_f2fs_SOURCES = main.c fsck.c dump.c mount.c defrag.c resize.c \
 		node.c segment.c dir.c sload.c xattr.c compress.c \
 		dict.c mkquota.c quotaio.c quotaio_tree.c quotaio_v2.c \
-		inject.c
+		inject.c iextent.c
 fsck_f2fs_LDADD = ${libselinux_LIBS} ${libuuid_LIBS} \
 	${liblzo2_LIBS} ${liblz4_LIBS} ${libwinpthread_LIBS} \
 	$(top_builddir)/lib/libf2fs.la
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

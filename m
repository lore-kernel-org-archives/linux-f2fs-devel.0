Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2E0CCF2C9
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 18 Oct 2026 16:51:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:To:Date:Sender:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=SMn+7nIPUGyjLlUnVIimO/fT2YXsJNEGe6Xnxnl2O0E=; b=hQD16TUyvxfFh8hV5m1B6dVCxL
	eWa6U+I0shTuLo9NYEPVnjLs4qCsWbMvF7F8/720husKro3HJCjbLju/ht+NHl1z5xXwAVGXJIxyb
	wdhxB6V8pGLxRlEDh9tq1/8/YtnGpvUffb3ZAxCbplMoEn8wS1FJ0HYVTMR2A6jvmdkE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIU6U-0004P4-3J;
	Sun, 18 Oct 2026 16:51:19 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <geldot@protonmail.com>) id 1xIU6T-0004Oy-8q
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :Message-ID:Subject:From:To:Date:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cg0n3P77ZaWIUHaWWUaJx8j/RK7RqVdBtwo5+Ug/0gc=; b=fMkaXz4x2FzBMOP4JNR714vHLz
 4exDGWAUMDJ7xZ2FHUjHmvpFp/hWTGF5A0zgBp0x6PDwvKS8K6O+YlWHx75wcLtjUVgS3xQIsv+WK
 eoApbn9wJ8kr6xeWkEyveAJi+oLdZgkSvZj+rOszNItYdYOZULedJm0Ebw3Ciwr9A5Zc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Subject:
 From:To:Date:Sender:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=cg0n3P77ZaWIUHaWWUaJx8j/RK7RqVdBtwo5+Ug/0gc=; b=V
 OgDtuWJiCxc6mFfhxx3zb+xcoT7K0mKaZ+8RYeRwZuu9fZbx41S1meZQrzf1K8+UJwtYNpKEDfcvH
 SmuQtaJzhoTffWvgh74fn17c3z1mJ1h+m1mX9jhNJKfafd57Y25CfMhpGfmLI4ScyzIkgcGyNCfSW
 C9xygvNfX/xLJmCA=;
Received: from mail-24428.protonmail.ch ([109.224.244.28])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIU6Q-0003Hg-6H for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 18 Oct 2026 16:51:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
 s=protonmail3; t=1792342271; x=1792601471;
 bh=cg0n3P77ZaWIUHaWWUaJx8j/RK7RqVdBtwo5+Ug/0gc=;
 h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
 b=R5PYyDoVXrIfiZi1F7LW55Awm3Z7Wyarlz86cyseDBlTpyPQ0us4TgTRnd9PHyiD5
 ipczqahvAybVdeB4O3OEfIrD4+KdgIC3HH+QR2TUd0GIb67OH2sH9HMjZkeaMtQ2bp
 uTe+jHldb0YZIkQ2meoe+IurjZAeexTXpNuT33vkWwd+sfRxJwoi4bqzANWkL//yvc
 B1WmrijinCNEp98aVDWa33Rj+DqG+wDZSmhKnT74RXp/3T52186ls5CWmg1NJp5PnG
 CDbqDKfKmDZGzXMgOcCwkZR2oVrFWV/5+a/ZxMhgLIVYNW/L22mJRyDWJxZ2ufY4R6
 TbkCqYV/TUzdg==
Date: Sun, 18 Oct 2026 16:51:05 +0000
To: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Message-ID: <7ePQxiIqVsZ48lBREK1jGvNluYxkWGYQMnDo4d2DSQzmP1UkP8F2xR3E3oINcM0hV4Q8tXC33GyMjSRwzF43N2IheOyPI_N0GYC0bYmGAb0=@protonmail.com>
Feedback-ID: 219410145:user:proton
X-Pm-Message-ID: a06719363642e36eb56ba2cfcbde36905f5fe6ba
MIME-Version: 1.0
X-Headers-End: 1xIU6Q-0003Hg-6H
Subject: [f2fs-dev] [PATCH] f2fs-tools: avoid ABI mismatch in build variants
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
From: Gary Dotzler via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Gary Dotzler <geldot@protonmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

libf2fs, fsck.f2fs, and other library consumers can be built with
different selinux settings.

Make the f2fs_configuration struct layout and ABI independent of feature
detection to avoid memory corruption when the consumer is built with
different options than the shared library.

A compatible selinux_opt fallback is supplied to retain source
compatibility. The only known user of these fields is the sload.f2fs
subcommand of fsck.f2fs.

Also add a compile-time assertion to guard against future regressions.

Signed-off-by: Gary Dotzler <geldot@protonmail.com>
---
 include/f2fs_fs.h | 25 ++++++++++++++++++-------
 1 file changed, 18 insertions(+), 7 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4225ffe..ccdeccd 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -75,9 +75,26 @@ enum rw_hint {
 };
 #endif
 
+#ifndef static_assert
+#define static_assert _Static_assert
+#endif
+
+struct f2fs_selinux_opt {
+	int type;
+	const char *value;
+};
+
 #ifdef HAVE_LIBSELINUX
 #include <selinux/selinux.h>
 #include <selinux/label.h>
+
+static_assert(sizeof(struct f2fs_selinux_opt) == sizeof(struct selinux_opt) &&
+		offsetof(struct f2fs_selinux_opt, value) == offsetof(struct selinux_opt, value),
+		"struct selinux_opt ABI mismatch");
+
+typedef struct selinux_opt f2fs_selinux_opt_t;
+#else
+typedef struct f2fs_selinux_opt f2fs_selinux_opt_t;
 #endif
 
 #ifdef UNUSED
@@ -91,10 +108,6 @@ enum rw_hint {
 # define UNUSED(x) x
 #endif
 
-#ifndef static_assert
-#define static_assert _Static_assert
-#endif
-
 #ifdef HAVE_SYS_MOUNT_H
 #include <sys/mount.h>
 #endif
@@ -1625,10 +1638,8 @@ struct f2fs_configuration {
 	char *mount_point;
 	char *target_out_dir;
 	char *fs_config_file;
-#ifdef HAVE_LIBSELINUX
-	struct selinux_opt seopt_file[8];
+	f2fs_selinux_opt_t seopt_file[8];
 	int nr_opt;
-#endif
 
 	/* dump parameters */
 	int preserve_perms;
-- 
2.56.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

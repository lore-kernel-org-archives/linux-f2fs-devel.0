Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CAE9CC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 26 May 2022 00:21:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nu1GF-0000Y6-Cd; Thu, 26 May 2022 00:21:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1nu1GE-0000Y0-Ld
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 May 2022 00:21:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XBq/MkjHiiSUU0Iai0PnDz/SiQzhnL5QaGDn1tkhE04=; b=J4TtDMpvSbQVfAftB1KxOrv8o/
 JV7jQ3BjZrRlP9TD4Bgb6r3FLWKKtO4+0sACKQKtx5Y7DWNiwJjqKSnu7rmmm4Lgq8v5c64IN/LPR
 3w/pstJ4O5n6Mu3ujQi5v5zGrkleb2d+sQc0ojdIWAajwIqVe9pdYJNXK11OxFxbKX0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=XBq/MkjHiiSUU0Iai0PnDz/SiQzhnL5QaGDn1tkhE04=; b=B
 cRrJGMSWdoUl2WMywQQoz8IhV9Rec+NeNdylHXpnXQ0vKTsjMt0STR2MdT25yTQh21lPcHYISYKWM
 Jr6wFZyuGTYd+DS2HiZQmH+M22xlkFdoNVeOQaFoIjVII5JGDDlexoiJM47Yw0/9Ti/82gsP34Ghi
 m2QiGytkpujqK1OA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nu1GB-000pi1-R8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 26 May 2022 00:21:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7821D6164F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 26 May 2022 00:21:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA308C34114;
 Thu, 26 May 2022 00:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1653524505;
 bh=fSWCwR6wF3rhWh0bFYiuRB+AA3YVbYBjua+PG8qSFKY=;
 h=From:To:Cc:Subject:Date:From;
 b=TJWhsqI9I1wmrMmJGI6jzueCxlorKU2fUNueXmwdQ4nUyAKQZIErg6DEdevz3qbQh
 ZMzxJpp+zegmcvgaNxT5czgBxTNkOgE8Ht5SmA+b0mg97+P261BQzxD7fXxLWy4NLK
 GwvUiPK7wPHwoKW1bdTrL9imNXGe/ic4seBC2a9nfguzk7l45rvHE5301gIEjXARtL
 KQODaIX3fbp/rgffaGTmUu9Gg/U/Ou7jdNHQN7sHNRX3Hq3VoM4zoZeKxVT3qJzqgd
 TKZn37cnBBpvvLf+weqb8cCVHROB0rzBsOPtbPs+Z8UhzaZxJqdZ3bXcFVCLXtfMRO
 G72lqKmKws7vA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Wed, 25 May 2022 17:21:42 -0700
Message-Id: <20220526002143.842643-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.36.1.124.g0e6072fb45-goog
MIME-Version: 1.0
X-Headers-End: 1nu1GB-000pi1-R8
Subject: [f2fs-dev] [PATCH] Check fallthrough in mount.h for Mac
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX11.3.sdk/usr/include/os/base.h:128:23: error: missing ')' after 'do'
                      ^~~~~~~~~~~
external/f2fs-tools/include/f2fs_fs.h:81:24: note: expanded from macro 'fallthrough'
                    ~~ ^
/Applications/Xcode.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX11.3.sdk/usr/include/os/base.h:128:22: note: to match this '('

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 include/f2fs_fs.h | 6 ++++++
 lib/libf2fs.c     | 3 ---
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index ad2798cf388c..21a7e70d952d 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -77,11 +77,17 @@
 #define static_assert _Static_assert
 #endif
 
+#ifdef HAVE_SYS_MOUNT_H
+#include <sys/mount.h>
+#endif
+
+#ifndef fallthrough
 #ifdef __clang__
 #define fallthrough do {} while (0) /* fall through */
 #else
 #define fallthrough __attribute__((__fallthrough__))
 #endif
+#endif
 
 #ifdef _WIN32
 #undef HAVE_LINUX_TYPES_H
diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 36b8c25980ab..ecaa2e9d1ad5 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -22,9 +22,6 @@
 #endif
 #include <time.h>
 #include <sys/stat.h>
-#ifdef HAVE_SYS_MOUNT_H
-#include <sys/mount.h>
-#endif
 #ifdef HAVE_SYS_IOCTL_H
 #include <sys/ioctl.h>
 #endif
-- 
2.36.1.124.g0e6072fb45-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=/SzK=74=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8D5C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2020 18:08:54 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92D9C2080D;
	Mon, 15 Jun 2020 18:08:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="XTMSTDGd";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="gpEP0P6m";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="X4afVY61"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92D9C2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jktXS-0005OJ-3g; Mon, 15 Jun 2020 18:08:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1jktXR-0005OC-LA
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 18:08:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SH10DJC/iJaaUkdDhrWcwQTM+di964rf5mrBL63GDaU=; b=XTMSTDGdWp+t6wRXpu78SExj7B
 KlxMARSCN1Fpa5EZ8TGO+HinsXIx2dVje/tzZvSV+xS/zTcm89lX/fCVCX0+j7z0RV62Q1udKNswm
 TRRNwhg/LOUSMpZgMeWyImcVIsA3QPjZo5snKYtj4SNYtVIdSBAx9jTXTp6q1V8TYWuE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SH10DJC/iJaaUkdDhrWcwQTM+di964rf5mrBL63GDaU=; b=g
 pEP0P6mJKZrGVALmR5eve+7VYB15Z3QvW0SwUaxyMz2X83mLpWK44XImyhffK77zY5nRPFBWYP613
 rYIShYFkGLhkqbzKH2Xy2sBFjYXSfxvCUVt3w6oxLVx8AOqDHX3j3NTOeo7CbGabbPz54oTIH4RCQ
 bCCohjoazvo3ikXM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jktXN-006sUe-O8
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 15 Jun 2020 18:08:53 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 457AB2080D;
 Mon, 15 Jun 2020 18:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1592244524;
 bh=H6ByfuUMaJAM/lM6rgniPUUj+UozvovESjKF5RPg+1s=;
 h=From:To:Cc:Subject:Date:From;
 b=X4afVY61GHznG2tt3RcSqPT2Sc9JkaRZtytIZXm36KQO0rTEBh5aeq+0GZ7D8Bm1a
 AH+WW3PecU3/SlRcNpaGxkyq/IokTGTDb9iK2Il27hqCEkNySz6pLa+Zp+/FK0IV5D
 Xzsd+ZLMpE1mMMnkW56DhQgRJ6LqVUby/cLNsW7g=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 15 Jun 2020 11:08:40 -0700
Message-Id: <20200615180843.153299-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.27.0.290.gba653c62da-goog
MIME-Version: 1.0
X-Headers-End: 1jktXN-006sUe-O8
Subject: [f2fs-dev] [PATCH 1/4] lib: fix include path for uuid.h
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Rolf Eike Beer <eb@emlix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Rolf Eike Beer <eb@emlix.com>

$ pkg-config --cflags uuid
-I/usr/include/uuid

The "uuid/" directory is actually part of the include path. This usually still
works because most people have the path one level up in their default include
path.

Signed-off-by: Rolf Eike Beer <eb@emlix.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 mkfs/f2fs_format.c      | 2 +-
 mkfs/f2fs_format_main.c | 2 +-
 tools/f2fscrypt.c       | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mkfs/f2fs_format.c b/mkfs/f2fs_format.c
index 44575e0..4999cac 100644
--- a/mkfs/f2fs_format.c
+++ b/mkfs/f2fs_format.c
@@ -18,7 +18,7 @@
 #include <sys/mount.h>
 #endif
 #include <time.h>
-#include <uuid/uuid.h>
+#include <uuid.h>
 
 #include "f2fs_fs.h"
 #include "quota.h"
diff --git a/mkfs/f2fs_format_main.c b/mkfs/f2fs_format_main.c
index 204a410..282c94e 100644
--- a/mkfs/f2fs_format_main.c
+++ b/mkfs/f2fs_format_main.c
@@ -18,7 +18,7 @@
 #include <sys/mount.h>
 #endif
 #include <time.h>
-#include <uuid/uuid.h>
+#include <uuid.h>
 #include <errno.h>
 
 #include "config.h"
diff --git a/tools/f2fscrypt.c b/tools/f2fscrypt.c
index fe3e0ff..d5bc3c5 100644
--- a/tools/f2fscrypt.c
+++ b/tools/f2fscrypt.c
@@ -43,7 +43,7 @@
 #ifdef __KERNEL__
 #include <linux/fs.h>
 #endif
-#include <uuid/uuid.h>
+#include <uuid.h>
 
 #if !defined(HAVE_ADD_KEY) || !defined(HAVE_KEYCTL)
 #include <sys/syscall.h>
-- 
2.27.0.290.gba653c62da-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

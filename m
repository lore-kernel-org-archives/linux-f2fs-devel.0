Return-Path: <SRS0=EZAZ=YA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DC96C47404
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Oct 2019 16:33:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC7242067B;
	Mon,  7 Oct 2019 16:33:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Oq6f/uVM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="jdX0Wxrw";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="XvAWm+cl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC7242067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iHVwx-0004ux-1J; Mon, 07 Oct 2019 16:33:31 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1iHVww-0004uh-5O
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Oct 2019 16:33:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pidOQNmt/SzMDJY2Qis9cUXqNZjdwqsP5Bmdic+sAE4=; b=Oq6f/uVMel4fu88TWHA16b2pGh
 gtvtlp5IxBBb3gABPmi6WhePs5rMIN9jW44unhUdIwRy/CN+vpgXnT8SA3hNn9XjskPkpsPy2/15L
 qL6lip5ALw0/XqkYa+pFkZzq7IFFcp7VyYbtw5Lx+NfqiMfNPASwjjDpfr/f5GR+Joso=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=pidOQNmt/SzMDJY2Qis9cUXqNZjdwqsP5Bmdic+sAE4=; b=j
 dX0Wxrw3QX2/DCTMUQ+Z+JxkveDCTq/kcnWaH/GI17CUgCArl9j2aL5RQuWX5AFckEF7ZieHUZ82B
 avNSTWGFlqCz/EQZH65r/EWY6AZmOqd4VS/VQV0iejRuq0tbzp6+H7IBXqigXvGnLr2oYRu4LVBAm
 PnemtWDpA9VQQJII=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iHVwu-002FX2-VB
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 07 Oct 2019 16:33:29 +0000
Received: from localhost (unknown [104.132.0.81])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 6DE2D2067B;
 Mon,  7 Oct 2019 16:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1570465997;
 bh=QZTjHM3K+gFPiNS7TLf/Phu30rxxJCGIp05Ir+bSqQU=;
 h=From:To:Cc:Subject:Date:From;
 b=XvAWm+clEN0XsMXPbimXYiZFcySsGwgxiW4KBa7N9Pa9V2tD1EhP6G47lLhACE2Wh
 3bFBj4sH79fOWF9dNfPZ13sedzEXq64A3c/HZZZEicdBifhtHKmTPUjk8ik8uWAlWJ
 /JnmAHZ3DoaWayNNgv6J2rP26vFInGfxQP+EHH0k=
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon,  7 Oct 2019 09:33:15 -0700
Message-Id: <20191007163315.84634-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.19.0.605.g01d371f741-goog
MIME-Version: 1.0
X-Headers-End: 1iHVwu-002FX2-VB
Subject: [f2fs-dev] [PATCH] tools/fibmap: fix build error
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

fibmap.c:28:10: fatal error: 'sys/sysmacros.h' file not found
         ^~~~~~~~~~~~~~~~~
1 error generated.
make[3]: *** [fibmap.o] Error 1
make[3]: *** Waiting for unfinished jobs....

Fixes: ce64ea0815bf ("f2fs-tools: Add support for Casefolding")
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 tools/fibmap.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/fibmap.c b/tools/fibmap.c
index 2b3c40f..9e96cb6 100644
--- a/tools/fibmap.c
+++ b/tools/fibmap.c
@@ -25,7 +25,6 @@
 #include <sys/types.h>
 #include <sys/ioctl.h>
 #include <sys/stat.h>
-#include <sys/sysmacros.h>
 #ifdef HAVE_SYS_SYSMACROS_H
 #include <sys/sysmacros.h>
 #endif
-- 
2.19.0.605.g01d371f741-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

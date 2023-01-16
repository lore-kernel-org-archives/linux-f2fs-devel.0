Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE6CFC54EBE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Jan 2023 23:37:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pHZ2J-0006HF-Kl;
	Mon, 16 Jan 2023 23:37:06 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1pHZ2I-0006H9-BN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 23:37:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7rT9tUS0E/itlCjILKPMZCHB0wDyABa6ECn/BdfYf70=; b=fwxp3gRpEwAA+VOFxVNz6ThKb4
 EVYFSeB42UKPJ71JfxEE1HHoaEasN2tUtrF4wTlyNquZy708ePXmUp7xRLFS2aplgpPtBEHpXCKk+
 JQQQaM1wRsXPMgkniSSspr5/W1nHOFl3XQTOoUxeL0uoR2OvWg+8UGicREbAGm+p0oyc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7rT9tUS0E/itlCjILKPMZCHB0wDyABa6ECn/BdfYf70=; b=O
 AnYe24xhPZDMG3J0VkU9EHaOO1oiRvNKQB1jtO2iaTm2xUJXtrTJfJP9nMWnfbJzLRzcTOHW5Ac00
 HJEoBtwZSxrXBIFnpBARTIOJj8D6X1L4Q/XOsLDTzX69kp5IxTguKgnKCrwADpTg26N9CfYOCn6R8
 ka5rM2E1gSk6gENI=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pHZ2G-0008GF-Pw for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Jan 2023 23:37:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4CC5FB810B2;
 Mon, 16 Jan 2023 23:36:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA94AC433D2;
 Mon, 16 Jan 2023 23:36:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673912214;
 bh=N8IFuauoFBlRBCPllH9x+bpTPBvYcnFCohv+H6rAcmg=;
 h=From:To:Cc:Subject:Date:From;
 b=i1lWyLdD4VO3VFps3DuBp+8Z/vTP0S0L8hquBQo1OzEKM5RiCVb03zyaa6uMzedTX
 iO+PY4M95I0DpX1uZh+drGIwSpqXeJyzFYra2/mnUauRT60MHI/Tl4IAw4Hq5d5spx
 /etztWrnI3tYB4Y8amWjhYreLBTGZShe8EpVt8Pt6UZuUZy2/40MiPl/Tl+sw3XBdD
 d6CD7VhJhG71U4IpdKuFFf7O7hFCCl/tzq3md/HZb2ddPMbmDav+jTk+AcqqDth0tG
 97Q+xSZxDmiC3jSQmCDCuO+RDDk2yRr3WSprBBoXlSGuvwo4hDGAgM4yxUmFrG5A0/
 yxaqOQjeS7BpQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Mon, 16 Jan 2023 15:34:24 -0800
Message-Id: <20230116233424.65657-1-ebiggers@kernel.org>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
X-Headers-End: 1pHZ2G-0008GF-Pw
Subject: [f2fs-dev] [PATCH] MAINTAINERS: update fscrypt git repo
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
Cc: linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-btrfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Eric Biggers <ebiggers@google.com>

fscrypt.git is being renamed to linux.git, so update MAINTAINERS
accordingly.  (The reasons for the rename are to match what I'm doing
for the new fsverity repo, which also involves the branch names changing
to be clearer; and to avoid ambiguity with userspace tools.)

As long as I'm updating the fscrypt MAINTAINERS entry anyway, also:

- Move my name to the top, so that people bother me first if they just
  choose the first person.  (In practice I'm the primary maintainer, and
  Ted and Jaegeuk are backups.)

- Remove an unnecessary wildcard.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 42fc47c6edfd7..8d0ee9f17b4d4 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8468,16 +8468,16 @@ F:	fs/fscache/
 F:	include/linux/fscache*.h
 
 FSCRYPT: FILE SYSTEM LEVEL ENCRYPTION SUPPORT
+M:	Eric Biggers <ebiggers@kernel.org>
 M:	Theodore Y. Ts'o <tytso@mit.edu>
 M:	Jaegeuk Kim <jaegeuk@kernel.org>
-M:	Eric Biggers <ebiggers@kernel.org>
 L:	linux-fscrypt@vger.kernel.org
 S:	Supported
 Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
-T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git
+T:	git https://git.kernel.org/pub/scm/fs/fscrypt/linux.git
 F:	Documentation/filesystems/fscrypt.rst
 F:	fs/crypto/
-F:	include/linux/fscrypt*.h
+F:	include/linux/fscrypt.h
 F:	include/uapi/linux/fscrypt.h
 
 FSI SUBSYSTEM

base-commit: 5dc4c995db9eb45f6373a956eb1f69460e69e6d4
-- 
2.39.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

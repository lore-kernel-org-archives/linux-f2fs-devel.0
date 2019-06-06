Return-Path: <SRS0=oA2u=UF=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC779C28EB3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Jun 2019 15:54:15 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A51A3207E0;
	Thu,  6 Jun 2019 15:54:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Lwkb9Fow";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="TJI5VGnB";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXIPkzUf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A51A3207E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1hYuiV-00084S-2I; Thu, 06 Jun 2019 15:54:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <ebiggers@kernel.org>) id 1hYuiT-00083x-Ja
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 15:54:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Nfu491IXmCX3Upt2ZIsrvuYltrPZQa9YLbqRA8ZDi4A=; b=Lwkb9FowKeNLqsHQ0krWT3BXLI
 OOnuNf0KhqtWzzhLJ/7hbhFtY/piviJD0CWdfDkntqe2z52HqKRbM8XhhtM3kDnd6hK13eDtuMUpV
 xgDpXuOYeeLEls9Z27HDGvctR9sYy06f+lVee8xQGCs3f8LoalPAj7PVJZwN5Cm0L8bs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Nfu491IXmCX3Upt2ZIsrvuYltrPZQa9YLbqRA8ZDi4A=; b=TJI5VGnBqh5Zojs/ayBRqLeiwq
 3eplyIU0AHJ8bnGhyoSCDVCQiFYbOEOJvl8zpSu6LreIuoYhHJrNZZSRAnUbtc9Nlf3/bUG8/A33n
 KxKI9KflDZjbqYU3IpT3aoZDkZIHmksRo5EFw4URLEcRc3t6yqCTmmAzzcjPEs7JcfdM=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1hYuiQ-00DZjR-GT
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Jun 2019 15:54:13 +0000
Received: from sol.localdomain (c-24-5-143-220.hsd1.ca.comcast.net
 [24.5.143.220])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B019F20868;
 Thu,  6 Jun 2019 15:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1559836444;
 bh=uj7OhOWNAd4Pcxs6nLhO9mFRMaxtTmlWgngVbC8runE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=bXIPkzUfqDRKOSTk0dQNkKJOMbvMLZDYl9MBexWFxlr62YVXk9/stxK01xg9RS7bC
 OfNgfQWcb5PGe0C9F7MuL3U8kybF4ykAvcr4M08oybWgQu4MQip0PtkQXO5nvGJkkJ
 Aj8g+E/KT5cfZgrWNGUvcY/CqaT76HuXp6iZ2Uhw=
From: Eric Biggers <ebiggers@kernel.org>
To: linux-fscrypt@vger.kernel.org
Date: Thu,  6 Jun 2019 08:51:51 -0700
Message-Id: <20190606155205.2872-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190606155205.2872-1-ebiggers@kernel.org>
References: <20190606155205.2872-1-ebiggers@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1hYuiQ-00DZjR-GT
Subject: [f2fs-dev] [PATCH v4 02/16] fs-verity: add MAINTAINERS file entry
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
Cc: "Theodore Y . Ts'o" <tytso@mit.edu>,
 "Darrick J . Wong" <darrick.wong@oracle.com>, linux-api@vger.kernel.org,
 Dave Chinner <david@fromorbit.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-fsdevel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-integrity@vger.kernel.org, linux-ext4@vger.kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>, Christoph Hellwig <hch@lst.de>,
 Victor Hsieh <victorhsieh@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
Message-ID: <20190606155151.vblU7ZWpj4F-oNdwWJQAdehVadTffxIYvLHbJFnZHV8@z>

From: Eric Biggers <ebiggers@google.com>

fs-verity will be jointly maintained by Eric Biggers and Theodore Ts'o.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 MAINTAINERS | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a6954776a37e..655065116f92 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -6505,6 +6505,18 @@ S:	Maintained
 F:	fs/notify/
 F:	include/linux/fsnotify*.h
 
+FSVERITY: READ-ONLY FILE-BASED AUTHENTICITY PROTECTION
+M:	Eric Biggers <ebiggers@kernel.org>
+M:	Theodore Y. Ts'o <tytso@mit.edu>
+L:	linux-fscrypt@vger.kernel.org
+Q:	https://patchwork.kernel.org/project/linux-fscrypt/list/
+T:	git git://git.kernel.org/pub/scm/fs/fscrypt/fscrypt.git fsverity
+S:	Supported
+F:	fs/verity/
+F:	include/linux/fsverity.h
+F:	include/uapi/linux/fsverity.h
+F:	Documentation/filesystems/fsverity.rst
+
 FUJITSU LAPTOP EXTRAS
 M:	Jonathan Woithe <jwoithe@just42.net>
 L:	platform-driver-x86@vger.kernel.org
-- 
2.21.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

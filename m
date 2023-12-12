Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91CB6C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Dec 2023 01:01:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rCr9l-0001mP-7T;
	Tue, 12 Dec 2023 01:01:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rCr9j-0001mJ-QT
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Dec 2023 01:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JXe05Sl3O+ZzIJzfqXuONfQXSZHZdpaMsibZgb1CRvY=; b=AMGMw0HncDHM/brtUZ5CXIkEvZ
 1a/ZX82ysOIGvcnAP/ouJNRTkNoG+4RqDKsRR80lQadp+kZgKhkZAFZXR0h2AH9ji2d8Px5l3+X3c
 kcbPVjtqPdmsgyJu6WTsnROe68Zg/LwDTXcs1kZw2noog7iXGenqROJ+yrHPuhuxkyrU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=JXe05Sl3O+ZzIJzfqXuONfQXSZHZdpaMsibZgb1CRvY=; b=b
 MYIcS9naECvBeqoqHMOQZ7Xn8bmMqoh3svz/BaOewfLjdXEKhFYM7oxA7SefYU5Mpu8BXmXrsPaEk
 MfKCX69Keuyec/ehBH7/pn7bGTd6lBJkRQLEZLGRAikBcg8McCUh+vha8HcZB7OkmYUvnqSba2Xac
 gr3BSTtBciY5Zgbo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rCr9i-00063j-69 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 Dec 2023 01:01:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id E480E615A0;
 Tue, 12 Dec 2023 01:01:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA6BFC433D9;
 Tue, 12 Dec 2023 01:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702342894;
 bh=DrRCtSU9Med/4mNPeKjZBCg4NO0v5bfD2LI1x2498Ro=;
 h=From:To:Cc:Subject:Date:From;
 b=I2q6tOdUhiF2BJ+rjT9VpBsT14FW6c23EoiwvIA2L1t1MLNRdzr6H0s9UBVj4T7rB
 pY612ksKEzLFn+MUp5S0qyGRPpZGgonHLD53GTvgMXkg1z/3CsySAnxdp7fcO694fQ
 nRhWpUBP5x8xwn9kzCDpLlykJ2SIuub7ReJE+ts9wkcUzLuLIt4N5SV+FgsIjgHYGl
 /PRViobbNd6NMXEEBbp/BM27dzDUUvRL15qVetouptMuiZfL+pwubEPQ2zCqOiftg7
 A0Ro1AXWSgz28JivX75bUnaBndUAWKCFmpLn4X0OuaOJbwOYhNNTpxwvbI1UsTP2Zx
 8BdRdxWNGPxDA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 12 Dec 2023 09:01:20 +0800
Message-Id: <20231212010120.252763-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rCr9i-00063j-69
Subject: [f2fs-dev] [PATCH v2 4/6] f2fs: don't set FI_PREALLOCATED_ALL for
 partial write
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
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

In f2fs_preallocate_blocks(), if it is partial write in 4KB, it's not
necessary to call f2fs_map_blocks() and set FI_PREALLOCATED_ALL flag.

Cc: Eric Biggers <ebiggers@google.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- clean up codes
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 79d5b64c109c..026d05a7edd8 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4567,7 +4567,8 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	if (map.m_len > map.m_lblk)
 		map.m_len -= map.m_lblk;
 	else
-		map.m_len = 0;
+		return 0;
+
 	map.m_may_create = true;
 	if (dio) {
 		map.m_seg_type = f2fs_rw_hint_to_seg_type(inode->i_write_hint);
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

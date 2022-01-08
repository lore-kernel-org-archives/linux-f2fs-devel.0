Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF6F5C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  8 Jan 2022 16:46:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n6Eqy-00052l-TR; Sat, 08 Jan 2022 16:46:04 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1n6Eqx-00052e-7l
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Jan 2022 16:46:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M2BuTiPfN5gwf9uihCkitZAOOBZPad4GR9JqfdS0iNA=; b=aEDO8HhFIGYEodlXxjfYvCwOVA
 Y663uMDKcg+ISwBlCJg8Gge0/Iee9+UjDnoqlfHJrEl8EY26bXlcek+U5CoAe2oJ/V3f2nj7k21qs
 24EjVbTZRZfEibm5j87FemijxBmVqjmCls6rxVBBQT4/WidRYYO5MkX4HjjYqucsQjS4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M2BuTiPfN5gwf9uihCkitZAOOBZPad4GR9JqfdS0iNA=; b=e
 RPum/OnXGrmq0C+QBLF+zCsrgNAXC2EXabbjJt6AE5xqb8M3HjGGUmXtaxWu8qsTKEg/m3ssmRoFY
 lQhOAyUnsuPrRuci1Cg8IYO3tlr38qIwOmFazpjU2XB3FF/TYLrkbBmoDgeXk34SZS9ljuAvGjT4E
 F5NYFSdqGueol/Y8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n6Eqv-008Y6e-E2
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 08 Jan 2022 16:46:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id C6DD360C2C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat,  8 Jan 2022 16:45:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2804DC36AE0;
 Sat,  8 Jan 2022 16:45:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641660355;
 bh=Cwe33DNy7p/gHqdTzE8Lh7iOrBD6pivF/lzBddkAwOk=;
 h=From:To:Cc:Subject:Date:From;
 b=rJ6nVy8Y/t2P0uLDeQZCNrLqpIpGKXbAvILfB61iENXETGvnvVssqVuR69w1PlSP7
 LEx7noZAQgZbjgApSWkT1Dt6m0VJio3acVTbF2LaCaI+CpQDZXxgznJuk9z8HTQ+fw
 P++QF24VRF7sOScB/Ca4FF5XjDq0awLsEGFhw4QsZtAxEHtO9diOmg77Lizgpts+Kq
 2nw666QHZL7IvUWRZ565ZxhEHmFWHJueHC4QrQSPRGvINORt9gRPbYsSkF6ajMvodO
 qX7E130Qm5P7tTKV0vWZmfJMrDTVTukoU0hL8iq7kLA8SEGCi1kaOQ+cIUKQuFckev
 eCrF5A1Qc/MjQ==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Sat,  8 Jan 2022 08:45:52 -0800
Message-Id: <20220108164552.3130085-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.34.1.575.g55b058a8bb-goog
MIME-Version: 1.0
X-Headers-End: 1n6Eqv-008Y6e-E2
Subject: [f2fs-dev] [PATCH] f2fs: do not allow partial truncation on pinned
 file
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

If the pinned file has a hole by partial truncation, application that has
the block map will be broken.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index f39feedc9816..6ccdd6e347e2 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1750,7 +1750,11 @@ static long f2fs_fallocate(struct file *file, int mode,
 		(mode & (FALLOC_FL_COLLAPSE_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
 
-	if (f2fs_compressed_file(inode) &&
+	/*
+	 * Pinned file should not support partial trucation since the block
+	 * can be used by applications.
+	 */
+	if ((f2fs_compressed_file(inode) || f2fs_is_pinned_file(inode)) &&
 		(mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
 			FALLOC_FL_ZERO_RANGE | FALLOC_FL_INSERT_RANGE)))
 		return -EOPNOTSUPP;
-- 
2.34.1.575.g55b058a8bb-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

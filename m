Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F111EC76188
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Apr 2023 16:21:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pk5tV-0006qE-4a;
	Wed, 05 Apr 2023 16:21:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pk5tU-0006q8-Na
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:21:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+k2iQv33P/fTdI9liK2nPnC8BnN5vQr2IFB/6e+xxF0=; b=EnaH3ymI9m1tw++kb64qstGwyO
 m/BlAQrMNyxJY7LtpX7mNcbtn+VP+aneV5l+I2pUmOWyf2HM1l/i5RFHbcVJpO6kkVwCozbA6Pkhf
 oXsVaiQ4e7MUO1hOEVQP/Av0fWTWCz0ksmnZ+ZDK90pyhshVaJUmL6wXo5gN/YrZ3jt0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+k2iQv33P/fTdI9liK2nPnC8BnN5vQr2IFB/6e+xxF0=; b=k
 ie8IgE1d/T6/J0x0SVlxcjxLEtcabsx6w+9Kc4YVw7mtahMq1S2UgDNbk12Al/ZGXRWPuz0nrF+WO
 bikVN/hkiKgQ3NS7/XLkF2vIaTTyir3+q2lD4NI9uJhbHVXR4KGeJ069oe/03221/sIRjb+sU1xIZ
 68KR/rWnLnGKGftA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pk5tT-0002pB-Aj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Apr 2023 16:21:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id EA7FC63F6C;
 Wed,  5 Apr 2023 16:21:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57E2FC433D2;
 Wed,  5 Apr 2023 16:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680711709;
 bh=ef2YepiMAXx8RjWeBXAJGEINglAm0SF9NGq0mwWfm9g=;
 h=From:To:Cc:Subject:Date:From;
 b=uNFm0cqZXj4E38P6Z6QbhfvfCrMxn81ukq7npYUC2ISHSLJaPu1SBDaOkNpCGD2fM
 nS8V17kZby73sy1Z1c2mv4hUW+l9QYX/GPKrDf2zoxhS1/Sx0ZajzFnM0JKV7rFeUc
 fsT6+BM58vkDaphGnCwbHvhADHpiBp6uwKtAZbT4wY9mHszCRTISnO4omatC+u/Uyz
 IyNTNgMThi2aEhVXHbO2CI1G/dRiUQJgDrsew3O9WN0o/yd8+EfgB4x4mtMqVEVuqp
 EGFc0ZnJdcHvJlY88A146ybIBF3n/GpwAvu5a79hLdZM1+AQAFpTrL+i/hosFJHeap
 RcjWLPnibw2UA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed,  5 Apr 2023 22:44:53 +0800
Message-Id: <20230405144453.930311-1-chao@kernel.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
X-Headers-End: 1pk5tT-0002pB-Aj
Subject: [f2fs-dev] [PATCH] f2fs: fix to check return value of
 f2fs_do_truncate_blocks()
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
Cc: Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, if truncation on cow_inode failed, remained data may
pollute current transaction of atomic write.

Cc: Daeho Jeong <daehojeong@google.com>
Fixes: a46bebd502fe ("f2fs: synchronize atomic write aborts")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 10743e864d57..39c41c7e834b 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2113,7 +2113,11 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 		clear_inode_flag(fi->cow_inode, FI_INLINE_DATA);
 	} else {
 		/* Reuse the already created COW inode */
-		f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		ret = f2fs_do_truncate_blocks(fi->cow_inode, 0, true);
+		if (ret) {
+			f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+			goto out;
+		}
 	}
 
 	f2fs_write_inode(inode, NULL);
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

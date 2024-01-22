Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39E49C47DAF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jan 2024 15:14:11 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rRw01-0002OC-Sr;
	Mon, 22 Jan 2024 15:14:10 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1rRw00-0002O6-LR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qq6Rjnw0VvO7fdLxTd+yZRY+QKrnkRLZPjWhz7UdTY0=; b=ESRy2P+PRZRFNvqcvLmImK4axO
 LHq2wR/DTsrNqnXJIE1BoqoQlLwXVlGASDfSz3uMyMoNiHazMgUJUROfZFGesrMO6h3306p5Rkux0
 v1IhUdgPD9RZpHmfakRl88Rc04LmcPey9dTINO9hnzU+gm5mxzFCrGRyYK2AmOOTWkvo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Qq6Rjnw0VvO7fdLxTd+yZRY+QKrnkRLZPjWhz7UdTY0=; b=bcExh+eNM7tm/+D/IqVhunIP+8
 eRZTI6DYfedvswsZYi/ZH1UG3+p6y2/vnEt+KZ0U34+rQa4TQuaHnToo0yCHuakV8cTXa+skPnI7x
 96jyCVdXw614FiCnBqZ6F76qiAI7mQrOfv0TSAZjahky9NfTWru/7mM61NSSLjK4SOGo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rRvzz-00044L-Gr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 15:14:09 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 0809AB80E94
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 22 Jan 2024 15:13:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAAE2C43601;
 Mon, 22 Jan 2024 15:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705936434;
 bh=Sa6kKliqi6TRKNMJZrqcEHRWzDRql/cto/qdXv2ICOk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ikKYr9BfXOVNjlsGPgomkuQRSZBkaOz7V9d+QAzc9T/zDzhNY19QZv9nsWDUziD9Q
 sqLOmJqEHY1L6aQQ+bfrjrRvmPTJukeBKOFz4NA8uzuT6orhEp96r58txgeJZ2Oqhg
 /A18eppTcghSjix7slI4JBy2qXTXnKB5gUU0lmmoHaeNv8oRslRsiUBYvDqGvAQY+S
 zGec+TPZu3L9CQPqpOX9HF8KJqRfM3K7/9Lq4HoSbVSiS756TJtG8PtJsvoByTnPFI
 14g8EdtBRupzT2YT9of06NruI7mpwtMt4/stkXqYTbOtYvK2SnyJd4jO84CrwsSbuj
 ybZNNcGt1IUPA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 22 Jan 2024 10:12:17 -0500
Message-ID: <20240122151302.995456-20-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122151302.995456-1-sashal@kernel.org>
References: <20240122151302.995456-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.147
X-Headers-End: 1rRvzz-00044L-Gr
Subject: [f2fs-dev] [PATCH AUTOSEL 5.15 20/35] f2fs: fix to tag gcing flag
 on page during block migration
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
Cc: Sasha Levin <sashal@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

[ Upstream commit 4961acdd65c956e97c1a000c82d91a8c1cdbe44b ]

It needs to add missing gcing flag on page during block migration,
in order to garantee migrated data be persisted during checkpoint,
otherwise out-of-order persistency between data and node may cause
data corruption after SPOR.

Similar issue was fixed by commit 2d1fe8a86bf5 ("f2fs: fix to tag
gcing flag on page during file defragment").

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/compress.c | 4 +++-
 fs/f2fs/file.c     | 2 ++
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 3982b4a7618c..7b4479d5b531 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1037,8 +1037,10 @@ static void set_cluster_dirty(struct compress_ctx *cc)
 	int i;
 
 	for (i = 0; i < cc->cluster_size; i++)
-		if (cc->rpages[i])
+		if (cc->rpages[i]) {
 			set_page_dirty(cc->rpages[i]);
+			set_page_private_gcing(cc->rpages[i]);
+		}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 58fd32db025d..5c63cbb06faa 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -1278,6 +1278,7 @@ static int __clone_blkaddrs(struct inode *src_inode, struct inode *dst_inode,
 			}
 			f2fs_copy_page(psrc, pdst);
 			set_page_dirty(pdst);
+			set_page_private_gcing(pdst);
 			f2fs_put_page(pdst, 1);
 			f2fs_put_page(psrc, 1);
 
@@ -3976,6 +3977,7 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 			break;
 		}
 		set_page_dirty(page);
+		set_page_private_gcing(page);
 		f2fs_put_page(page, 1);
 		f2fs_put_page(page, 0);
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00807CA6017
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 10 Oct 2026 07:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=VcRTpKxXEMpL3HJtMM+y/GrPooPpUKQxwq8gU2ArglQ=; b=UvsG6tBOExoSXhBmp/0TIeCLiZ
	UtUQIbLUr5aQIfjH5wa+fgTJ3Te4t9KSBltBt9Jil3SP8ri18OuYO088wEeNhkUi83HPSNjOQxpvu
	TpQvdWKABTfxAxh08bXh1lmlmRacob90oHKocwxDkmsTprLMHgJhOeW40RGfnAB2a5Lc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xFRqn-0003cO-OP;
	Sat, 10 Oct 2026 07:50:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xFRqm-0003cG-6f
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:50:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9rWciA3sqNLXlKpn6IIoptpUh+XgMIKLSLOdWebd7JY=; b=a41HWs0BtIjLcuH0TLjLynch+t
 ZI0VBKUp/TSDdKA7eA6BCySqZiclT5UXPdKN1CG4zJ/EpYqjOw48GRLKzrkCMQitN9EeEWGWIrfUV
 Rdiwmkh9E1hlEUo2WKiItxJt//UlsUD8O63TUrC7Z738Dk+8Tc0PH17VhEJP9dzxoPNs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=9rWciA3sqNLXlKpn6IIoptpUh+XgMIKLSLOdWebd7JY=; b=a
 jQi4DFQ2u11XgiypdhG/o14Q+XZkhmmdX2603BCfrNkudAoN9SuHjOeB3ciVi/6CLpupObmEuSXAh
 OCUIcmzPkNFtAxIGhEDNvHksAStVKZqenXpOpy1fam0X36gN+7tyDSlABbstdsWItztCr3nyzhxWs
 D9urvJWOiwlcCa2w=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xFRqj-0003MP-9u for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 10 Oct 2026 07:50:33 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-3ab3260b35dso225797a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 10 Oct 2026 00:50:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791618627; x=1792223427; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9rWciA3sqNLXlKpn6IIoptpUh+XgMIKLSLOdWebd7JY=;
 b=IYU58iSNhaancuavNj6ZeDpsMbu2kSscNn4s3Jt/lW4ynCjFiSU8bbNIFrxguX/brZ
 AEAx6ndT1DKtjbu6vxFSmtinIx2Wiu35/S+OQu0RCDpblIbS0z5L0KAIxB/dmYZlKICQ
 5pfe06ptXenU3p1kZOO4fCMe+TRJf4pwiSzO5Q7ZCf1m5pY7Rc1fSOTacvpDJ89dXjx0
 QaHzrpwqbNyzjfW4gE1UC6eiUb1VRgGOME61CS40pnjukBWnges/M5CWtdyh8ECFTUyn
 c5mzTYYD5Cn3u0Jr+W5R8wYJ6veT0dgRzkL+6M5zIatx3xZUZo2bxv9HMsq4EctgiN0o
 U/iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791618627; x=1792223427;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9rWciA3sqNLXlKpn6IIoptpUh+XgMIKLSLOdWebd7JY=;
 b=fxykJxkY39QaWA5ebrZSDNlGVLTGdhDL2+S+9K9XmYMBnBp/wb2hcpIadIdzgPPC7g
 SO0+E6k9AJPRkC5VGovOMqZI9coP1qFuXDOGOsv0vNYqWRkcY6XhmpwH/TekF+PDxWnK
 IDAeUEZiv1lx+eV38G2GCsmSQZmSs00STKpDjqOPCoNeuKndstpl/fbUWu+IAHFgpbGj
 or71p3PkdQhfvcoQST3th0CHiYELxSnRBMN1vv0QbZy4ntpC/3TY2BizJCYEBhOSw50I
 KSL8eJtiBxy4GsfqVzKJMF+g5/KDqsk2/APaRZPlPjvK3R0FtIyY17H0M1NnLqLMu+RU
 +LRw==
X-Gm-Message-State: AFq9FYK5/uYdQFU2GQzong8aX9NjB0WaSp2q0AITLZmc5ta3Ig2BAVgY
 Ft9EDybATQjudzxkjnnVho2CHESS9xzqIGJaj3FairS1f8Ldp8XWZxq2
X-Gm-Gg: AYBFou2HkxNe/KI0G2ZC/hvrDRA8xDrEnBfNRi0iBbjzuLCUHOjx8wMZYmVArG3kV9Y
 wCpImrhQAKxaN4m8v64LlPuoggq/Jpyycbix6jzkTdW6EcUlRdSr9gvdYUf1t222b31CcaM7XHr
 Bx0di948GVNfh8t3fS56IEHv+puO8ALpaRw9L/I7Gd0pwFO3uYtaTr4XBYXqaj50YhVvwzX1Q5s
 Duf88kqmddQfv7tnjkGOV0vQIdzmOdNao8Y7OvsdVo6g8cQ+bKj7xq+g9jcChLVOoqrEW4nI9Fq
 yVYTCFddlAvMUrtn7Os/3IRM1scP50rLPw0fUwR+s2QEtsvrYLG5Z/qZ9xL6LaoLwVyGpf1Te61
 8bUycZH2zyLsIdooGqhtYFOkRNZN8j4ZYLZvHCNYMTOwaoJ/wytLBghS4Qq08mgpYCgxzkfdMTX
 a2/U/N4DsZBEbMsCOwjliMwUUKa3F+Sd4UtpWrn4MfwR8RQoQkKpbBd6KnEK0fPnktDnYPvGv6g
 omWWx4LYMxQ1ZEernQB6mAxh5Expu9DW+QOAf2spmarf1n0V1QK2qbdUEP8hMjNYhtd9ZfM
X-Received: by 2002:a17:90a:a8f:b0:3ab:413:49af with SMTP id
 98e67ed59e1d1-3ab3a92850dmr2799642a91.49.1791618627349; 
 Sat, 10 Oct 2026 00:50:27 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([23.97.62.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab8a393666sm1804249a91.15.2026.10.10.00.50.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 10 Oct 2026 00:50:26 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 10 Oct 2026 07:49:12 +0000
Message-ID: <20261010074912.114840-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xFRqj-0003MP-9u
Subject: [f2fs-dev] [PATCH] f2fs: fix termination of f2fs_sync_meta_caches()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When __f2fs_write_meta_cache() returns false in f2fs_sync_meta_caches(),
the function only exits the inner loop instead of the entire
while loop. This leads to an unnecessary lookup of the next batch.

Also, when nwritten >= nr_to_write, only the inner loop terminates.
This allows the function to continue processing subsequent batches
after the writeback budget has been reached.

Terminate the entire while loop in both cases to avoid unnecessary
batch lookups and respect the writeback budget.

Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
based on the f2fs dev-test at commit ce439a2b0690

 fs/f2fs/checkpoint.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 2e5e0ee5feb2..4cafc96056ab 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -654,7 +654,8 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			if (!__f2fs_write_meta_cache(entry, io_type)) {
 				f2fs_unlock_cache(entry);
-				break;
+				f2fs_cache_gang_release(entries, nr);
+				goto stop;
 			}
 			nwritten++;
 			next = entry->index + 1;
@@ -663,6 +664,9 @@ long f2fs_sync_meta_caches(struct f2fs_sb_info *sbi, long nr_to_write,
 		}
 		f2fs_cache_gang_release(entries, nr);
 		cond_resched();
+
+		if (unlikely(nwritten >= nr_to_write))
+			break;
 	}
 stop:
 	if (nwritten)
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

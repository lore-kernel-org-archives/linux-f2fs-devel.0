Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E161D606A319
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 06:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iCzZAhdC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=hp4MA0bY;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=RKGd9vih;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T23AXuDG
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=vSNIFkP0AsrU9Z5glOlqbQpHckrCg+Fead4hd+KPv14=; b=iCzZAhdC9LEKE326+zFqfoVT7A
	tPyLkHGjRfoouuNW6tq4nhz0h35bl3ddIc1zy3reZ/vACmTE3v+opZH0eyv/hju/0EvncZ6yJB3k3
	PkpI+teVQge1hQyB/sirRqeeEpZoPfH3fZJB3s3tpkXq4LX0MoLAZ1Pa/KChA/mpAAes=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJm42-0000000050w-2UCH;
	Thu, 22 Oct 2026 06:14:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <zangyangyang66@gmail.com>) id 1xJm41-0000000050q-2Tsz
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 06:14:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/vyTgpYVb9Gu1c78P9ZLv1Vq4aogUa7DSv0m+IPmaAQ=; b=hp4MA0bY/waAb6Gb8pTcgq2a0u
 KGxUAGcGxn1KW4QIINYcmINCqmzUBG/uZw+ZsgDpJN6OjuHLdJb/mbPZIST9F0fTqwqH9RsFun807
 Kaf3qp0CUQ5HIJDDfG0OKGk7jO7lH9uHBGg6st1/jrIvAhfj6drmYhFTrmjDNYPhyZnY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/vyTgpYVb9Gu1c78P9ZLv1Vq4aogUa7DSv0m+IPmaAQ=; b=RKGd9vihQhdWxuRw/N5dSGEOgv
 y1TQsiPbi0SAMPpwCqOV12Om3cLmjYz4mAa0t6phrhc43E9omymsW/iMiTH/qs4F1u8f+HYclUO8Q
 mYeeiH3SlIi4kv7jSEt+2R/lL9k7Hntbd8GZlUvhrrqZNA7mLOwoZUD9B32NbUUaVbyo=;
Received: from mail-pj1-f41.google.com ([209.85.216.41])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJm3y-000000005CH-3TDW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 06:14:09 +0000
Received: by mail-pj1-f41.google.com with SMTP id
 98e67ed59e1d1-38d489b6b71so962761a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 21 Oct 2026 23:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792649641; x=1793254441; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/vyTgpYVb9Gu1c78P9ZLv1Vq4aogUa7DSv0m+IPmaAQ=;
 b=T23AXuDGH1tMWHV9HbJlDwf0KQiSwm6bMKutvk3c6ulwnyXcJ7v6A8e152QLheRoGT
 PGZrCs8O0DnsL/MGIf/hT93p87i7G0sBBSA89MAjay+RGzP3KxLYBdcCJHusPji/j4tD
 374dM+QMAOk7n9DE7iZH/Zzu+IkR6p73JLSGuLB5sGBFVbjfhevacZ4G8qq94du3ZmX7
 p8e5NUCZxIRKGc9bQjkjPApltFHr2i8MVYknsGPPxDMZn2UPbqcl42+B9ZAedMa5Tnq+
 4wmWQBW927+RHf/hX1LTknfDOvvDSDbSp+d5o1utoLyjL6G1Sh1E9eOvQxrfSf16oDPc
 Iefw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792649641; x=1793254441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/vyTgpYVb9Gu1c78P9ZLv1Vq4aogUa7DSv0m+IPmaAQ=;
 b=c8hU2WznZQ0qtBkWQJ/f7TPDiQxtk87y7qGnTY9Cx7RgZidakM7oNTw5GM5BM1lnl2
 J9na8icAYS3ksruzX16h8ZaF8WEQbNFnDTnmzurHqa72bB7iSHG1+6dO4PKopBOrZPZH
 BZvYrBC8p9JAOCo0fjGCb6+M0d30Q0NhKh5lxJ2RVOWpioMKkfdK+bp368Xvl2NExVIf
 5bJ0FgXH3gPNjVtGLyQIxlEZCLN+Y6hmHQrIGPAcZIm9nW6C0j5SJpJllqupI4R5nwiE
 +V8Bn3xCTmqnWbJtrrF5UaKBqjaOlvzbLCTpU/5wjJTV4Pcrj4hYRIbWgeKnF1NuRiVy
 CibQ==
X-Gm-Message-State: AFq9FYINdk/IdF2wflNcYM1s6LPpUbTxXdq78uaI9dTk7j7r8Bk1mR4m
 H+/AaAvd6WQu2qsDeRPMmWpuFQRm3KqhlPIrBDa7GWiAesbkbDi7GrdbCwCWOA==
X-Gm-Gg: AYBFou1Y8VhOxN8qYyI53rub1aLyu9fWYoJ53oCwtv/zG6al/84DALc73vvzzKZlLlx
 GIP48h1y8zpUA+PHwP9gCLnO2LKKcQP/WkJknLCkBaS5gAtIUhi5gFE8WpZqzK3Ka2/vkzvwzrT
 jaXX1zcGmdpGkvcJdxrFIV6EWq38RIVFt4m8q12z9fScqZD4Nks197goNPGrT3LH9WvijTTRyIt
 pjjz84lANdNLH06eMBC9d5QXEkqUZ77jeVlzh+KiYsmha0hZkwwQu6foDO0Xap8QbOqJ9j5T4Ta
 551jsfM1IZbfsTkjL75U+d7z09FKZ2nxHs05n0cjztbkxjvxAk/C7tDIl+boTH093blpWsynHg/
 daZQzjR5cL8YDPsjEnF5tzeA4WLYStr8EB0owdFFepW6NVup/AkzqziejUoNlnmcU21Rp4Gp7f3
 ECuyFIQHPNv+FRp2gKXbDAkMnPovvvXeQB6DPjb0gtaqRBej14qV0EtsBKCXMc3BBB6bUOeCygj
 Cukj7cBObPX0FNkcBjisSyIOryh2yC/RhXQ2N84eHoKgDpHM9Whw5PZXtiuRqyDIpb4Qf36tSy7
 J04VLR1Ex6kBntTYsA==
X-Received: by 2002:a17:90b:4a86:b0:3a7:ee74:e8cb with SMTP id
 98e67ed59e1d1-3ad86cd5f97mr3398840a91.11.1792649640960; 
 Wed, 21 Oct 2026 23:14:00 -0700 (PDT)
Received: from zyy-m760t.mioffice.cn ([2408:8607:1b00:8:84b:4547:d15c:74d6])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada47f8ff1sm2731199a91.0.2026.10.21.23.13.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Oct 2026 23:14:00 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Thu, 22 Oct 2026 14:13:52 +0800
Message-ID: <20261022061352.2590882-1-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xJm3y-000000005CH-3TDW
Subject: [f2fs-dev] [PATCH] f2fs: fix unsigned underflow in
 has_enough_free_blks()
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

has_enough_free_blks() checks the filesystem has enough free blocks
by computing

    avail_user_block_count(sbi) - valid_user_blocks(sbi)

Both operands are unsigned, so when avail_user_block_count is less
than valid_user_blocks the subtraction wraps around to a large
positive value and the function incorrectly reports that enough free
blocks are available.

Replace the subtraction with a direct comparison so the check stays
correct regardless of which operand is larger.

Fixes: 84b5bb8bf0f6 (f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable)
Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 fs/f2fs/segment.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index 526764ba31ae..c69550084bea 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -707,17 +707,17 @@ static inline bool has_enough_free_secs(struct f2fs_sb_info *sbi,
 
 static inline bool has_enough_free_blks(struct f2fs_sb_info *sbi)
 {
-	unsigned int total_free_blocks = 0;
+	unsigned int valid_user_block_count;
 	unsigned int avail_user_block_count;
 
 	spin_lock(&sbi->stat_lock);
 
 	avail_user_block_count = get_available_block_count(sbi, NULL, true);
-	total_free_blocks = avail_user_block_count - (unsigned int)valid_user_blocks(sbi);
+	valid_user_block_count = (unsigned int)valid_user_blocks(sbi);
 
 	spin_unlock(&sbi->stat_lock);
 
-	return total_free_blocks > 0;
+	return avail_user_block_count > valid_user_block_count;
 }
 
 static inline bool f2fs_is_checkpoint_ready(struct f2fs_sb_info *sbi)
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

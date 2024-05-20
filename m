Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93210C25B77
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 22:02:29 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s9B5Q-0003lx-4Y;
	Mon, 20 May 2024 22:02:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1s9B5O-0003le-Bw
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 22:02:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bqbadoSbaS5Arq2o03HvYKeti99z932oYNcW+kSfXhM=; b=SNFLFnmbkvBE2P7wesUtppeTmD
 d0HF7kPf1mZlwVDq0CL959RmdIY7dY0uHxzPHqc+JFzZD8Mol4DUA1JsRGNald03VYanUiad49Qn2
 YntSNQfXovPoT1U/sTpRBCFOsARoZNknir+rxVpGu1Qn8axCmmtVPoIXaU1v0wMJ2sbY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bqbadoSbaS5Arq2o03HvYKeti99z932oYNcW+kSfXhM=; b=M
 UnWvWhv8mTPsQNvHPORIe9WaD3phenv5suf75VOUqbm9MLUAcZVN6MxAi4IU9+xe8MRy62TWaSmuc
 on6P9gcch+N5R8dyGx2qVGn873MEjmDj9cLHFnJQ27rHFDtADJ1eg5aHUIqJHoeELFWd6QoIhC0tC
 2nzAA3TMG2VyZx/M=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s9B5O-0000MK-1l for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 22:02:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 82DC5CE0B6C;
 Mon, 20 May 2024 22:02:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99924C2BD10;
 Mon, 20 May 2024 22:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716242532;
 bh=21RrcQOivTABjQKWwifC+gMgj6SJitH/D2oLeL+047o=;
 h=From:To:Cc:Subject:Date:From;
 b=E7BJwLXtBm3l3i/ysAd/mgSuOZ2KG99RwmVaAqFvZoonBAWP3/HEtHlkFltkDttWg
 RvlUkG3RlQpdawS8mhCNKZJEpwHbYuX3kknEprUNpM3SlzEFZz0h2A9ayqcy4W+gcZ
 mKfZO+EULrrJqHfjph1aclsle92Mkb8r1CK41kchvu1bOAQPtSAN4AxnO/eweI0MGX
 nh7HzfI02GVlc5v/gzjP3COxLvXYSaeL25Q7nDuenOxkXRzElMvO6qUXexRESUlylt
 iE8x2COs31XERQ7QPVDJkV8xwh9mi+W6NA6CiofmCu8bqlHwQ0s6aEy6GZ6ZRQdWm0
 VSmJ6mDUskTYA==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Mon, 20 May 2024 22:02:08 +0000
Message-ID: <20240520220208.1596727-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.45.0.rc1.225.g2a3ae87e7f-goog
MIME-Version: 1.0
X-Headers-End: 1s9B5O-0000MK-1l
Subject: [f2fs-dev] [PATCH] f2fs: fix false alarm on invalid block address
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, stable@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_ra_meta_pages can try to read ahead on invalid block address which is
not the corruption case.

Cc: <stable@kernel.org> # v6.9+
Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=218770
Fixes: 31f85ccc84b8 ("f2fs: unify the error handling of f2fs_is_valid_blkaddr")
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 5d05a413f451..55d444bec5c0 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -179,22 +179,22 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 		break;
 	case META_SIT:
 		if (unlikely(blkaddr >= SIT_BLK_CNT(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case META_SSA:
 		if (unlikely(blkaddr >= MAIN_BLKADDR(sbi) ||
 			blkaddr < SM_I(sbi)->ssa_blkaddr))
-			goto err;
+			goto check_only;
 		break;
 	case META_CP:
 		if (unlikely(blkaddr >= SIT_I(sbi)->sit_base_addr ||
 			blkaddr < __start_cp_addr(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case META_POR:
 		if (unlikely(blkaddr >= MAX_BLKADDR(sbi) ||
 			blkaddr < MAIN_BLKADDR(sbi)))
-			goto err;
+			goto check_only;
 		break;
 	case DATA_GENERIC:
 	case DATA_GENERIC_ENHANCE:
@@ -228,6 +228,7 @@ static bool __f2fs_is_valid_blkaddr(struct f2fs_sb_info *sbi,
 	return true;
 err:
 	f2fs_handle_error(sbi, ERROR_INVALID_BLKADDR);
+check_only:
 	return false;
 }
 
-- 
2.45.0.rc1.225.g2a3ae87e7f-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

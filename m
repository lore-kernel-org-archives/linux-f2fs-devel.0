Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833EBC47DD9
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jan 2024 14:57:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rRvjS-0007Co-GZ;
	Mon, 22 Jan 2024 14:57:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1rRvjR-0007CW-1P
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 14:57:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qPwFWKYaMuHMff7buFv1bxCGiw4UNdHY7IG0sAlOfOc=; b=bYsQZLHWmX9YRMVzRQ5BCfQ3Jb
 IAC/VGYtitqnnkUJIVoD88RIK+XZX1nMQRbN8ImxxVPiVU/K84Rez1od2ZbMGUhbhdvFgy+c95xxB
 MH5rJGxyo3qDJn/mxA7cP1rmbc7W5+F9MWxNh/ZxbeoYIM/pmn/vUZdr0PjORJSiMBOc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=qPwFWKYaMuHMff7buFv1bxCGiw4UNdHY7IG0sAlOfOc=; b=T05CZQTBTDf2qi7+efGcl7XFos
 iWX8XvRsz4zPtFbXYJE7k2AXgtvF3n0DawRpo4oOX0JlC3NAu/zM0OgzsCQTxLlyjsCSJsWkfZoSb
 5mye7mahRvKbPu8s/R47rdlSsLaSlxCVe011yRXUR7C2EIt6tXo1Q2SjjFtHGm8SaSPI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rRvjQ-0002it-4s for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jan 2024 14:57:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 6DC36611C5;
 Mon, 22 Jan 2024 14:56:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A20DC43394;
 Mon, 22 Jan 2024 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1705935410;
 bh=y0weoZjaAER4fd5JnbyUGnSm+FqzRTJnMMaHVtDIdJ8=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ca1/d30IXwJm8hnvYz4SP9L6ZlokwJGouNJT0AdxfnI+ijapMOuef9bTRIprv101f
 RUU15R0fsM8ZnAL4zWZmbrXbCp4nTrSiBCrYSoAutI7bbr7mtmmtIVzxTt5AMAUhxC
 hhAHcX8acCMJUrF498LBGV7gYtMXWTFRhZeK3yWS91+ULVhPKiGOZq4uKVoMb+EndQ
 BwNXRpU5+NClPasraCO8a0V258TbzyeuU/3UywguBSkovLGq7wA4P6qeTVw31MGlMF
 N1+qOxOT1iv5lZayRI6WlT0Ft7LatGk65aDz9dIzxoUjYLhbVq9cRTcjewVCdpHWya
 +HbIMOtZJ81dw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Mon, 22 Jan 2024 09:50:48 -0500
Message-ID: <20240122145608.990137-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240122145608.990137-1-sashal@kernel.org>
References: <20240122145608.990137-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.1
X-Headers-End: 1rRvjQ-0002it-4s
Subject: [f2fs-dev] [PATCH AUTOSEL 6.7 15/88] f2fs: fix write pointers on
 zoned device after roll forward
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
 Daeho Jeong <daehojeong@google.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 9dad4d964291295ef48243d4e03972b85138bc9f ]

1. do roll forward recovery
2. update current segments pointers
3. fix the entire zones' write pointers
4. do checkpoint

Reviewed-by: Daeho Jeong <daehojeong@google.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/recovery.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 16415c770b45..d0f24ccbd1ac 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -917,6 +917,8 @@ int f2fs_recover_fsync_data(struct f2fs_sb_info *sbi, bool check_only)
 	if (!err && fix_curseg_write_pointer && !f2fs_readonly(sbi->sb) &&
 			f2fs_sb_has_blkzoned(sbi)) {
 		err = f2fs_fix_curseg_write_pointer(sbi);
+		if (!err)
+			err = f2fs_check_write_pointer(sbi);
 		ret = err;
 	}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

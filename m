Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 838B5C55ABF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Aug 2026 12:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0+LhMb2phu/2dlSIOJ1uAdvBCUpNbqwzO/1XZsN456Y=; b=E088YBpuG3Qqv6Yzs8SHkOnwf6
	Pk/tDF/eIxBAF6ahwHbg294szUamm+ORX2JJHle1OxAdoUnMUmOox+vJh0dRBnF7q2SN6by0MYnqd
	7jZ0hZw/JBAxb0wSQ+u/NUXEsuIOuu4elMIbL6X6myu1nLRk4y4C8+RhAY/t8QXcQP34=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrakZ-0000aG-PL;
	Wed, 05 Aug 2026 12:29:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wrakY-0000a8-E5
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:29:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=7WcoJZZvlXkEevuzRoiCMwnxGEmDNo4etrW452HQ6W4=; b=NGQKbp83HqaXBlEsIPSmIZHHtN
 6X5MMIQKx3mDEwOOIQtZo2xj7NglkihPJCp+mBlrEmDYXpmG4YS4N0YeLt2YtkUUqWJXWp28o/JAJ
 R+gphJwXIDpVQIEMfXnDpZ9Z+eeiwl/lY3dTLlDhgURt+ZI5gWRnF1MpefFPNuMZgTWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=7WcoJZZvlXkEevuzRoiCMwnxGEmDNo4etrW452HQ6W4=; b=H
 mo+4wRk0G6CCHBqUtrwn1z+LMdl3kyhlNbpkJwsMxRHInngBtObortntwEswZe2N8oFmlLceZgjhF
 rOc94cWHUlLt5nwf7X9QVwZQi0rof3k9Kbx7PNCQGBvrTHj3xbtxzL8nBzps7Oun0APcugKRFR/A5
 FMmCN8zHpGkD12eo=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrakY-0000aP-0W for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 05 Aug 2026 12:29:34 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F355600AE
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Aug 2026 12:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAF471F000E9;
 Wed,  5 Aug 2026 12:29:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785932968;
 bh=7WcoJZZvlXkEevuzRoiCMwnxGEmDNo4etrW452HQ6W4=;
 h=From:To:Cc:Subject:Date;
 b=QuqzE6jQotST/dNwPESU1s324WIrNtAmrvDR6OIMBQsNVuvq06d24CaJDEcGpW9i7
 rp4t7wvsuMesEbXLGKczNr4LxiCSL/+oCUVfqy7eZX6xYad9FY/wErzgWMKYiilY67
 1/OZj5GMFogo4dq7Wi2qybWh6GCMzC1cPbHziDlhN1ISG1wyDkXvbaOc7MrHNhweTr
 wOZcfegOToGQ61H5BqC7negUIto5o0Skt+ASTeaCSlQ2JDOusNPx9GJQO/x1PoSdG8
 2IWVwPBJRyQAnWP1wRNRLB2DCySdBPdlwk6lu8mJaRP/+rzlWIinf1HFXie4HFFSxl
 aF8+2RoVcdl7Q==
To: jaegeuk@kernel.org
Date: Wed,  5 Aug 2026 12:29:20 +0000
Message-ID: <20260805122920.674676-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
MIME-Version: 1.0
X-Headers-End: 1wrakY-0000aP-0W
Subject: [f2fs-dev] [PATCH] f2fs: fix to clear dirty flag on folio in error
 path
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

If node block is corrupted due to chksum mismatch or inconsistent
footer info, it needs to drop clear flag of node folio, in order
to persist inconsistent node data to storage.

Cc: stable@kernel.org
Fixes: b42b179bda9f ("f2fs: fix to do checksum even if inode page is uptodate")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 9775fa90636a..a98855b8cc5e 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1618,7 +1618,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!err)
 		return folio;
 out_err:
-	folio_clear_uptodate(folio);
+	clear_node_folio_dirty(folio);
 out_put_err:
 	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

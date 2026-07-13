Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8AEAC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jul 2026 06:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Date:To:Message-ID:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qWzN9QjET0i6AIfCcOje3Mzhvdc+5x090wwX8LHzvJ4=; b=DLIOis9ud4EhKrrFmsaWsqKi1c
	CWRvTpjtLWffNMyq9IueKlFSDXbUFVbqIo4r66Py18f1419KXI5mrBJHhgvgDeCzSbE4DKznsEdNq
	8dhbJyo1ZBBmLnbYDbhG1sXl+56a3cZKADf34n3oYunr8mzPWRMJkj+fPDtwskjoJ01w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wjAMw-0005Kk-J6;
	Mon, 13 Jul 2026 06:42:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <3497809730@qq.com>) id 1wjAMu-0005Kb-U1
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Date:Subject
 :Cc:To:From:Message-ID:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yoCirpgF5yJFDuc8ug5Xvs+Xu7s9msMVyMvPkGgdR6k=; b=DsZFNXQSh51z+umgPs9n43i6q7
 8AFlWF83ux/l0t4/pCL3tm/TQY6OIekMgxdNtEjZIBg/4CeJi3TzJLAeoLl+4LbybopiBRR/N+BuE
 k7VjQFv5X/+Yzt/Uvktz2LBFMLN0DUAWF5mv9Zv+Z3O8PpF/BiKfAxO4a/oXMu5WQJ5A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Date:Subject:Cc:To:From:Message-ID
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=yoCirpgF5yJFDuc8ug5Xvs+Xu7s9msMVyMvPkGgdR6k=; b=l
 baDkfnKW65a0lZziHimMK4qycrvoNw9Hz+I8YOO99LC78e/fOy2TPT4BZXNthq3VxE4TJQzxFF8ul
 O5GvUI8jk4LiijPw4UXq7CBpJjdDpyccVmRw+z7HO5iXpLk+xU/mCn25crF8XFaD4Nr19VC5yBXK9
 fttG5Z/KlnApmeAE=;
Received: from out203-205-221-233.mail.qq.com ([203.205.221.233])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wjAMq-0003yX-LJ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jul 2026 06:42:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
 t=1783924922; bh=yoCirpgF5yJFDuc8ug5Xvs+Xu7s9msMVyMvPkGgdR6k=;
 h=From:To:Cc:Subject:Date;
 b=kjJQcYcA/IjJ2ZgLTHvvoFV4hW5YZJPWAIdcBgc/sGdWXNrKR2BL1GNnQxy8cV3fK
 kye0jeJCcUXsv+uvl9KIlakFHNkSHxiwcLq+ZomcXYL2hls4jQ4OkqLXQbXXuWyj54
 1stU/AjeYTc2i/2hrCp79hpnSv9Rafc8H+ku4+bU=
Received: from ikun ([221.176.157.250])
 by newxmesmtplogicsvrszb51-0.qq.com (NewEsmtp) with SMTP
 id A2CAA6BE; Mon, 13 Jul 2026 14:40:44 +0800
X-QQ-mid: xmsmtpt1783924844ts8dahirg
Message-ID: <tencent_FA4515CFD8902EB74708A91807AA001E3507@qq.com>
X-QQ-XMAILINFO: NPa98HB0c72NZJ1Rar8ja3szPOtat+r0stdIyX6H/HXCww/+92Vu4zos9B4urB
 OqBSy5ErhzkarUQVo99g3s39iYj9rO9YQhPFXo7w2/t+opCoto2gtHzKhhHvgxeVsHAiXpye8/BY
 Sz20bcsfA0KL53Y1+eczy9wuzdjiXTQPmMl0bIp3cda3PXrdpAKFL+nCcJwUb3ynVZMFruUxGTnQ
 rLC86KJJHQic57hj5maAOkmEekI2vXM9imSzRAK5tRD3ApTDUHYyb7ip+aMFNKBnvFyfpqCVe3zd
 ZAtEndT0axQK21yaoixII/arMzpMh1mfH2gcv9qAwsqAOQzMiVmir1nLGUSQwDOdoqUWqs1g49/q
 94n4rKCh8nrUNvgaY60VyGlln+hzdAHImmOg32VDNTLkQkFE5gY5ErDGSRJ4AFxg6KpeC2ZxwUmW
 XRJeRsvASNr84NzQ5lqGTB1u1mXtTHC13qYNE5QZxkamdSrV1wuQ7b7/cj3LknjJ4/J4/En9lP2V
 yLsCAxEKp0ehhEDampK/2u63vfz9+u1zMeDsbLTauQt2AcHVYkswyOVlyMcxd++iRN/7TLMLzxt8
 zoFiwjNxcCrfB7u2Eh8iheS5qMrbL6iZwankOOZV7UPmixBAVVwX0axm3GPRED4pDUeYgF9N8jqv
 hONaRtfqUmPEXcQGy8/mZxL2AsVtf94OMhQsEQ5y5dXNd7w71B64HMatcfBiX/65W8K0ym5Z9hVG
 Wfq0ePeXYWR5l65ghltyjB0242EPao8pzSfuGaKcAYm8JIOsHJuI13GVjhOsQaQa9PnCYK2iRoi8
 ST1OE2SOuY8elUJNe2r45snY5QQkLqtclnRHPnlrxwFIOjPhtG5lTEmb+N+8ra7cYJQXvccxhwcJ
 GNtf6Xm69p9SuUzZiM06ZioWY6qSOWbOlLuZrNPCn6QUR4zL2rSQyYI1EZmy2JIZDTUv7XuA8xZb
 PdhHavoWzuZDtIyXyD7dFpQ3BpaXchAJ75z5XBNcg158cubiITuz3bfWPKdPtqXk5itocvmOnPye
 11+os/hskJT7A4fFoENKCxFvtSMQNpDb+raBGRsys7YRfLHMFDJgxFAtnSigE=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
To: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 13 Jul 2026 14:40:43 +0800
X-OQ-MSGID: <20260713064043.1837-1-3497809730@qq.com>
X-Mailer: git-send-email 2.52.0.windows.1
MIME-Version: 1.0
X-Headers-End: 1wjAMq-0003yX-LJ
Subject: [f2fs-dev] [PATCH] f2fs: fix ifolio leak in f2fs_move_inline_dirents
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
From: Guanghui Yang via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Guanghui Yang <3497809730@qq.com>
Cc: Guanghui Yang <3497809730@qq.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_move_inline_dirents() documents that the caller grabs ifolio, and
that the function should release it on any error.

The f2fs_grab_cache_folio() failure path already drops ifolio, but the
f2fs_reserve_block() failure path only drops the newly grabbed folio at
the shared out label.  If f2fs_reserve_block() fails before clearing
dn.inode_folio, the caller's ifolio reference is left behind.

Release ifolio on this error path when dn.inode_folio is still set.

Signed-off-by: Guanghui Yang <3497809730@qq.com>
---
 fs/f2fs/inline.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index e2f7bedf1552..dea4ab957de8 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -427,8 +427,11 @@ static int f2fs_move_inline_dirents(struct inode *dir, struct folio *ifolio,
 
 	set_new_dnode(&dn, dir, ifolio, NULL, 0);
 	err = f2fs_reserve_block(&dn, 0);
-	if (err)
+	if (err) {
+		if (dn.inode_folio)
+			f2fs_folio_put(ifolio, true);
 		goto out;
+	}
 
 	if (unlikely(dn.data_blkaddr != NEW_ADDR)) {
 		f2fs_put_dnode(&dn);

base-commit: a13c140cc289c0b7b3770bce5b3ad42ab35074aa
-- 
2.52.0.windows.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

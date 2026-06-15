Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6364CCD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tz37O8aGtUQujs8s2v+V2jAesFQOZ1jqESiHnF63VgE=; b=YRBHGF0XmSuFfHQ6d+g68AV1g3
	1zhWVrOjU/J9XpFRUxaTr7lLrizKV0V4QuZyvGFByRDXawKvL9il4UsES5MHarzjNwaEiuPl23agk
	SYXAhD5jnvpIdANC+cCBT01yFyd3cXEbBrc72+NHQY24gLzJtmZ8DfJyduSypH4C+cII=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wZ73X-0005R4-Ga;
	Mon, 15 Jun 2026 13:08:48 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wZ73V-0005Qy-B8
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9Oz7Ewg6inmmIK16kmMwM0XHCI9POd9+GxmqienRZwc=; b=iethMdBLL6c3JsQWd8jOmcsTWh
 +CI/sPVEmmc/uAGabL9GJJqvY673dQPDTnP3IqLT5EyuvLuLNYcc9DSvhUtO+reOaElcT68CEVNST
 YZa25/XF9PmvOODlqIxHiEuJktTjF/QqQmN99cyrRIQ/CpYiIc7SMYhLtH6WnMceAXf4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9Oz7Ewg6inmmIK16kmMwM0XHCI9POd9+GxmqienRZwc=; b=nKV+Q8uNLtsDwmMOXKoj/GLYU8
 tvTE1GXVgggFWCez1gJTP9j1/+0/lVlF3RNfPhMFbEPGCZSTLzMa+6OfRLOHWERkCqQlkQh8pyLVZ
 82srMOpbp4WtHwVakB33Hnqvx6wjE9Ud6h3gZU42Z7kbjb9ApNxX3u5Xxud7YI+9yL5E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wZ73T-0005wm-FF for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Jun 2026 13:08:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7C08B406F8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Jun 2026 13:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5826D1F00A3A;
 Mon, 15 Jun 2026 13:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781528913;
 bh=9Oz7Ewg6inmmIK16kmMwM0XHCI9POd9+GxmqienRZwc=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=G+G0HOCABudmRmbX9QsOezQd1E3Vujva77nBsA/mIZGjbdW0yFlqWS0ogqY53ZTbd
 6NEJp4AaV6SMTtLjuuDeS1o9CjLU6HGILG+FI4BAb7RVwpHmec0QHmHgHeScrxzkin
 zo9qZYWpQDKLnA2bBAO68NR8FN9V93loYgtalizpsWMecDoD5gXDLJnBOksjxh7h4B
 go2OX7xAmmPMHDTCD8cL6bkahz8es/jyTDl7fJAjIdWrOSg7TNukvsbLPtIzzcA/CQ
 bc+IJKwmgcFidgm8+jAusOGsMJm7xqC+Bi6rLJDlro3HKMth3dtHNMNI9Ozbz9+yJE
 4CnZB3Hhq0yrA==
To: jaegeuk@kernel.org
Date: Mon, 15 Jun 2026 21:08:18 +0800
Message-ID: <20260615130822.2576088-2-chao@kernel.org>
X-Mailer: git-send-email 2.54.0.1136.gdb2ca164c4-goog
In-Reply-To: <20260615130822.2576088-1-chao@kernel.org>
References: <20260615130822.2576088-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wZ73T-0005wm-FF
Subject: [f2fs-dev] [PATCH 2/6] f2fs: misc cleanup in
 f2fs_record_stop_reason()
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 20577e33ee2a..ff2b9c6e8c32 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4648,8 +4648,7 @@ static void f2fs_record_stop_reason(struct f2fs_sb_info *sbi)
 
 	spin_lock_irqsave(&sbi->error_lock, flags);
 	if (sbi->error_dirty) {
-		memcpy(F2FS_RAW_SUPER(sbi)->s_errors, sbi->errors,
-							MAX_F2FS_ERRORS);
+		memcpy(raw_super->s_errors, sbi->errors, MAX_F2FS_ERRORS);
 		sbi->error_dirty = false;
 	}
 	memcpy(raw_super->s_stop_reason, sbi->stop_reason, MAX_STOP_REASON);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

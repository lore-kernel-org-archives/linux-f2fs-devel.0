Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9713C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Nov 2022 06:36:08 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oupYG-0008Re-EW;
	Tue, 15 Nov 2022 06:36:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ssawgyw@gmail.com>) id 1oupYE-0008RT-K2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Nov 2022 06:36:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=; b=jcjezGxFca8Rqh5kcpAQGP1z0p
 qvZSybifmRgRYwfCWKFHHpIiZU5zosa4GtNnllu4hUAJSwLMZ2ASt56kAyiEUeDZeGd7d435nIkkS
 sE9ikU9miVL8rJCkkbzvkNYUh08fK/CWC5f4Lg3QTG50UyntMP+3Wst17ckr6UuIBy0k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=; b=HtOAdPZ0Vr9iM+ZxjlSfUZagk6
 84ONoYfmWZzXWNAmeqx5i78tBvXVJq0RF5FPdtvMsAnF1rmUhswjZDzmZ0kbI+T5wN4gClkPkpwoY
 m2/ws6PQyFqmA8XSUwiYj3xxBDN1DobZYfUw96B7WpOMaFOx2NrYKtlu5r0DjECB8+Q8=;
Received: from mail-pl1-f170.google.com ([209.85.214.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1oupYD-0008Hc-JD for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 15 Nov 2022 06:36:06 +0000
Received: by mail-pl1-f170.google.com with SMTP id p21so12285171plr.7
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 14 Nov 2022 22:36:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=;
 b=NwwCJKF+znEhRh360dhBKRYvY664rqbb3Q6CjoAruwbU0hB6fIx6iN40Hr23MLUIxx
 akhV7pXA0Lca6e5ZmWhsG+cCqLhXrgIapmOtSMTAx25jIf+N58eF9Vh3hkuHlgH8wTNU
 tR0YCeOQdmoMxw+rsRd346ey1quUzS/tif0sXPCWUiaTVM82mP2uNeFcginMnz/I3kPJ
 pGEsCnwk13uc7lRSsWP85Zp9XzMRFnEyC86lv4iwRE03JYmgHsIPjGvlvL2ajafLJXB4
 /zgF0XKBkDGOMoZomtMfQrACGtD/nPXqoiwm7sN8dzFI3c1RdPc04zolpw8Sy4bpg7Ay
 J+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=At0DMj7QmxXhtx0rqE/HVuXuFAjGeJogide/J8J9NtE=;
 b=cSHrfCyK2QdWKS6+XbtavK7SQZWwxgobbYh+f4sQE3XBhvGMkjqzuH86y9yA+o02sM
 04B70umaLQtRSyAX6+wE2df9WkxM1Hkc3riwIEg1j1+TqwPFT/zoLxVKwclQ1T7LP71/
 Z2tup5bgj8It/leWiJGa/0QYAoUGqtJB/X/Tw4PdatUZ3bC7juGGQZ9qgIcmchyggYIo
 uPZ+5t8mZtOwviokLmzdp+7YlpbdCqYcg77sIWp4XQ8aDnwHTbuZMOseOtujuqn6fqzy
 ZYJUJ8hjlAR2ntu38iZeGKlJ6XrJ0R6REfnaMwxgecg2ZZiXP5r7VZbOKe1fU6r0G3XQ
 Gdhw==
X-Gm-Message-State: ANoB5plNejUJY2u0PjC9PQjQ15+V3XGMMgF3wf+KDByLeYEe+NmSRxxX
 VWly110+rAoQCIw5KDZCpuw=
X-Google-Smtp-Source: AA0mqf6INrMbbMhJmIMiuKEwY0jkAMYYg22PKD/IRtv846IQRf7ALvYzhudqHBDl/oQRDcXRxPyAJA==
X-Received: by 2002:a17:90a:d517:b0:200:40a2:eaaa with SMTP id
 t23-20020a17090ad51700b0020040a2eaaamr764941pju.68.1668494160103; 
 Mon, 14 Nov 2022 22:36:00 -0800 (PST)
Received: from VirtualBox.. ([129.227.152.6]) by smtp.gmail.com with ESMTPSA id
 e4-20020a170902d38400b001822121c45asm8767874pld.28.2022.11.14.22.35.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Nov 2022 22:35:59 -0800 (PST)
From: Yuwei Guan <ssawgyw@gmail.com>
X-Google-Original-From: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue, 15 Nov 2022 14:35:36 +0800
Message-Id: <20221115063537.59023-3-Yuwei.Guan@zeekrlife.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
References: <20221115063537.59023-1-Yuwei.Guan@zeekrlife.com>
MIME-Version: 1.0
X-Headers-End: 1oupYD-0008Hc-JD
Subject: [f2fs-dev] [PATCH v2 2/3] f2fs: cleanup for
 'f2fs_tuning_parameters' function
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

A cleanup patch for 'f2fs_tuning_parameters' function.

Signed-off-by: Yuwei Guan <Yuwei.Guan@zeekrlife.com>
---
 fs/f2fs/super.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 17b9e70b8f32..3e974c003b77 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -4060,13 +4060,11 @@ static int f2fs_setup_casefold(struct f2fs_sb_info *sbi)
 
 static void f2fs_tuning_parameters(struct f2fs_sb_info *sbi)
 {
-	struct f2fs_sm_info *sm_i = SM_I(sbi);
-
 	/* adjust parameters according to the volume size */
-	if (sm_i->main_segments <= SMALL_VOLUME_SEGMENTS) {
+	if (MAIN_SEGS(sbi) <= SMALL_VOLUME_SEGMENTS) {
 		if (f2fs_block_unit_discard(sbi))
-			sm_i->dcc_info->discard_granularity = 1;
-		sm_i->ipu_policy = 1 << F2FS_IPU_FORCE |
+			SM_I(sbi)->dcc_info->discard_granularity = 1;
+		SM_I(sbi)->ipu_policy = 1 << F2FS_IPU_FORCE |
 					1 << F2FS_IPU_HONOR_OPU_WRITE;
 	}
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

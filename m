Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962C0C83F26
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Jul 2025 10:38:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:Mime-Version:Date:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6ikBNWSb0AaG56XRyEONG7HdiCer6b8mOH0wCU1tF6k=; b=HhhQjH2B/5W85GzMOaJC0qBGsX
	TtdYNYTnLcs5tPU94KghMSa45fYZBjWfprMJozY66fyn3p4G0ed8BmPYNZjUFQalvrmAJpojL4AwO
	22n4UgYKdR9SusV8GUj6xvCTsciTlNlCxf67rUa1iMf9SWWDwCxdu3VA2sN5gPapvaJc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uetLO-0002Ah-Sm;
	Thu, 24 Jul 2025 10:38:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3SwuCaAwKALQdjlomUeiqmecaiiafY.Wig@flex--jprusakowski.bounces.google.com>)
 id 1uetLN-0002AJ-67 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Jul 2025 10:38:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 Mime-Version:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=; b=hkxkDwVNfxTjOptQ54SXivCO3A
 uSitizXZIXVokqzz8kGDYWcRcNZK3dzDGVq40uLeQ2Z3iYYCgY8PAdQt8BNZM/ssC0aUJHP4umEG/
 2sDTfsPpbsXNq3PkWj8NeDgputnRbLQ3kKhnOOrzhP3uxZnpp0oGqDWXzuX7YKurBtDs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:Mime-Version:Date:Sender:
 Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=; b=V
 ZVT/Snp5zGttz4d2Tt2YxS4ZyZ8RyZBoUJ1MRLxojPvH1cFOivdPmZpPtN2Jj6d2byuW6XQ+yRmBv
 Bo1bRzZM7FHvyM8qcT1UuM6FYYCiXSv6LsU5pcJZK5hFJiz4szGcOqfxpvQ8wU8hf245SkKtTK8KU
 eHAUAKVZFHXejrl4=;
Received: from mail-ej1-f73.google.com ([209.85.218.73])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uetLM-000669-RU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Jul 2025 10:38:33 +0000
Received: by mail-ej1-f73.google.com with SMTP id
 a640c23a62f3a-ae3b2630529so84051966b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 24 Jul 2025 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20230601; t=1753353506; x=1753958306;
 darn=lists.sourceforge.net; 
 h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=;
 b=PJ8AqHpHpnTV5qIAAOnBgfA1V/riIWq1DhdCBMGwtE4F07T9MS32BaYA2GfAloipey
 Kmj4v5Xi0l+8pFYLTg3yL57LJialTPqDxOVo7WwrKUDj04wDMbBh3r94J2YmscXTOygL
 lhwdGUzM8ruiMIouYWMewI+BLkMNI5Dj0R644ntaZLfuG2e6wzzAfQEGJoo+rlhvyEsP
 HWL5w+zXQhDN/BkD/U9HB/VV0AGkKuGswqJEkJczvMT9sXGpO5fzZ/v9pxgLbIZN2g3H
 v5f5ynKC3EEkb62sjBeap2/+380M6yvtWNFAYNE4+1fKtZqZmKIQZspx8wl4ls44p1jJ
 2fFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753353506; x=1753958306;
 h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oP7cxGwm/mObhghxpyauLVJ+5M/Q63eusIkmXcjkDec=;
 b=DAJimjwL5PpAAOjz8tGs/uPYw5ytmiNvFSSyH+ZalcndFKXzJfGqDuKVDee31660yE
 wmcDRMvXkBay++A2bL81N9E/6NXFe6hiRKxaQGdKIaXmfB/49Shqkf4Maz17JBQDdtzr
 Mw1ATNH4mp0SI/7HlqceTRzG/qX2Az4TLWPqYBM9GG/K0mXf7p4X6K89oQe8mM9ORksr
 V/xUsaIyW1Qyais38mfwcV8MjUYNkB1VUIxsng5y9kEwYAsgLQ8GfpdY4pmUz8LtqbCw
 qahopxo/la+9WA0q9RF+bsnpy47BZOJeiPhYL/STSH0DSauOFMrCsrvQ84bvEBfngpAt
 v0UA==
X-Gm-Message-State: AOJu0Yyd5uban9qLNQ3ae0F1c9OWhC90ETSe/bO4aL5Bm4Derz/gm+OO
 oFTGi+3yPJOAVDDOMg0RERmptNHdN1dza3XVijsUs+MbT+B9aw5vDoSCJofk6usR69XjLu9R+IA
 ZcV8gA3Mr+fnMG7oKuf+69HVRhVsY/g==
X-Google-Smtp-Source: AGHT+IEW+Ka9VvSms6hDdZ18FHwhQB5dVK6OecnLWTKMyUjuUm/tV39mW4FcyUnZaaFb0VWGkqSjAPHaBgv3/9+78w4=
X-Received: from edr13.prod.google.com ([2002:a05:6402:44cd:b0:614:d2e4:82d0])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:2743:b0:609:7ed1:c791 with SMTP id
 4fb4d7f45d1cf-6149b5a6cb9mr5507870a12.32.1753353035529; 
 Thu, 24 Jul 2025 03:30:35 -0700 (PDT)
Date: Thu, 24 Jul 2025 12:30:16 +0200
Mime-Version: 1.0
X-Mailer: git-send-email 2.50.1.487.gc89ff58d15-goog
Message-ID: <20250724103016.5164-1-jprusakowski@google.com>
To: jaegeuk@kernel.org
X-Headers-End: 1uetLM-000669-RU
Subject: [f2fs-dev] [PATCH] f2fs: vm_unmap_ram() may be called from an
 invalid context
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
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

When testing F2FS with xfstests using UFS backed virtual disks the
kernel complains sometimes that f2fs_release_decomp_mem() calls
vm_unmap_ram() from an invalid context.

This patch modifies in_task() check inside f2fs_read_end_io() to also
check if interrupts are disabled. This ensures that pages are unmapped
asynchronously in an interrupt handler.

Fixes: bff139b (f2fs: handle decompress only post processing in softirq)

Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d1a2616d41be..0acc25f996b3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -280,7 +280,7 @@ static void f2fs_read_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(bio_first_folio_all(bio));
 	struct bio_post_read_ctx *ctx;
-	bool intask = in_task();
+	bool intask = in_task() && !irqs_disabled();
 
 	iostat_update_and_unbind_ctx(bio);
 	ctx = bio->bi_private;
-- 
2.50.0.727.gbf7dc18ff4-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1424CC6B27
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 16:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9FvTxRxPUdSP1W2quXn8ocQUZQ/Fp2KZYiVVnliMcpc=; b=FaEApTpjiOLtvyc7Q1VxoDUG/t
	CLIWPPCR0iikOVCcseNBMGmFsTDuOCaXmDf+oOtImbj2vIsd/TgozFcpZJSdGFJQ9Ojselw7nNqYb
	3LOSS7vdk+h0MiFLUDNGQIG/Lvv0iAohoPn4jLAO4kbsreD2jb2xaS2/RD94oiDCf0z4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xH1hq-0004Fk-D8;
	Wed, 14 Oct 2026 16:19:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xH1hp-0004Fe-6V
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:19:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hfoYzyBJ37KsC4r5FyT7Zw2Tm3J8AyIuMZqnt5kRPdg=; b=lNzHEpa4o67pUsfW5EMHvAsI9B
 R+nSdqT0AAxqkerwcqxp/L9KI6WjFoPHlp907DEDQXuda7rFM/7Eqqjd2IKFHByqBxCxDzih7aLkf
 hNCEhwyrStKAV6xzV507gfATMG3u41gVM9pcuc5O1V/IRJgBGvfO+xpTilfU/V3PJdOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hfoYzyBJ37KsC4r5FyT7Zw2Tm3J8AyIuMZqnt5kRPdg=; b=a5BPnFHvkvuMB3vqRXIkENgc0b
 cJFPMik2qGBablsi2exX+9Y8sXRcTYA1b7Pd0SHVYeGCmmiskGfgcF8WkgffUzOOP2VNWagGKRPdl
 tsK/JDppkfUn/js9AQDwZ2sbAXEXFpkXQ+bc6ys6p0bGvcpAyInIIKf+uN7Qgan7buyQ=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xH1hm-0006eF-6H for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 16:19:50 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 d9443c01a7336-2e85fb35300so6791225ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 09:19:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791994784; x=1792599584; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hfoYzyBJ37KsC4r5FyT7Zw2Tm3J8AyIuMZqnt5kRPdg=;
 b=F1geV1/FZm7pstaWIWDtYypstlMRztwi+BiCjJNPeF+m+/PU03WFLkKH9oL8upO9Eh
 ZIBPpn443a07IYEmpc7/ikHOnrsmMMTN1rmiRQ5qP2SsJErxahYUu0nlKkWsFSraMx37
 amjDFrL+5TFGQz/BzcwBddjOuGfYi9BDac5+CUWiWPzKheuPuSRos6CrhdO2WQuvUhoP
 A9pQA6d99f8IyL5grw2KW9LCnw077wzLduTD9YAvSOitHmVr6UfxiqKYTyYKVMZS2XtV
 Quw4XiTZulAg7EByZGGZCTkkVBj8R/3QolhuU3vKT07aSqxQHti6WLFT5j/H4U4vzQCp
 onTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791994784; x=1792599584;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hfoYzyBJ37KsC4r5FyT7Zw2Tm3J8AyIuMZqnt5kRPdg=;
 b=w2EOhzGpLcDGJGCHWrLtNly7uFHwTVs3RIyMVkFHqFiKqa4lTohA7mYwlCp0AL8hyD
 hrC/rE4iGBfo/L99al+mZ5LYvxRXmyTqk5eB4q8cPMpMMGSQsMY6kVr7UaFWOuJprq2z
 e4QQWCNkah6ybddbadfvzrYPlX+gCYe77krpySbzxEjAKjTudTxKNIS2v90DuVWWeZZV
 8LkEVnBMwkCXqUubHzsSBCQsKxzlyqRh9icEX9uA8td8G1mACT9NqFCQ8HL7rsMjLOer
 kBehrOOpHitab+xhY83DltqVxC68Bbwhn0ttSlGguHj7C10jV9M/d6196HkBWOFv+1z2
 nMNg==
X-Gm-Message-State: AFq9FYKYWjmLfF9AcV3um659W5e253L5mvBDU+sy6OTs/3A51gUvteni
 ogcsKdFCzHK69C+4sUBBk0LEyvkkViL/AR/zSDOujab18wDzCyqe/apesG8EyPaf8rA=
X-Gm-Gg: AYBFou3bKjLpZywpoaTMo0Ijv3y27y3vkxin7bMo2k4DmUpSj19rOFrLTceHlOM4o5a
 ZnbsWIXqU9Qi6Ptn8Icv+dulo8YFquHDFWnALP5NrrqfLbGvUiSG3rjf48C9P6tFWOQah4yFkNh
 xxcYXeywyRkaI5f7L+FMxxT838FKC2pHDpja4cvE60zVy4zpnPEhnG2ZE+tjmva1sx5+0mjpaMD
 FzjNlgQm1P4rhjWvZWmVDvcNVS806TB7iWSr889qtLdNw8xX9Ser4l12dqpVagk87YzYEl9mGke
 YzKUiLutUNDb6hYyKv9gQmnkbUYDp7U7B8xLzUrAmePG+gnX8wMoBDTamk1l3aUWBhAulZngHJS
 x0XLPqF4GRQ63ndaebSwV4NUGJZ66K2WPuy2NQ3a588qQCbi+LxHc5sZpiXWRFHe/KU2u9jUSrz
 8R/LewjNMNhYPlfgqf5qVjWJcOgR447p5ERCijizvhffdl9+NAPRCoa8sm2i0/Knv6/rSKcjUzq
 TLQSne40RxfNw+lXoE2LybfLPIIrv073Blr
X-Received: by 2002:a17:90b:3a48:b0:3a0:2900:f55e with SMTP id
 98e67ed59e1d1-3ab3ac697f1mr9042198a91.29.1791994784361; 
 Wed, 14 Oct 2026 09:19:44 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac94794dd9sm87190a91.12.2026.10.14.09.19.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 09:19:43 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 15 Oct 2026 00:18:35 +0800
Message-ID: <20261014161940.3831508-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-4-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-4-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xH1hm-0006eF-6H
Subject: Re: [f2fs-dev] [PATCH v5 03/16] f2fs: support regular file buffered
 writes on large folios
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sashiko says:
> Kernel panic (NULL pointer dereference).  In prepare_large_folio_atomic_write_begin(),
> f2fs_ffs_find_or_alloc() allocates folio->private.  Then it enters a subpage loop.  Inside
> the loop, it calls f2fs_balance_fs_folio_locked(), which temporarily drops the folio lock.
> If memory pressure triggers reclaim during this unlocked window, shrink_folio_list() can
> lock the folio, call filemap_release_folio() -> f2fs_release_folio() -> ffs_detach_free(),
> and free folio->private.  Because the caller still holds a reference to the folio, the
> folio is not evicted and folio->mapping remains valid.  f2fs_balance_fs_folio_locked()
> reacquires the lock, sees the mapping is valid, and returns false.  The loop then continues
> to the next index without re-allocating or checking folio->private.  When
> f2fs_submit_page_read_sync() is called, it blindly dereferences folio->private (which is
> now NULL), causing a crash.

Changes:
@@ -4306,11 +4334,13 @@ static bool f2fs_balance_fs_folio_locked(struct folio *folio,
 	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	unsigned int orig_order;
+	bool had_ffs;
 
 	if (!node_changed || IS_NOQUOTA(inode) ||
 			!has_not_enough_free_secs(sbi, 0, 0))
 		return false;
 
+	had_ffs = f2fs_folio_has_ffs(folio);
 	orig_order = folio_order(folio);
 	folio_unlock(folio);
 	f2fs_balance_fs(sbi, true);

@@ -4328,6 +4358,10 @@ static bool f2fs_balance_fs_folio_locked(struct folio *folio,
 	if (folio_order(folio) != orig_order)
 		return true;
 
+	/* large folio was released */
+	if (had_ffs && !f2fs_folio_has_ffs(folio))
+		return true;
+
 	return false;
 }
 

v4 only revalidated mapping and order after unlocking.  v5 samples `had_ffs` before
unlocking and returns true if the ffs was lost, so the caller retries and re-allocates it.
`had_ffs` is needed because the non-atomic caller allocates the ffs after its balance loop,
so a plain `if(folio_test_large(folio) && !f2fs_folio_has_ffs(folio)` check would loop on -EAGAIN.

Sashiko: https://sashiko.dev/#/patchset/20261013115621.968742-1-nzzhao.sigma%40gmail.com

Thanks,
Nanzhe Zhao


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

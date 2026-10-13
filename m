Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E95CCCC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EAmjcIbJGO9O3/qlgr5nMRUHaX0LlaG1cmivahRWQEI=; b=Q+JEWnTwPGcwu0D6HD86wF9NWJ
	gPxk6ew5bmfT37wxShoXwS4uPGkT36GpXpmEuRX9E+GkFagSbxA4vNv1g/7JP5SEO3gywFBM5/tHP
	FrVK5osSMuRcQEejfmry4uurpqlaviMkygpgpLrOPyJX25uLvqG0L0PZYTf+dR7qzY0s=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb7g-0003v5-BQ;
	Tue, 13 Oct 2026 11:56:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb7e-0003uz-P4
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=; b=js3usvM8thq7/evNXpYLJjVm6X
 w3G0mAbDQyK7sjcIoz0xSAQieKlh5w2DPqzQgxyKUeVC3NlWp6QYsdcotagOVanBUUOMQnLPao10P
 4ZMvzHnURxb7or/AUaYIhanOrS89oL1SaQ/aVUPwMoY++LDdC3wN8S/eV7zB4P6fwDU0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=; b=QKQEq/gnSw5rEZ054j86i0C996
 wXLW+/y53MoyUkGNu+/n/6OGDI/cFgqp3z0ATFW3bVi0/QxkAe4sj8UmsttVXi4ZtOrQW1ZQXE0yZ
 e7r6NuEXBZVcBPm6VbBAK2Jv913OiYnRW/PJbNekoZPTXFMgyvUB1sWNxXm4kDtxZHv0=;
Received: from mail-pj2-f1.google.com ([74.125.227.129])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb7e-0001T2-45 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:56:47 +0000
Received: by mail-pj2-f1.google.com with SMTP id
 98e67ed59e1d1-3ab39d38631so82575a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892600; x=1792497400; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=;
 b=T9G0oMYAgNNFXYUY+ZJkFPqllx32PoYrgg7mHNN9dKfmrbZ4DrJYzvxHNAAc+tDtz8
 LldcM6D2BjhFa7waj9+wJI/tbcxWpxSZPOROmADFPwKMBEIS+ry8rIVSC61IFPG1Tl8q
 j2LGCG/oVyJPqrVWvkvF/+9RwdMh9a1bSIPKnQeFgTMKiAhKPEhHMnWEp36bQbuEvjft
 WmIgblKvMgzInIiIvQOH38x8Nnj03BHliEFIYP+YwBpH9jUGFFOz7eTcj7CYiwaMa1P3
 Cj92jEJfYZ6scU1KXUc0klKrRzYWOQu9qtdTlwR6JKWh4vXq9TjqiFLWnGtvD8y0U0m0
 H9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892600; x=1792497400;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ggaf4ZWPiCf8BenJlAZtFehpccMR0Zs42ekbOs3yAZc=;
 b=KBRbnySp1GH4xoclgQw3vfqOE7Awwy1Y9tYQ8roP++dH5KzULiHUkhJf9/k0ndSuYC
 2TdbY1YA5MZH2/pzQO+fgWPkKRMIGsxppsOakWVHTba1ZBzS76pbJppC9OKqaxg+resI
 LLUgr3vaxvIiwVOlA4WTNP2y1+jFCGmfsbNywwcSf7+Gp+kRKJa7DIKHfkTBBBaLBcQ7
 vriu9zgnd7YOpLqBIy7iutVV9xd2s5iUGgH4iCb9YgPCDFA9wYdgSrLvBL4MN7VDbjT9
 X8yRpSGiIDHZ1RDX1gQSm3k8KqumjKw4KfCFIgIIgW0MrYzo9kMHfT+c9Bi+DqfQYGIu
 vwNQ==
X-Gm-Message-State: AFq9FYJxdX7bNBWnowlsqVz784+x7q7FpuVfvjJANV+Bse8+iRMhtNax
 wolr5Uh60qi4pjFFjTNZcn4Ga9cKa8jw2v82E4yNuI0/lzq1Tul3rYkJCW2hN20gT/g=
X-Gm-Gg: AYBFou3T8Q/BME7E95rBbxqHeBr0iRiOOOLKdHNPTbMOpfCb8AP6yQ+Es0+eSD3yprE
 sFotno6guU4vEI70Sr7GY9T1W8wRPw/MVkYw5H2hb6i31iPfg5DKE8b5aKa0/PuGI8vbMaa/UiH
 8F57H1D/EXj44+wq9qk/eXvo8ea4QX87giL8O09gMjwCM8K1LgS4pEXQz0AkgG64Jsx2U9TeBgx
 sID6hx9wUkSUwz1qi4aE36fFoC9TJz6KxeABC0DOY9kL6xJRXKNfoDMPmM/7rcuJ5eVcu7ajQgW
 +MrmbIWIDBN59N3COuhjGJEKY89MjtnOiyxVd05QN6xoo/NAAa3WSaCvsXJmaV61rqHXq4J/sI3
 EPwA34veagieC3uzrmmJuqfLme1apCOgaCRNhujAdnuDnQAj+qoAkMyXxE06qIEiG0pmX4UKo9w
 xbP6ZyfNj3vgGKCqZsHZ2R93JsX6VC7/PdBsAh+diSlA+OnQWoIF7ymA0A24UaS29W3R85aU7hX
 8PFlJxJOiPEbLZFUXvsC+Rdna7yUfSuRzI4
X-Received: by 2002:a17:90b:3a48:b0:3a8:337d:228a with SMTP id
 98e67ed59e1d1-3ab3a367926mr6555917a91.6.1791892600332; 
 Tue, 13 Oct 2026 04:56:40 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.56.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:56:39 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:05 +0800
Message-ID: <20261013115621.968742-3-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb7e-0001T2-45
Subject: [f2fs-dev] [PATCH v4 02/18] f2fs: remove mappedtodisk flag usage in
 mmap write path
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Nanzhe Zhao <nzzhao@126.com>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

PG_mappedtodisk was inherited from the nobh/buffer-head era.  However,
f2fs has no buffer heads and the flag is no longer meaningful.  The only
user of the flag is the "no holes" shortcut in f2fs_vm_page_mkwrite(),
which makes mmap write faults skip marking the folio dirty.  Moreover,
it causes the following race condition with filesystem freezing:

 CPU0 (write fault)     CPU1 (freeze_super)
 ----                   ----
 f2fs_vm_page_mkwrite()
 sb_start_pagefault()
 /* shortcut: no dirty */
 sb_end_pagefault()

                        sb_wait_write(SB_FREEZE_PAGEFAULT)
                        /* no waiter, passes */
                        sync_filesystem()
                        /* folio not dirty, skipped */

 finish_fault()
 /* PTE writable */
 fault_dirty_shared_page()
 folio_mark_dirty()
 /* dirty folio on a frozen fs */

It will also skip APP_MAPPED_IO iostat/REQ_TIME updates and post-EOF
folio zeroing.

Remove this shortcut in f2fs_vm_page_mkwrite() and stop setting it in
f2fs_read_single_page().

Reported-by: Chao Yu <chao@kernel.org>
Link: https://lore.kernel.org/linux-f2fs-devel/496b913c-eb81-4fa8-be72-c6a06a10aba2@kernel.org/
Reviewed-by: Chao Yu <chao@kernel.org>
Reviewed-by: Barry Song <baohua@kernel.org>
Fixes: fbfa2cc58d53 ("f2fs: add file operations")
Cc: stable@vger.kernel.org
Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 1 -
 fs/f2fs/file.c | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 29c4a81eb..f2d2f0106 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2481,7 +2481,6 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index fc959cdb9..d680f6f8a 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -225,12 +225,6 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 	/* wait for GCed page writeback via generic cache */
 	f2fs_wait_on_block_writeback(inode, dn.data_blkaddr);
 
-	/*
-	 * check to see if the page is mapped already (no holes)
-	 */
-	if (folio_test_mappedtodisk(folio))
-		goto out_sem;
-
 	/* page is wholly or partially inside EOF */
 	if (((loff_t)(folio->index + 1) << PAGE_SHIFT) > isize) {
 		loff_t offset;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A179C3A5A1
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Oct 2022 20:25:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1okWfj-0008QB-Ro;
	Mon, 17 Oct 2022 20:25:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <vishal.moola@gmail.com>) id 1okWfh-0008P7-8r
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=; b=NQB10Dm9rlvMYCeJO9dkYARsrg
 jcOFdbdCpd4uskB3KhdJurSCtUQoNZrUz61atkq3UlefUTZtc7xnEqPqrxow3aV6nZCsJMk/8yiZ0
 MJwFy47wwH53lZgltLLBLhGCtsh/aBuiOZVCy6nEXXjwlzpjW8DVBsvqg/ZtaRSkbLxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=; b=NPfP33bWp2ZDK+HqnQo5FCm2th
 YU8MVNfB1uRG68jLbgyHVMJPKmbYTPN1u8MuvldrPUJRjmYaLnJ98aQaFjRn518yD8c9dHUIjT9M/
 nu8b2224soOL2ZQvRbE4TSHHORFAIlPJ3fchXufoPk1D9Qj07x0Xir78v0Tf4kOJS8tk=;
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1okWfg-0008SH-62 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Oct 2022 20:25:13 +0000
Received: by mail-pj1-f43.google.com with SMTP id
 n18-20020a17090ade9200b0020b0012097cso163498pjv.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 17 Oct 2022 13:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=;
 b=AAaBUf6AYZwl2VDHcCjIUHoo+BDNMPnV+R8K7xw03ITt3bJu/PXwBptMp+Cd78GqHp
 N1fPmeaEcgT0dNOi5heH8RkIvQzLgdDjFTLLFkJTMuZtMzDzhqm3A5e2TUW+009WVhvP
 LnQ+Qnxue4GNQ/W4GSqfITdI/xtl/FcZVOsSAxzDrhPsnLCBNI0Pam1Vx851IlCokycW
 3ihi+TyICcYVO2geBMteJjeyBoyopJkqhfYcH/Zh5WCo+KIFfIyQ0WkYt52MgC2bUa65
 R8/gksQ//p7O7voqbBaQcC5j/XMc08BKModktLu/0bF2tT6gRFEgGcvAeXRPf7IXx8T9
 8+gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VPyaEfnfsN/s28KIqk5JK9av//7f4plsWX6QMWBWYvw=;
 b=0VL9IYv4xg1FHry3TitXQk8KnNnVhT5f/FRni9NPi9+FsTaV6qx15ngbXL8g6Rrgsn
 HoKoIO9btPQRBkQLV7j7IXaY7wt2KYaKfL9LKCybjUgy2DHxOj2XUy1TBgE5cohuIFAV
 rLoZocy/XYYctXskAYO70Qri0kb0LoBn4pFOjQfgibk1B/Rl26ZBiaKxjQ8EbnDTp7dQ
 cYYdPYblHaK2E4D4Rgi4O6vbqQRChEc0qMjCLfqlOYh5Vd8bbV/T1yW6bA8lEmx9+Gn5
 3OctklMB0Y1vYF9hiOCXQDM0UcvLKL261InzRxkbwSFKcSE/Ov5sAgyFLIay9xx44dRh
 Lx0w==
X-Gm-Message-State: ACrzQf3gGT7BmYJatL90gwAegn8iMp3oBUVFEs9nitYIyf1EnI1pwk1v
 8Y1MyYF2EliIX5LhNVsCzzOiWgMHEXo++Q==
X-Google-Smtp-Source: AMsMyM7v1A0Nwi1EfmmDwlAxUHQ5Y+/Mfh5CmuQv94z7lhNxS6TEescrW3W2GC19QPdRPdkxp8Fsag==
X-Received: by 2002:a17:90a:4216:b0:20d:2891:157 with SMTP id
 o22-20020a17090a421600b0020d28910157mr35557408pjg.47.1666038307198; 
 Mon, 17 Oct 2022 13:25:07 -0700 (PDT)
Received: from vmfolio.. (c-76-102-73-225.hsd1.ca.comcast.net. [76.102.73.225])
 by smtp.googlemail.com with ESMTPSA id
 pj12-20020a17090b4f4c00b00200b12f2bf5sm145037pjb.1.2022.10.17.13.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Oct 2022 13:25:06 -0700 (PDT)
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
To: linux-fsdevel@vger.kernel.org
Date: Mon, 17 Oct 2022 13:24:41 -0700
Message-Id: <20221017202451.4951-14-vishal.moola@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20221017202451.4951-1-vishal.moola@gmail.com>
References: <20221017202451.4951-1-vishal.moola@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1okWfg-0008SH-62
Subject: [f2fs-dev] [PATCH v3 13/23] f2fs: Convert f2fs_sync_node_pages() to
 use filemap_get_folios_tag()
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
Cc: linux-cifs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 "Vishal Moola \(Oracle\)" <vishal.moola@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 cluster-devel@redhat.com, linux-mm@kvack.org, ceph-devel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-afs@lists.infradead.org,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Convert function to use a folio_batch instead of pagevec. This is in
preparation for the removal of find_get_pages_range_tag().

Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 fs/f2fs/node.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index a2f477cc48c7..38f32b4d61dc 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1935,23 +1935,24 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 				bool do_balance, enum iostat_type io_type)
 {
 	pgoff_t index;
-	struct pagevec pvec;
+	struct folio_batch fbatch;
 	int step = 0;
 	int nwritten = 0;
 	int ret = 0;
-	int nr_pages, done = 0;
+	int nr_folios, done = 0;
 
-	pagevec_init(&pvec);
+	folio_batch_init(&fbatch);
 
 next_step:
 	index = 0;
 
-	while (!done && (nr_pages = pagevec_lookup_tag(&pvec,
-			NODE_MAPPING(sbi), &index, PAGECACHE_TAG_DIRTY))) {
+	while (!done && (nr_folios = filemap_get_folios_tag(NODE_MAPPING(sbi),
+				&index, (pgoff_t)-1, PAGECACHE_TAG_DIRTY,
+				&fbatch))) {
 		int i;
 
-		for (i = 0; i < nr_pages; i++) {
-			struct page *page = pvec.pages[i];
+		for (i = 0; i < nr_folios; i++) {
+			struct page *page = &fbatch.folios[i]->page;
 			bool submitted = false;
 
 			/* give a priority to WB_SYNC threads */
@@ -2026,7 +2027,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (--wbc->nr_to_write == 0)
 				break;
 		}
-		pagevec_release(&pvec);
+		folio_batch_release(&fbatch);
 		cond_resched();
 
 		if (wbc->nr_to_write == 0) {
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

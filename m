Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41037606A327
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=gZl2QOyE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Dcas+H/b;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=BnJEAl4l;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P0liRovC
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=nNwWkFremBgmMaBh7JcVyYWDX9DDgsgX5MXHqemv9XI=; b=gZl2QOyEn3aqkLwIuPglQ56fSz
	tbSq86D07vjbfZw3Ff+xTQKcxYXiMVpxS00aKW4ihYOpWEwjzd+tDXH0ZGv9Wgb7GTXYLGBPehzGW
	ILZLIm6kgPKcdatpcvnGV1KcE6LIxLmDxmJPxatJFoqjq3pDCLvM+/GLavIVOfP0Ftlw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu1-0000000044M-44vd;
	Mon, 02 Nov 2026 19:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtk-0000000042Q-0fSD
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WmRV8Lulw5LNOQLTu7BD8oJOuHGimi1F0Mal97dYcpo=; b=Dcas+H/bPPVR6dl6l+6I65wSEn
 t0l4mPPEzXi0g2RqUJuPEPgpJ7wnaBHHiAel+SsBvD6k6ESjJmoDyytNLNFe2tKIPYQGbGwExtOg+
 fWXuPShwlQyXkNawzRpH11wwvhzbjADpc2lA9EwcrLXMLHMyPCvv6uwtjq7cDp2HdoFQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WmRV8Lulw5LNOQLTu7BD8oJOuHGimi1F0Mal97dYcpo=; b=BnJEAl4ltorhBvG6RCdFKk1e/w
 0c0OjMDPoAAu2po9flnVeo9pkfgnJOxo7e57fIFMLP7oHDLRp+qj5xaZsOy5+ooMS+k4b5KGavtbB
 LjXWlChEy9Xh9MXkmIKAJMMzqdrOiMX094YARs1gDRzf7X4aYwm8zZRJ+q8AO5bGUe7A=;
Received: from mail-pf1-f182.google.com ([209.85.210.182])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtg-000000002EX-0KRG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:50 +0000
Received: by mail-pf1-f182.google.com with SMTP id
 d2e1a72fcca58-8a0673d9bd2so1980531b3a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648442; x=1794253242; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WmRV8Lulw5LNOQLTu7BD8oJOuHGimi1F0Mal97dYcpo=;
 b=P0liRovCIfiOuLBy06nghcvKwDFJlq3yPYPk7CMcAsxg2EH64Qu41+/UMUt8uiriTy
 F2/IsJJJMN3Un4OEmzuBFjaGL+JRFy+sb6zjwk+bovmY1afWlx9wDZJk/3UV0m7cdwPI
 Ljzx/Evx0MZh0eVIyyMIuJg3b9BtqOu2Z5q1PhOi7ZEYifbhddm//2jeRLK9mwcx+JRY
 fnRirq3TUJPnCq+x0H9bWpiZXq0Ap+m2NItm0PYzVuU1OoUFJ9zIzvDYHKYR+NSQRMak
 HIr+HvsOBSECq0CrdSNIw6c53qVhDIA0MWy7hSdN9R9hmBe6bA6u+6A8HTejsg0crHqf
 bsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648442; x=1794253242;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=WmRV8Lulw5LNOQLTu7BD8oJOuHGimi1F0Mal97dYcpo=;
 b=DwQhKJuWrr89NxdXTPoEkkjr0blGbKKrTRuDnHkzRSE/4kuxagMYAe3BioH9Ff+UTX
 eQnKzwGy7pSZbAdebV+lIQ6WCvCTEWMnAjl4L8zNrG/8QpsXS+d7OG/Z4uH4ksgeKhGw
 8DdtbEArN5BlhWnTmg1Yak0jTWRFqZuEjKw7UF1TGtYK/dVmwxkHfLODwyD6Ei6gIDIQ
 ArIqsWAjje6tVP2f9Sam30ROXw08sTkfwPTOG+frHtK5Xbx+0xAl+xEiv9AWeDQFY37J
 RhI1PkQtzWDS2RdKT/MfedX/mE7wrpMv3gOmR4X/7hiGj6+p/1caNOa5URKVCieamdrq
 ZnHw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwT1MZnvHZ0OVZJxUd1jy9zlBem8+qj5qAHdQrXUlOMeXv9afrtw9fH6FjJzDKOFOxyCiSQdTvI5wmy4/j9QHFE@lists.sourceforge.net
X-Gm-Message-State: AFq9FYJWeyfmC4Ov4vWYiNMD2FeFTxhu9TTPySJY+4Lc1UJ5vR4m4hdZ
 xUonx34R8P7TSMb26fhZe0Spxl0yRkr5z6qJJLuRfU0YiIddqufzhHCL
X-Gm-Gg: AYBFou3Qqe8a+WqbbFWbzDkoRB557Cjxqb5iIMWXKB3AtxplVZSnxqLF6itk/Z7xqjL
 ePITAfWUCI4MVL4AzzCsVj6xw7MvYBCJIV8AeiLqX7x7h5UVfpYhDRMfYflgIY8nt7yR94OEPsl
 IhvhV/0YEz9cRXPFE1nGAc8mnk7NaKFcWsXO8/OGOWJ0V+I+VoZSzZVrnyObDga4AXcOHEzuuRm
 PeO5VFm3lA5qCj3gVqo3sIRzeU36UhjImE2Pr490rIh0oXHc16qdb3a+8MB1MXAOrlYeVcAZxXR
 Idzu800pZ06ecGQZ033QQh69XEsxbCSRj92gOp1ZChAxf6Pn8zVwPqAVcekLk7qFipSbp7d7Fk6
 /iLNR/HGWcr0ylTUdVIgbcPiXk3FZwRciZMQM2TcGadAwEWKAIB4HwEvMMu6C34PSpZAOFIVvbD
 O5UdQ5xZOWgtoorzs0LM/DRwBb9UKCbk5EBOAg84QbPS0VCSfFw0l1SlwZ9xPVOaLGYx2XQz0++
 W5UTbrNBnVD71JIE6z6ZRmI4oajxgdL43RxNhk7vlJl2al50DYCFcj9KD28lrsgty2Xwz2KfGsH
 wft5v7v+kyBzx9SQ+mXP+SclTm5MD+gXrDePBB/BbSoW4FBg+htFra2N3MtEw/HW5gHLvaIMwxw
 vanJSM3EHFkhh2tlzWYDCEdffnExYnhyXXouznr8bPidXHA==
X-Received: by 2002:a05:6a20:2583:b0:3e5:904c:78d3 with SMTP id
 adf61e73a8af0-3e928aa2158mr9992774637.69.1793648442324; 
 Mon, 02 Nov 2026 11:40:42 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:40 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:51 -0800
Message-ID: <20261102193952.3002018-20-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtg-000000002EX-0KRG
Subject: [f2fs-dev] [PATCH 19/20] f2fs: count compress cache entries in
 pages for its memory limit
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

The compress cache holds one filesystem block per entry, but
f2fs_available_free_memory() compares the number of entries with a
percentage of free memory counted in pages. With subpage blocks, this
limits the compress cache to a fraction (block size / PAGE_SIZE) of
the memory that compress_percent allows. Convert the entry count to
pages before the comparison.

No functional change when the block size equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/node.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index b95bb5c27b0b..66b28ae91756 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -116,10 +116,12 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 
 		/*
 		 * free memory is lower than watermark or cached page count
-		 * exceed threshold, deny caching compress page.
+		 * exceed threshold, deny caching compress page. A cache
+		 * entry holds one block, so convert the entry count to pages.
 		 */
 		res = (free_ram > avail_ram * sbi->compress_watermark / 100) &&
-			(COMPRESS_CACHE(sbi)->num_entries <
+			((COMPRESS_CACHE(sbi)->num_entries >>
+			  F2FS_LOG_BLKS_PER_PAGE(sbi)) <
 			 free_ram * sbi->compress_percent / 100);
 #else
 		res = false;
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

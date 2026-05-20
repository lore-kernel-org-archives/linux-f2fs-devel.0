Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1694CD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 09:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=qVm57Lfd4N/mutJ3pPtdcDgA/kZ1dMWuJNnFTlEqlZM=; b=llEykCNSehd7q3k+FlZkcmKR1Z
	fad6EbwYhCDptnvXysd7U2z1R5hRQlT+ICqvqEtawwuWsyk1ogTI1C8FOd+bwD6tBSByifzg8TNag
	3cFhqepOUEIiYud0XbbWiX6WXzpLj3IeK13fjZxErCGs3+gTSw2JF3kkLzRKglj/GvpQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPdbE-0004uT-A4;
	Wed, 20 May 2026 09:52:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wPdbC-0004u9-AE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 09:52:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V6OcltrWyb15hOrMY3XyGG9Zyef0yGghWRp06lziU4o=; b=BciVYIPn7O3lCrn5FyE1go09U1
 yUHaStuT/GKjoJ9zttpgxsWlkRr8vMSdPn4QlAHQUknn87tHqV5McGrOblKSgetqAySM3TaYyc8o9
 rMSivw/FG/8OyHi/E4vzSNfWSjVF2Vun0uCt2K6csSKU6UXgCMF7qFVQtMAkrPLiE/+I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V6OcltrWyb15hOrMY3XyGG9Zyef0yGghWRp06lziU4o=; b=a
 eI0bytSwVEnVCzr1ZlroD5ag9NNWot2uRxNQY05b8jOE6lA0SKVV/eogwnaGaQO+APMpGaNBBSyWC
 lvr+WA/RcltXRxVttkaOqTUMgDG10RmCGs+6KMaTproq/LmQrlvnrV6j+0sZy8Eg9AJPV/2hGZcyn
 6Tf3C5evLqCbtuNo=;
Received: from mail-pg1-f181.google.com ([209.85.215.181])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wPdb8-0005hv-Cj for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 09:52:23 +0000
Received: by mail-pg1-f181.google.com with SMTP id
 41be03b00d2f7-c796163fac5so3949686a12.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 20 May 2026 02:52:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779270733; x=1779875533; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=V6OcltrWyb15hOrMY3XyGG9Zyef0yGghWRp06lziU4o=;
 b=OyyKtUr71oytq1XKrwC/TTH+/9F7a5W8rx1nwYDxSP4QZHR4U41VzjzZtAHE9B2WaA
 wUEUzj/IY4XZwHmcyqBToeLWGjRoZH1RA1e2tVKo/BhLBMxFDuD7vCbgJd3E163OWOcO
 gawTIcRUFIDpJ8FwKgk28+Vr59h/Pc20R6Sh9BhCKkVQXV2IAmgjh2LHshwwMDyTA1Jg
 IV+NczokwvcGfpcvfqCGDNsyxMEKX0TV8Pk5yOvOKvn2vds05ZMR1asU+mgLcPd+baAP
 lgtmmERvt2QSD0fsLuID8QmtEIZ3qwrquPBZov4eeKp7cVOfuOFT9O51b1HYFQg2mkBN
 kBUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779270733; x=1779875533;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=V6OcltrWyb15hOrMY3XyGG9Zyef0yGghWRp06lziU4o=;
 b=ZgMfYGFz1VyRVgIz/wbVLT9GIBgXA9zrK6WEKmHD3DuVPqBPvaLeWEdRjV69akmBfb
 6ki0lYTmL0FQ8UoXistVtkLvHQ84hJLTaPyPx7Y/PX2/3SRxhSap+YAEjis1Far0BSNW
 u4u6PZ7Qerxcgh4xR1eYLjo7jcK2FqBooyJNjvM6YSlOVlMKOf/4ijDmA3jyO0vHzTPX
 EsWnvaPSqL7airGH8Bkq1lmJvDjzo/+V0UfyVhdLEyqoolVHC5k78HvymqcTALUzeuNF
 2RuT+Xe+WUIfsezS+JSISJHbifPlrC60/B3Q5F5qM3TTQ+z/06qXiQieC70jGvi3CLJU
 nTUw==
X-Gm-Message-State: AOJu0YxT4wtSL5qaXl7L5op6tGBgnY5z1vHEnKTSU5p1hJtPGWOlhERz
 6cew4ThzEaUcDl/Y8BbB7p/0hDZ5obNOA2E2fM4Lwl3dPaAwJsykF1MB
X-Gm-Gg: Acq92OH5c2nebLrn8pevyO9+j6jep0m0hykWzSNCueRPAxF/kUrV3zpQ+gZngI4gxY1
 6KNdp5w976zlAIur4qphv3xreo45nokzcbo8X5vTI/GNb3MwDMM9YX0hoizb1RX2IdC8q1zsc+G
 rtNOyNWFgsb1MA+XhB7p1x9g7Ra7GG4TTz0SWs8nrD3M9xM4QQNU1llSIuoyGBNqaNc8jY+ccGT
 uN7nNmmwI4Qb8BJALeglTkgnxHS/MNZDvwAuUjCzeiRDyuIeYZeHHdbVgN5Sro4dxZXVUPPEvIt
 yzW6IPkZYxp0yuM+7M14DvO7VqPN2UsKmL7h3XvgJFRt03JNl8wSZ/OeVIt5VJKNKNpqxGIgtn0
 wuwsNSaZJ6AsSpuQzc/CxLhYcxZiurm6P7ljhlYpv6AJHH3P1l4kPMDn9+Ydk0XeAR9O4qvAsRD
 A+B2UBsLFGfnK8U3LJb3589rPuwwfLTeX8Hs7VNmlMgkApVfmCfespqXWozAScN2jNgc0=
X-Received: by 2002:a17:902:f08d:b0:2bd:2051:13ed with SMTP id
 d9443c01a7336-2bd7e87ef1amr164409155ad.23.1779270733069; 
 Wed, 20 May 2026 02:52:13 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5cfe498asm218656325ad.39.2026.05.20.02.52.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 02:52:12 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 20 May 2026 17:52:04 +0800
Message-ID: <20260520095204.1175117-1-qwjhust@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1wPdb8-0005hv-Cj
Subject: [f2fs-dev] [PATCH] f2fs: fix missing read bio submission on large
 folio error
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Wenjie Qi <qiwenjie@xiaomi.com>

f2fs_read_data_large_folio() can keep a read bio across multiple
readahead folios.  If a later folio hits an error before any of its
blocks are added to the bio, folio_in_bio is false and the current error
path returns immediately after ending that folio.

This can leave the bio accumulated for earlier folios unsubmitted.  Those
folios then never receive read completion, and readers can wait
indefinitely on the locked folios.

Route errors through the common out path so any pending bio is submitted
before returning.  Stop consuming more readahead folios once an error is
seen, and only wait on and clear the current folio when it was actually
added to the bio.

Fixes: a5d8b9d94e18 ("f2fs: fix to unlock folio in f2fs_read_data_large_folio()")
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Tested with a local-only fault hook which injected -EIO when
f2fs_read_data_large_folio() had a pending read bio but the current
readahead folio had not been added to it.  Without this fix, a 256MiB
immutable file read timed out after 20 seconds.  With this fix, the same
read completed without hanging.

 fs/f2fs/data.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 8d4f1e75dee..836edb7899d 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2495,7 +2495,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	unsigned nrpages;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
-	bool folio_in_bio;
+	bool folio_in_bio = false;
 
 	if (!IS_IMMUTABLE(inode) || f2fs_compressed_file(inode)) {
 		if (folio)
@@ -2611,18 +2611,17 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	}
 	trace_f2fs_read_folio(folio, DATA);
 err_out:
-	if (!folio_in_bio) {
+	if (!folio_in_bio)
 		folio_end_read(folio, !ret);
-		if (ret)
-			return ret;
-	}
+	if (ret)
+		goto out;
 	if (rac) {
 		folio = readahead_folio(rac);
 		goto next_folio;
 	}
 out:
 	f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
-	if (ret) {
+	if (ret && folio_in_bio) {
 		/* Wait bios and clear uptodate. */
 		folio_lock(folio);
 		folio_clear_uptodate(folio);
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

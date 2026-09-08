Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2D20C79F99
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2026 03:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D010T1m91IkrSuUgom2K25Qd+M4Jpn1Rw3j5uArTWD0=; b=L6LtE6pVno5F/k6xQ4ptqr/27+
	uJCedyBJLrBbC5duEDYCiuxMkyG5SBYp+14h+CqTU2hRp5XOeaWl/P52yQ/oyFlkrD1FhvlwVq219
	M+0NSJMLM4EqcIt7UAZSC+tCG8M0WRO2Gc+HG+p1MXA12/0vEdKAm9J24AfPP0P+OgoE=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3mwJ-0004y4-AE;
	Tue, 08 Sep 2026 03:56:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x3mwI-0004xy-BO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:56:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=; b=P50Nw41fET1+CyxRI/2bjL//Pg
 I8MGUwfJk4XWaC8YbJ4ulvLf0kqZJilCeDWhmcI50h1hFr8LGS9uwvAzBc3R9VVqGvgpkDFGet6Tj
 vR2ULn/CHduIVXbcPEOJf1s8TP0MMroKEmzf1LJQHrxnMXAjiIowFcq+9rl/wozVdQ1E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=; b=QTe9awRwYLhEZqgKpYayt4DZu/
 EEVKOotYWFH+Ge3aS/RTqGjdfTGRGpLx2jsu7/itQWIRjt459tfgMi9hFyIlg3fo7p8t3Z588MqsP
 wZYCIDEG3MQxveedI9yZHgPOWspaF2D7BVreAVvbnhQZPN/PO+Ch/JisQl5ZPJiC8wKY=;
Received: from mail-pl1-f182.google.com ([209.85.214.182])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3mwH-0004BF-L8 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Sep 2026 03:56:06 +0000
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d8f265cbe6so31488685ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 20:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788839760; x=1789444560; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=;
 b=WF88WBVnXcSRStKD8eLZR/o4d4kScSlA0CON76arggZenXcmx4V1CTsKYyQiMIQIjI
 n3hCUOhI5XtwD6DQHc/k3ruhYTVWvVV4VwCyDgFPtjOBGl0ik0pPtPxWcugW8V3DQofL
 mEUQIBLHf5ag5/NZar6QXEr/YpSP1xOHD0DM8w1C/LYdej6Po9+y+nKf1A/djbJOeuaU
 6LLoGddVAdMRZrM/GMVTO5g3DDJRA3xza/cKI5VNDIhppr670QYmTvIELylFs+CxkvBG
 izaR641OObYJswmVXTWBmXRsDrGPZoOdnAWu6axczBQdnTlj9I7FhwyHrpdHCv657WUd
 ljPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788839760; x=1789444560;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Sz3IhUKKAL3B7/uUvafH5XnIQ+JFZCBkf/MrLLBgC8M=;
 b=ZSGEgl6x/+p3tpHN/RtZe87JQaHvNs6W5Rii+5vRfr+c2CutmX/3aLpVbaBKx7fD1h
 o7F1/2L+Cm6mI8MlUpiS1XRLny8MA4rzOXLgicp+lLyasn8ARtlMpv/iF2JjucEgsGt4
 sXi+rLCtiT+YpE3delwE52En7/KEd3kcrbqcqpvQ3P8GRHXRYWs8kF32H3wU9RD+35Yd
 7WkLPS9fEuTAngaPSeHV7r5X29jiFN0ufQEe/iYKhb+GDi57a1DkxAV2W1fJ0rbj+nIZ
 3uCN1RBNQV3stoCSer7wjlhorLCX8FZmni1tosVkDamS2HRXKh566AEIEdV4Y0eR4rn+
 Km4Q==
X-Gm-Message-State: AFuF++mskhbWS5mjd0hPyeJhX/fRBR/13R/8agXHTjmuMSrrH9AnzQ+q
 O5qNlMgxvDLPz3VLEco+SbX14wgh2jKQ59zksPpvKBpm+YTymPk7UB/m
X-Gm-Gg: AYBFou2PFmO5Z2fJkTd8pdAwB8w+kdNSfB6+FFht7ItbL0TnYNoNsagsUf7Ov3qWB6n
 WNfMgCZAjgCx6pNDNCbvB2Qhgy35Ak+KWcWqSqx9fOn2WkoMcvS0cGKFpFe0vgAPrODYb7DEw3S
 6I4VEahjk3g+qKnEElTxninA3IdwiSZNVC4WliLnpYXkO3OWztRpLJtppc2sLeIy7r7YGJtJSnu
 HK0cYcnYkewr1jUz7M3A240kB1bBy/3h5fwhUoamnTmyOFmuM888WfgnXZApc+/GHWRyAPxCjhj
 /VTmdcFKSeBWldMtkdJGJoEUtKz73R6d4OtsMTpwZ6oEt14eg/OOhGEDtkHxezwaTSQC2IP1hBL
 TQeHcbUnXTVRCQYURY5/iFiILx8GOqND8LqiESlblv2k0ZH9cuxwSHY+kJrpDxLG1wK4sC6iY+b
 pDRmMEEdtjaEJ5gXp7PnRgqbbJ/0EzlRq7qRFMU6TfuEbCVRzi6DrjGZhaCknYleg9gZExICsmx
 /lnszd9btMuqFDwLNQ8kkgmfU+Aud4vKaA=
X-Received: by 2002:a17:903:22c8:b0:2d7:5ebe:a588 with SMTP id
 d9443c01a7336-2db126d6e31mr380270745ad.13.1788839759881; 
 Mon, 07 Sep 2026 20:55:59 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2db14aeaf74sm51899295ad.81.2026.09.07.20.55.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 20:55:59 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Tue,  8 Sep 2026 11:55:42 +0800
Message-ID: <a3c3c000656d3655512c979d2b0c803ba4ab2f99.1788795700.git.qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1788795700.git.qiwenjie@xiaomi.com>
References: <cover.1788438786.git.qiwenjie@xiaomi.com>
 <cover.1788795700.git.qiwenjie@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1x3mwH-0004BF-L8
Subject: [f2fs-dev] [PATCH v5 1/2] f2fs: complete dropbehind write bios in
 task context
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
Cc: axboe@kernel.dk, baohua@kernel.org, jack@suse.cz, qwjhust@gmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com,
 linux-fsdevel@vger.kernel.org, tz2294@columbia.edu, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Buffered RWF_DONTCACHE writes invalidate dropbehind folios at
writeback completion. Mark these bios BIO_COMPLETE_IN_TASK so the block
layer runs F2FS completion in task context when needed.

Normal folios can safely share a bio that needs task-context
completion: they do not carry the dropbehind flag and are not invalidated
at their own writeback completion. Follow iomap and allow otherwise
mergeable normal and dropbehind folios to share IPU and OPU bios.

If a dropbehind folio joins an existing bio, set
BIO_COMPLETE_IN_TASK after the add succeeds. Classify the original
page-cache folio rather than an encrypted or compressed replacement folio.

Keep the existing large-ATC completion path unchanged.

Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
An F2FS QEMU A/B ran 80 untraced 1-GiB formal cases: ten
counterbalanced pairs for each OPU/IPU and 4-KiB/64-KiB profile.

The primary write-plus-fdatasync mixed/segregated ratios were:

 Path  I/O       Mixed/segregated  Interpretation
 OPU   4 KiB          1.133       Mixed was 13.3% faster
 OPU   64 KiB         1.021       Mixed was 2.1% faster
 IPU   4 KiB          4.469       Mixed was 4.47x as fast
 IPU   64 KiB         1.063       Mixed was 6.3% faster

A separate 64-MiB IPU/4-KiB trace observed 16,384 segregated DATA bios,
all 4 KiB, versus 117 mixed DATA bios with a maximum of 13.21 MiB. Deferred
bios were 8,192 versus 117.

Changes since v4:

- allow normal and dropbehind folios to share IPU and OPU bios;
- set BIO_COMPLETE_IN_TASK monotonically after a dropbehind folio is
  successfully added to an existing bio;
- add focused segregated/mixed QEMU results.

 fs/f2fs/data.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ebb0275aa8f..fc48a752fe9 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -503,6 +503,8 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 	bio = bio_alloc_bioset(bdev, npages,
 				fio->op | fio->op_flags | f2fs_io_flags(fio),
 				GFP_NOIO, &f2fs_bioset);
+	if (!is_read_io(fio->op) && folio_test_dropbehind(fio->folio))
+		bio_set_flag(bio, BIO_COMPLETE_IN_TASK);
 	bio->bi_iter.bi_sector = sector;
 	if (is_read_io(fio->op)) {
 		bio->bi_end_io = f2fs_read_end_io;
@@ -865,6 +867,8 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_folio->index, fio) &&
 			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
+				if (folio_test_dropbehind(fio->folio))
+					bio_set_flag(*bio, BIO_COMPLETE_IN_TASK);
 				ret = 0;
 				break;
 			}
@@ -1100,6 +1104,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		__submit_merged_bio(io);
 		goto alloc_new;
 	}
+	if (folio_test_dropbehind(fio->folio))
+		bio_set_flag(io->bio, BIO_COMPLETE_IN_TASK);
 
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

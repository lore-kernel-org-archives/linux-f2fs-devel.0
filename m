Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4DE0CC6B1A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 11:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=nsjBUu5YaNHQmpmO+4FOea9ETRsWXWIZuhbTJEVPR1o=; b=UPdC3wBpvPy6LlcqoqrLjQr2Yw
	CLzJlgu/XpvKSUaDB8staN3/zfGDAZOOBj3hNGI01usQNKSaTo5KeBb6EZ8ftIxYrIz1fMwS0y0d9
	2dBMjMbeKXezCfl0ZdsUDACfpPCNVif1zj+GGvOxvuOQ0Ze2gSza9eUx/UCdOpXcgRZw=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGx8V-0008Gg-3d;
	Wed, 14 Oct 2026 11:27:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jsjlee1020@gmail.com>) id 1xGx8T-0008GY-Uz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:27:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Q1TKQk69KHcjaDb24fEb/peTLu9FmofWYrxae6HA3jA=; b=NAsWiMT0RWWkEt0T1kvttOVkuQ
 BRTfVyZOvoOu3N9BuTPnKw1A05zmEZnkvcCmIrhOAEi7eqGKuoPouBUPqjnXo+EX7iUeoGlcUyZct
 l3E6wEZKrEvoETYzvj3G0QCvaM2TMIrKtbekpX9KF07sby4OdkkjETvnh6iEgwNTqUQw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Q1TKQk69KHcjaDb24fEb/peTLu9FmofWYrxae6HA3jA=; b=D
 J7TeSuFwjYnDbANsxrrS5Ly6Sbu+91g1p4lP6Q34bHkzdU6cHpcCUl3kqpTQFCSWDF1e9JTpJDNub
 5flX0qM8Bn99m2y64X6OtiD9ylC32+x27wZwlXG54eqWQKRoca+OrytEsQ+D/zPIxPHK8uwARcBlX
 m7WMPLX3YXQmY9qQ=;
Received: from mail-pj1-f42.google.com ([209.85.216.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGx8N-00046T-A2 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 11:27:03 +0000
Received: by mail-pj1-f42.google.com with SMTP id
 98e67ed59e1d1-3a813079a55so3458936a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 14 Oct 2026 04:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791977213; x=1792582013; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q1TKQk69KHcjaDb24fEb/peTLu9FmofWYrxae6HA3jA=;
 b=a7q7V2ia7LJAwjTCPYKKcEze7EtN069XngiHmqlHKdZL0gPJEA3TwSDlyhmhfnbLRf
 RfJvFpln+WpcxsZ2VsCaJTrwLg6vi3JERpX3DxIZ0woq3Zy8XbR17Gw01W5+3XPM28m9
 VqtP2TDqtZvgCFdhDn11jWWRj0ix4WmhBZFRyezblWlEnIoLzPD46GZxooVACI6fQJEw
 bZq7/ATlf2jKHwU8wVTc8PGjXHlZK+cimA0xfuVzPk8O+KpHAAoBksrNeKaRa5uxopZb
 RGvGbx7lVIfJQtaOjtRWxtrEqszy+BVCkrppvEsAsoBIRTJyVsaQ/HDeAec5u4YBwLv/
 6XWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791977213; x=1792582013;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q1TKQk69KHcjaDb24fEb/peTLu9FmofWYrxae6HA3jA=;
 b=fiUnrLYYHCKJ7CnoONekg3mysszRheuunpFmi/L+eC2MurQ0suxzu/OBLekn7AtJ01
 5PHBWFqSFtLdrEfDIlfbP1aDBEpZ3GAViyKYaLe4s4clqGvqnrGM8LFWIB+QhzAtTob1
 zWR3Lm7e640glXe5fXZ6EjSz4mSSmLe2khSnl+opt7PY4ISJkkjm+NseOl6hy7FtehZC
 VYQdhdPGpNOmiiMHbNIvL+2aHogaS4JsMH8h6X9ue5CtCtK+GvPo1B7qUIbynD0BBrdT
 ux3S/7NIdk+XJncRn318yegVBr644dSW8iTAKnYmTS/asu+VDfJVQtm0Ixem5yNyoejA
 IglQ==
X-Gm-Message-State: AFq9FYKCcY79m23Bl06yGg86iVxcGk2fLtVxMZFTDCZk8Se2jeluxjQN
 pTKvAp5Juz53gzeZoHCxvEGz0gtdorAewFiM8HpGJ00i1E9SSb6SFl781LJlumYZ
X-Gm-Gg: AYBFou2eP6UoGXBn5RjJDKRFcmvljwEhi9c8p3Ybju5D7qPjPMK5XAwiOUCvzGYTUno
 z1pEHLAMx7ijXP31znz4abxvlvhvfrgjuyEXWxkX/YJNkwJHRqWoTd/GxAuRKjZYCA4MwhdTpsn
 biKIkXRHnWPnzw6c9q8q5QStSfBPBjgXj476kOdlAYjQ6ww1S3PPsad9v7rQQDYLyZ+FAnzr0FV
 Nic8T8ROwu2zAFEFjqiRbCY50rxUk3LdL1pxCW4iyDMosQmno7jlVCo+FCgpBzX21xLM25994aL
 AmWCNOo99iyMSNhZSghxU5xG2clcDzw9JLOsW4a7RGVoIxGfHeokZwUh50uV1HCSY7BvCayH+V3
 gDH8uVZcs7/6E7TPPlxnXsN6tHkXWNjcQSQOxhJYfJFy1zjqMXUY+Db3fKHfoaT1JOrhufGLaeJ
 fbfAKeg2xx0NrW3uPF9h/thq+lCt2Jp4uYC6lWdsawEGIW9L7kvl0MYw3RC9hZuWCZvcUFLfKOd
 Do0LxnPwyWSyBTs3nNfvBVW6r0dTG+u/2vNecXJSjuyz7hGsB0u59IZkcRwAM+ke3DvdIcV
X-Received: by 2002:a17:90a:118f:b0:3ab:8288:b8ce with SMTP id
 98e67ed59e1d1-3ab8288c567mr4759379a91.24.1791977213408; 
 Wed, 14 Oct 2026 04:26:53 -0700 (PDT)
Received: from
 codespaces-2362ac.m2fxbej512jepnsor2itp05j3d.ix.internal.cloudapp.net
 ([23.97.62.132]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f05083fsm4508247a91.1.2026.10.14.04.26.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Oct 2026 04:26:52 -0700 (PDT)
From: Seongjae Jeong <jsjlee1020@gmail.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 14 Oct 2026 11:26:29 +0000
Message-ID: <20261014112629.59861-1-jsjlee1020@gmail.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
X-Headers-End: 1xGx8N-00046T-A2
Subject: [f2fs-dev] [PATCH] f2fs: fix submit accounting for IPU writeback
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

f2fs_write_cache_pages() uses the submitted count, which is set to
fio.submitted in f2fs_write_single_data_page(), to update nwritten
and decrement wbc->nr_to_write.

In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
However, in the IPU path, fio->submitted is never set and remains zero.
As a result, successful IPU writes are not accounted for.
This can cause asynchronous writeback to continue beyond its budget.

Set fio->submitted in f2fs_inplace_write_data() after a page is
successfully merged into a bio or submitted, so that successful
IPU writes are included in the writeback accounting.

Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
---
 fs/f2fs/segment.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 453f9284ec86..2e19124f1463 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4298,6 +4298,7 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 	else
 		err = f2fs_submit_page_bio(fio);
 	if (!err) {
+		fio->submitted = 1;
 		f2fs_update_device_state(fio->sbi, fio->ino,
 						fio->new_blkaddr, 1);
 		f2fs_update_iostat(fio->sbi, fio_inode(fio),
-- 
2.53.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

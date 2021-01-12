Return-Path: <SRS0=pHl4=GP=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E03D0C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 Jan 2021 06:40:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D35F22CA2;
	Tue, 12 Jan 2021 06:40:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D35F22CA2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kzDLT-00029n-6s; Tue, 12 Jan 2021 06:39:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <lukas.bulwahn@gmail.com>) id 1kzDLS-00029g-3d
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 06:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 MIME-Version:Content-Type:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=; b=glb+AWiZOyWWLB6ggRcl+D5M9n
 ZGThuTug70yigKw28VgUciAyYaPeqm36TdfrHKSEMerEKgcoXGnCbiD3UYM4zdS0Bkuk7UaOq93I/
 EoeA1imTiPuYE5Mdz5TYTHjxvyUGRoL/YEl5uFAULBPy1N2Hcix0nPe+E991Ud+4n4aw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:
 Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=; b=GEcZotC1bMefJpH2n2Hp8OTpYC
 G4PAQWueSU61C5NjVLdAhQVeXXZ4suwkA7D7nSM8TvteUPKL+TyBZYohfB9m8VOaM3/rylSTQZO/g
 cmiMumY2bzoFfLxN3ZhwudUebRVHfwAV28kYsHNIpNMjscWO+xHMkEZ+IT3livIbuIio=;
Received: from mail-wr1-f52.google.com ([209.85.221.52])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kzDLM-002yxg-A2
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 12 Jan 2021 06:39:58 +0000
Received: by mail-wr1-f52.google.com with SMTP id y17so1207430wrr.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Jan 2021 22:39:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id;
 bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=;
 b=o7c/bYOmrUdWx+iCTWh+kH1oq89qd9Xh5NfDK6HsSCIjg7JuVOwXKxXBJX9ip9BOc9
 ZskNAZidSRtJ9VysTj22wEoCVydOfJ+gIWfB3wotcX9tcJWywlkHq/uZSxdsMMcGxlhE
 xADGyS7eVQldGtjrUv0fIAzBM7XiFJpzfSmLRvu02/moPgtggmOMPUBWXcwsMYS0uTtw
 +Cwq1h0E8HRqtqwtAv4HNTII117qYCsJtuqUpvuMbEi1saGfedJvVRlkoFH1s2OSXi/d
 Z5cCZC1H4uhoYSnTk1ZTUiV5+RB3K1DvKUuJHKpMRVLf2ONKcHU1Y4LJdXATM4WEBeR+
 CwrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id;
 bh=9LsugDW569FjBERoyKSAR4XOY8TthJz1AKh7ZpXlyG4=;
 b=TAZxrO2zdQC34bF2l2DqapyRKyhmrhiJQuX2u3jUS7scy4hlypUFOFaUU8oB+Qp8to
 LZ5/kfLc6eTSKbZvvqrFiYfqOCiZ2Z421yMIupfX751bko5x/YCwUyzfmWJrcO7DGMUm
 cHKyZnH18A6F7d+ylQR7lJ5HEnMe/QfbLIjHymXPpbp6jMrX+kV0Rkx7tbPgoxcNrq7o
 CU+QXYfnLSTSiFkFZ30OOdxROc4e9zIrTZ3XIn8mXZx4IrYFVg5taKHIkMQGN06dFE9K
 CnN4I7izN3ItSKzr1vbmCKxCaLT87Od9c8WIUT9ORPmePQa1uWD7R8a1T4zk7907FRmJ
 /Zlw==
X-Gm-Message-State: AOAM533kye3X3+Sb4KE+XYYWGXXVMOvVUBHj1XgT/41ue3MkQJ4Vczbf
 lYwVuuecvebsZO2u/g/zJ/c=
X-Google-Smtp-Source: ABdhPJxmxnoUy1ilxFUvRx/TYVyRWFgEsFRgYTw1CmU8AGC0C9eLPx269jY+DZ/mtB/gxGvJupAEUQ==
X-Received: by 2002:a5d:4d50:: with SMTP id a16mr2466183wru.43.1610433578801; 
 Mon, 11 Jan 2021 22:39:38 -0800 (PST)
Received: from felia.fritz.box ([2001:16b8:2d98:7500:f93f:dcaf:eddb:2c7c])
 by smtp.gmail.com with ESMTPSA id k1sm3024760wrn.46.2021.01.11.22.39.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 Jan 2021 22:39:38 -0800 (PST)
From: Lukas Bulwahn <lukas.bulwahn@gmail.com>
To: Chao Yu <yuchao0@huawei.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 12 Jan 2021 07:39:30 +0100
Message-Id: <20210112063930.20525-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Headers-End: 1kzDLM-002yxg-A2
Subject: [f2fs-dev] [PATCH -next] f2fs: docs: rectify the table header in
 sysfs-fs-f2fs
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
Cc: Lukas Bulwahn <lukas.bulwahn@gmail.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Commit 969945899a35 ("f2fs: introduce sb_status sysfs node") documents the
sb_status values in a table in ./Documentation/ABI/testing/sysfs-fs-f2fs,
but the table header of the first column has a wrong length.

Hence, make htmldocs warns:

  Documentation/ABI/testing/sysfs-fs-f2fs:382: WARNING: Malformed table.

Rectify the table header.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
applies cleanly on next-20210112

 Documentation/ABI/testing/sysfs-fs-f2fs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index e5918c93f3bf..362803901614 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -383,7 +383,7 @@ Date:		December 2020
 Contact:	"Chao Yu" <yuchao0@huawei.com>
 Description:	Show status of f2fs superblock in real time.
 
-		=====  ===================== =================================
+		====== ===================== =================================
 		value  sb status macro       description
 		0x1    SBI_IS_DIRTY          dirty flag for checkpoint
 		0x2    SBI_IS_CLOSE          specify unmounting
-- 
2.17.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

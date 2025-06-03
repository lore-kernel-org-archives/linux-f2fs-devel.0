Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7061CC5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Jun 2025 17:38:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2AAdSVLXwZT1k4aU/p1T07P1QLq+2gFzcYbZTQlJNUg=; b=Y0Usbk7N+EZTkdaua4eXVkDmdK
	J4Ro+SsRu6hj3duUz0cq73NM+93CSzYQ0OZoykrA2qYMbd5i/3pOwq9DN3kMR3r+qXl8EDPK6pWMO
	Uy2C7iMsnGd2JJzNBdC4tsjCG8CP+Qr/75AegliZoVe1v+Me368qiEknf9T4cIulqCns=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uMVaL-0002QC-UR;
	Tue, 03 Jun 2025 17:38:01 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1uMVaK-0002Py-GD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 17:38:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qmZbeZgnsejj51mBQflzEWz+C8FHTnGO31W7ha2CzVU=; b=ALKJS6qSeK75vAubmhv71rpHr0
 ER98cvO/fo2aonN+D7x2cvpiaCxqYQuiVqCyKs8btEegzHV75KCqMbM5zeCLKYZ8Pft7HODBSfHC1
 kfTzu9Ikhcr/oJzuEvJJhNasqmxKXQQyg/ANI0aZk2i34/s4rc9YTTD/ILSIU6gWKgkw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qmZbeZgnsejj51mBQflzEWz+C8FHTnGO31W7ha2CzVU=; b=b
 /jzcKtdfrgyhH/Mst0bE0tLtzWSsR7aYAa+sLH83Yj26MtU7sx5juQ3EWHGc5atxqn/IUJk1cGLba
 rowDAZZESmeIGXdgv5JuA1UZfk+bN/owBQTnfmF8XerDQo+wkx6ThqiyakmHG5lAcfLM7eKJUKsIt
 gRuI75ETASWNIyYw=;
Received: from mail-pj1-f50.google.com ([209.85.216.50])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uMVaJ-0007Rw-SL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Jun 2025 17:38:00 +0000
Received: by mail-pj1-f50.google.com with SMTP id
 98e67ed59e1d1-31302462330so475114a91.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 03 Jun 2025 10:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1748972269; x=1749577069; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qmZbeZgnsejj51mBQflzEWz+C8FHTnGO31W7ha2CzVU=;
 b=TFO+OEtv1pVMPkssPIwyR8SJIDUCSRh5bJub1aC7iNFLd5w1iN86rCjtnvZVI9wHC0
 0Bi7qVTfLLjJmYFdAS1avS8ShIzpemgFlZ85rf1Kc2MSZZ8orMk70BC5e9IG2Qi5UpV1
 hps/5LyOFc6hOI89bVFtdFEFY600jagcoZXJMOV+sy1dsbdLofe6YN25d9pljldW2oQy
 tKGSeKzif+vmzZDd2HQtD8NUc0JoWKd9WkD26DGcx+mPTolCFs9s8v85jZoGLPIgALK2
 mCvOiW9HRhZqu2qytTE/NjdMbN7SbP7A4uhSLdsd/TxqNrErpZj0/GEpppXrMEqJ5qW8
 Uf+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748972269; x=1749577069;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qmZbeZgnsejj51mBQflzEWz+C8FHTnGO31W7ha2CzVU=;
 b=QlFmqvziHhC2sAk1avPy3jVNENJ1e7a/tuniu5YBhtPIIhPy8Ga6wJsjKl6p3DcApK
 xr4vbCWEOK8U3JNWbnr0lywBbpJQbWj+3InWvb3NwsP0vAC5wHpfURg7gCczlSmee05L
 bSy+b9gqUHtFJ109gUd8vaaZpL/Q+r7TTptjHz1ZCyRf648BRX2B8ITFku5mVqPG8Hov
 x992eH4E1/G/Wr8PxIrw2NtuOS+m8EnFwd7XKgA01S//B50wbWcjZegwwiCvyS1qtnid
 Lj8TWQIUcx0i9MEOmgbbPkUzKTqDV3B0IEIJxefzQhwmHzx42bDEH893ZA3veh5iA5MN
 VLKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV17s3j+z1NrK/tXIOziuuWtAFH+K4Jt9iZBD6EgpdVA/aJ0aSug4kWP+SZ/AlP5zrEIqf9OB93u+6hlS2sAZRo@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxF0p1hKKBcrbT7GBwdvme9HzWpL2pZT1MMH2UCDNf9NpFGMpi2
 gJ53HWvATe7Th9/0uDFIv2ZiRnK7GAQQWownSN334Gclr36m9RcJoPxz
X-Gm-Gg: ASbGncuVU9MfAA8KKzP40bowQE17f2uujNtDXdlywE1CehQ0stw7oj3TQGa57+pGDrh
 S7Hx2CD3OQP53Xo+9KTOdz2SeMat5H65mpn7ml5nN1PtwFYeYraznTnK7Y1zspB9RXGueE82bBs
 npv8heOsmrHfWbh1qlTF6RnYbCxDkN3xlHMbuycynpnKB9V167XvA2pmqamK+bJjtTSPJfO2Pq3
 QD6o/SpsOT2KjtFOdt3rqYn55qYFfg90qvG5Y4/mhEc78mw9IcOEGe3JMTw9lx3RDHj5se//jms
 AASXXMpnd/4zkR5pJlFBa6vqZdPnE2SivqOh8P1wSNUf8izLRfHOaE3QwCZWznvxa/Xo9d8Euqu
 GMmuu9TVeXDhchCcA939aafNQnlFu+/VJGgFfW2pZxFw=
X-Google-Smtp-Source: AGHT+IELgcwm5ycuQ7TBp9o3qO5sV84L5QfSoz36MtjwBB7F3vQBLsvxOsRDFg65VRNp8qlO364Y8A==
X-Received: by 2002:a17:90b:530d:b0:311:f2bd:dc25 with SMTP id
 98e67ed59e1d1-31250405591mr29739222a91.16.1748972269088; 
 Tue, 03 Jun 2025 10:37:49 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e14:7:f466:948b:ebb2:d370])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3124e3d2999sm7531826a91.46.2025.06.03.10.37.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Jun 2025 10:37:48 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  3 Jun 2025 10:37:39 -0700
Message-ID: <20250603173739.2483532-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.49.0.1204.g71687c7c1d-goog
MIME-Version: 1.0
X-Headers-End: 1uMVaJ-0007Rw-SL
Subject: [f2fs-dev] [PATCH] f2fs: turn off one_time when forcibly set to
 foreground GC
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

From: Daeho Jeong <daehojeong@google.com>

one_time mode is only for background GC. So, we need to set it back to
false when foreground GC is enforced.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
Fixes: 9748c2ddea4a ("f2fs: do FG_GC when GC boosting is required for zoned devices")
---
 fs/f2fs/gc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index 2b8f9239bede..f752dec71e45 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1893,6 +1893,7 @@ int f2fs_gc(struct f2fs_sb_info *sbi, struct f2fs_gc_control *gc_control)
 	/* Let's run FG_GC, if we don't have enough space. */
 	if (has_not_enough_free_secs(sbi, 0, 0)) {
 		gc_type = FG_GC;
+		gc_control->one_time = false;
 
 		/*
 		 * For example, if there are many prefree_segments below given
-- 
2.49.0.1204.g71687c7c1d-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

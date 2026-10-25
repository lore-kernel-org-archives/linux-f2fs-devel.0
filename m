Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78E8A606A31B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Oct 2026 18:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EkuuiS89;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Bfi1AOxr;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XVjpn3Cw;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=N8iIuuP2
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=vVMbUPGzfm4F0KOi/q9RF7AOZ6zOLGvhLF+4buN9Bao=; b=EkuuiS89VfDgD3ySLcQaHK9/aU
	n8mp3jJxsVbgkLHTWK3VHo7b9hFx1EbPM8rwl52JBGGO2Hi/SDAhuIyKYA+8GO3p3+S32crE3Tsap
	ire7FKkPHu+nQOW4i+jygFmUnvyAdDyxz/Jjq6gGbJsTxlpUH10V13yDQl+JoL4iw0yI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xL2YA-000000003Vb-1ptl;
	Sun, 25 Oct 2026 18:02:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <teel4res@gmail.com>) id 1xL2Y8-000000003VU-2tmV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=95rdhHdO0ki+AAo/8XpKJWa1xRVeRBmYXzxQNVzeBFU=; b=Bfi1AOxrWncv2DRgfFgIuFv3T2
 fCgb8kUyH2WpL83mPfGUXsMh7+TDGZn8fQiqHOeoeJPxp9JD8YoRNkF9hlAXcjni5/BF1Y6V/VfD2
 CW5Sp9w4+KW/Pwi7lKwZSvnVWoK3NHqBLBmxZRSJere3izYymZJkEm/3s0qxZCWjZjTs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=95rdhHdO0ki+AAo/8XpKJWa1xRVeRBmYXzxQNVzeBFU=; b=XVjpn3CwG2txE7Rwvuw1CQTPdl
 xzqUbnrWYMDAXdZ4SfhAywzlzmZZ4CXTmD+LoXvoHfrTVF4GcAT+x66xTYEn0+L/iCgMYmC1jTjOy
 3+9oFmb/nrSSlnYeBmCrPBK/Sr8Eyf/512fjf0P/y/gFYmeaxGro00wiosLaYig8yy0A=;
Received: from mail-dl1-f44.google.com ([74.125.82.44])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xL2Y7-000000001WF-0eUd
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Oct 2026 18:02:28 +0000
Received: by mail-dl1-f44.google.com with SMTP id
 a92af1059eb24-1846bc43c28so2336136c88.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 11:02:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792951341; x=1793556141; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=95rdhHdO0ki+AAo/8XpKJWa1xRVeRBmYXzxQNVzeBFU=;
 b=N8iIuuP2UgrRWp9pUrQrxKVVBaFGoSXBEg4fYR/F+DJpZQQzyfrgl7UjuyG9R0+d/E
 bpuL5Mo5w4PzBbbvNJNxYYNTCstX3V9dKOnEKyJ0bzPGBNN3BBRNqFz1DXEtJpWRC9Vw
 I9NSkwss11VWETc2Aj84A8qrAMRzf/sr//tco8U9wko0KYCU1qe0h6VacoiYLA71MqDc
 K5LiawtZ6rZ115qof6r/SvKmJz7ehkuxFNuOKFCb2NREnJOmZWuu7JFx6GwKR/ZG+/9A
 RnQRxoaP/67BLEOm4GAXD0AL8tozNq07oCMpRZKEEeEdfBfsqi5bFqcFqkfMOsmtjXvS
 ofgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792951341; x=1793556141;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=95rdhHdO0ki+AAo/8XpKJWa1xRVeRBmYXzxQNVzeBFU=;
 b=rG4uAX1GaHJ+Urb9oYEaRmAH+lA2j4LygBR3X70IjSwHKhrlpQ89TWQ1lReLdDHrS3
 NS3cBrIb7I5gwIRGpOFs1dzK1VsnC2jf5UzBhhDO7yg4qo5wjci5vlv/FMMpjQGdcH71
 T9YeUQaWetEzcbxtLMabdAdHXTKUgx+XHxOHe2chMiz6jQxU85gRzwrUsX/jlwUPWHGy
 NyiHh84kHoHJZS+g9oM/xUEFLhUw4cxxSwbMI40OchF863UI/jG3jxsvDcm/5vFQC9+0
 6eN1eYm0WXNod1kpqq2ZBKcjhS4ugYLnKJC6ws8riMoKB4hXNytE6gIWPr+STXQ+3+Mf
 BqIQ==
X-Gm-Message-State: AFq9FYJTRErXfIRGCpAkJ6NMANGv1gwKAHFZDTxy3XjPuPTWvILb61E3
 u5si7aBE8ebQ5ggYchjrr17q7YyANTXKb7U03NTn4mJcbRT87oBBXzp6
X-Gm-Gg: AYBFou2f+h3mwKOAEx+/dN9ltz4pc7afvwn6L6+/H60iZTeY/Aucn3PWZjHYBlT7ARG
 BIXZgHxsS7zjQmhzMeAxL9v7tkEQB22J7n9DLaFhAG0sjVVMwDH2VTgLcbkuM76kPCCYs41+4XX
 v+9gqauTh06yQOCjEuOXeMphJwKjw7eECcOIuG8H09UcZHU/Mcy17hVZ4Q0FPgo9J3MrXygCHib
 ZuL6k3Kyd3Epfo09hoLnPHczMFgh38nYBRv7kfpf75FAjbj2ERlsVdW76NdyRPkxtvWkygaNKO5
 SKU9n/pYpdzDC9Pjdcy4z8Xr75HamOwl5o42blQWjt4TGGQ8yaNYXl4nOm1SoWfR0qvOzrfRjHN
 ctQzIg4GplNa3umONawVz6W3Udu9h/bhc+3pvLtl6EV0tk1mKjGptzJJ4GbCKU2Zy3qQRYRD8qr
 r4WZWaOlwPcWFjyxRKWU/l33uA6D8Vh5DjiERF/0eoWTeAIkbCC+hLd6DVERA4WCm4DSurfxRb7
 BvbgU4b0NTjjywUs2E995sTkLArc8she47AZJUSgMaFYnedamsepoHJM++0xovoumFdq70jjaUA
 7xt3msUVSgLvulp5cp+F
X-Received: by 2002:a05:7022:3a85:b0:14f:8d59:edcc with SMTP id
 a92af1059eb24-1993505de94mr7777952c88.12.1792951341298; 
 Sun, 25 Oct 2026 11:02:21 -0700 (PDT)
Received: from youngkk-vm.localdomain (67.216.200.102.16clouds.com.
 [67.216.200.102]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-198a2a5a515sm16099227c88.19.2026.10.25.11.02.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 11:02:13 -0700 (PDT)
From: Cheng Yongkang <teel4res@gmail.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Sun, 25 Oct 2026 11:02:04 -0700
Message-Id: <20261025180207.348498-1-teel4res@gmail.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xL2Y7-000000001WF-0eUd
Subject: [f2fs-dev] [PATCH 0/3] f2fs: fix dentry recovery and MAIN_AREA
 validation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Cheng Yongkang <teel4res@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series fixes three independent issues found while validating crafted
f2fs images:

1. reject a non-directory i_pino during dentry recovery;
2. reject MAIN_AREA boundary underflow in the alignment fix;
3. refresh the superblock CRC after that alignment fix.

Each patch is a single logical change and compiles on its own.  All three
were validated in QEMU on the KASAN kernel: baseline trigger, patched
no-trigger or clean rejection, and a normal filesystem mount/write/fsck
regression.  The baseline source and build were restored and
hash-verified after each run.

Cheng Yongkang (3):
  f2fs: reject non-directory parent inode during dentry recovery
  f2fs: reject MAIN_AREA boundary underflow
  f2fs: refresh superblock CRC after MAIN_AREA alignment fix

 fs/f2fs/recovery.c |  7 +++++++
 fs/f2fs/super.c    | 13 +++++++++++++
 2 files changed, 20 insertions(+)

--
2.34.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

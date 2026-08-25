Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26906C61DBC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 25 Aug 2026 17:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nrKivF0dEPzXF4WpeZ3/OuYHgSzygXfjdg9skOwcUI=; b=cc7mkuVjolHlH61hDZxp0NM03N
	ABjpfYMfw5PyPOdj4wfIdmNzUcqDyZOV7qfkotDOjSgh+2CdddNOd93IuacWI0jS5o8S0ohp0ITpL
	gzDz/20F/kdP0uMRkkIiPRu0z9pqyoogZXxDsXxLxaTPXI9wkxEfMK8XHw0syrZjjOnM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyuzl-0003Vm-9t;
	Tue, 25 Aug 2026 17:31:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wyuzj-0003VT-6F
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 17:31:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=u0azoLTpkgf0472f8nQNUV4wn6GRbOclcDNIuen1d0s=; b=TACs8wxJn/VMINyK5SpAE9lLVr
 82moTjKaKseXWGu1R3DZDn1DQdyvmSotAh/gdFo/c+aN9kp5oxKOJ06IoX4uo0Gt0YThe07SLjXEv
 YM6HBc5I9mMmWNNfcdzSJzZ3vn8eG3gzuYswKMJn2JIc+pocHsFr8FJGRe1y5l9pLmHo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=u0azoLTpkgf0472f8nQNUV4wn6GRbOclcDNIuen1d0s=; b=XVY/p+vxHwrxQJ5pKdJ8uN8Rnt
 vcfjPyBAOCgi1JduKr19w5XecyfVbjCcwYhpTGsHPSxALwr6M2YZC16W0Pm9h29JSdeeaFK2t0QH0
 tSR2eD/QH3rG06ZDXZXkka5xqZbXhbVeY24Ug+EUcTIAEd5veh5rdz9X+0SE2nH25M+o=;
Received: from mail-pj1-f53.google.com ([209.85.216.53])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wyuzi-0005m8-E1 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 25 Aug 2026 17:31:31 +0000
Received: by mail-pj1-f53.google.com with SMTP id
 98e67ed59e1d1-39266382df6so107932a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 10:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787679085; x=1788283885; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=u0azoLTpkgf0472f8nQNUV4wn6GRbOclcDNIuen1d0s=;
 b=jDbVFCWcbbyqY5kCYn/mGB8/odz+v5rwEn+GHHjOksIW6vAN4KD+0Yb+4q0Rs50KS0
 +CVfcoqc4Q0OR9Ls+FVh/wnJgYzObU30HTF6LGCbOBcHKF3WRdHNvECmBNZLfGpPBxr5
 VnhLiLFFCG6ylRY32+Sgwfn+p7FCblTrc+MpV6+Pb7aygKusn4WFrIHCuOT5FvKvRUEI
 eqcwhcmRumEIpANM7j+FUo6+vkyngX1FE2zMuVRV+o6uhunxfsq7kf2F4Zsqwf/oA7qx
 ei1pmQQEZCHqT7XKKLw2raG0SPRNh8yToB5d841MIVAYv3DBAJShheBe0vCgOmjHyN9G
 U6zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787679085; x=1788283885;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=u0azoLTpkgf0472f8nQNUV4wn6GRbOclcDNIuen1d0s=;
 b=F+xaUeTf48GHlcPu2VmwnrJqjj1ejq3Rwya/adCrZKrZS4MDNrfmISSSw0PzFWRP/g
 ITTJS2yw/arGQCCzRNHlkrysJ0OLewKoD1d9664T9B0x5eKrXggtblqK0g4vng5TdsQa
 CXxCTpBvUaysJfw2y6YcGzqlQWzrjVtzOGCuql7aJ7rNWblha4UpeYpKOXN0vqRjm6eq
 BDb++bN6Cv0Sim5CD1bzv5vIyd2PlEAvehlLk1h7qM6wALcXgPfL5w76NF6gcpBxABD3
 Qyh4cRgjrBaFoa+0Z/X8FWgDiBOO7iP0OygkQkQnCn2oEv0mK8Qea4hmwcfdNRrnDvfE
 ufWQ==
X-Gm-Message-State: AFuF++l6VTN/j/HRDa4xIlcEv3S/oEyKPZdtokC0OZOYJ1IUAGYpWIRo
 k4c9qQ94GAYW4Zhyj5zGSMJ4HSsFCanU/nzgIq7zD0n0oZcXIoTKLgyB
X-Gm-Gg: AR+sD10HZslJQSUvoTb4ZtdAlO/WAJ+X0/dGFDk5K7WCho7zlwhIndMS/0H5FUQfQcV
 GICVoH23J2bqo/8QYHH88xQwAP8Xem7L5Dvz+q32fqNNLwBR2yuAh2lUvreseJp6D3gtBM6c2Kw
 UABoqWZZ7ixNIXCDaI/WFO2gfzmFnA64YaLbxdIUSEbUalmqjHTfNLpX3GMqLge+FuudNwAJCKA
 fscWzGycK2NA6NmJh81eQ5pcpZr+6mtQzD8LV99NF80N67HSP9JS6h9cZK0FRzgG5aNTH8It1i8
 AvMAojve46rOSV/xpfvE0X6euT9zmSw8dk+Z0mz46jGhS1BDGNGNtCoSOSMGmIVsQ6L1DsYyPUL
 yj/pRCBggm9+U3HeAALr7t/Ez784voJOeYNtnlTQkT3qOeRBtZdBnEF9u7fpBCxGNuPWNcLftuJ
 3o7IGZ+oOt3WUqbiwju77/2o04LwudIQRbCix3J6DFGaY0e5NUwiEZIoBSgor+f9zwfanZn7j+p
 lmCtm00PDiYm0TAo3Cg5qvv
X-Received: by 2002:a17:90b:380b:b0:366:3517:1aa2 with SMTP id
 98e67ed59e1d1-3966d002fffmr1630917a91.0.1787679084301; 
 Tue, 25 Aug 2026 10:31:24 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39645b3a49bsm4529314a91.6.2026.08.25.10.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 10:31:22 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Wed, 26 Aug 2026 01:31:11 +0800
Message-ID: <20260825173111.1151141-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao20zq7Qy8hUnM_g@google.com>
References: <20260818200121.2684318-1-jaegeuk@kernel.org>
 <aohtWfHNbUwxoQg2@google.com> <aoylp9llX9zlKm-g@google.com>
 <20260825023925.230986-1-qiwenjie@xiaomi.com> <ao20zq7Qy8hUnM_g@google.com>
MIME-Version: 1.0
X-Headers-End: 1wyuzi-0005m8-E1
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: don't leave the hashed inode while
 it's unlinked
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

Hi Jaegeuk,

Yes, that's true for the normal path.

What I meant is the rollback case: err is non-zero, but __do_unlink()
may still return ret == 0. If the preceding f2fs_add_link() has already
been checkpointed, a crash before the rollback deletion is checkpointed
could expose the incomplete symlink again. Should we run f2fs_sync_fs()
for !ret && IS_DIRSYNC(dir), while preserving err?

Regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

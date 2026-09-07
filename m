Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A69C79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4mCeLRgiYe3NmsU0I712586RhiYhjVXkdub7/L3wGRo=; b=k67UgNru5BVZ6SD/zWC1N805XP
	ApsSjsfdk8JYtaFXxmpiam9kGb/fsJLiOgA1g1LOKpZk7IDTQ/i4ioE68hBako/RsQNoEYMgP6+SO
	RNaTqSq1nFKxPhBUAOlb2pSbJWwyWtyJR5dAdJCTx+lVPn8oTWESKSU7UTKRKCanwto8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3XJ1-0001y7-Cu;
	Mon, 07 Sep 2026 11:14:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3XJ0-0001y1-AU
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:14:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8W6Bv7KpERuwJUntqKnAFvzQpKJjMvVzAdtpot6zh1I=; b=YOSUVFINscYNPqIgcLXGYRqPI5
 hvWINdYg3CxOGBNuyP5rIV9zkTHYZnOuObv9uqrUOwUe78dYBHS7OXHpKWRk7+zq1G4A0E7alpu2x
 Id5Fd3QkUos+YOcC0HSPIFQkpgcVEaWme8cVVj/2xc6HNF2K7fc61MiL8zoRoHV6BD00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8W6Bv7KpERuwJUntqKnAFvzQpKJjMvVzAdtpot6zh1I=; b=QeBKLmOajfAVjWiH8raUmnEy4R
 aOIXJGZCtZIH/VNvLsi5wm0+LuT5XDznVbhnxS2CYfB0e60D6v2A2zFJDUZLaTk1MYllIioRcjF2/
 kvmiz37lHzcc8G0tC8SPAKnSwVPd90EzCOna+WP978wFbT4IUqjmSjo8sr0KNKz6cWqg=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3XIz-0006Vj-QB for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 11:14:30 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-396a51b2605so1371659a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 04:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788779664; x=1789384464; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=8W6Bv7KpERuwJUntqKnAFvzQpKJjMvVzAdtpot6zh1I=;
 b=fClK4Zlbz2+ASxkeXcz+0nPng94Klgb0rbf2ui0QJR+HAepiv/JjUKDZOOrGmX4fOd
 9SuRm2ujrDOW6ZHgJjTRdoIV6BIJwvKkWoF3Sujnparo9dTG8XARAbNMT8WYHR2EUlqX
 1ZF6qgoTYD6eOqG66d1xU/O/YtggVqtlSPlFhl5gmXQVGsIlkVbFKVR8t25NJcM51yef
 v4Whx0VSISLxHl4tQAhtd3GREbF2pyAnhx3VbzEbVYh+nE33vObSQM2EiqRwih+S9X4o
 svcutk18OJJHjdBMcONN+WLXAgXFxgLsZWCzkob/BiYBsbEgh8vyU5u5xZWp4fVeqX/c
 jZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788779664; x=1789384464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=8W6Bv7KpERuwJUntqKnAFvzQpKJjMvVzAdtpot6zh1I=;
 b=GLH5R+ixCBp912IylRzn9s4wooDYak8+I706RHtWkUqVbCLzNuNAHJk1M0vBgOnY8T
 OW+lj76gEbc24dS43zR/mLXktR8/vMFqfF+nZ5hDyKiKJ/JS9Bns6j9pHm2X6A2iFGde
 NuEukyiP5dVlCWn4UWamaBY+vvMc87T67tbi8Zhz+GKsUqu8ek6sUNOHZMKHSbQalM5/
 QyDCveOyc3fRm6g1YET0R4LuZ7bUoek2TdwipUkqZ8vhUQr0kbYcCGt9il2frhKX2YAl
 jQ6PKxhNqcwAsMdsYRMVy4EuYyq2yUfDOVgg0G4/b+JH7BzY3ikoYzV5os+9U5oxFJ2N
 w0Rw==
X-Gm-Message-State: AFuF++nLeUhCwwMdCUoR7Kh1iSwCexVp5uQTxCUp1GE67LE+Csra88IH
 PZT7axtwfksVcnWRWtU9sqArfmZSdD+UtWdCUmm6nl2ZZajEHZu83GBY
X-Gm-Gg: AYBFou3AzJmcajCAC9i8A4JYjvXc2xDwvbcmnVQWriIgoV57ccjocy4ITSzKGFgmHgc
 YKAn3/ET131AaQPuh0Fi+rG0tZSD+yaNknQOoOaM2+Y/xJ6U+a1A9yOX1M8EWfrk2rZpIJmMVf3
 eAseGyLMzApcJxF4q/cAGRNGHS7gMxixazIPV0VTTaoodXY0uYbDkTksVdxz+i6m0+s+zG7X3DB
 bnKq3w3mLvNPugS/Z4p0WxhpR3pup9eN0T1ao5+5VnfHj9/mRI4TBndogra5JsGRt3bvLQBuo0v
 nG4vAhVLlZkFmM1A6KQNiOaOR+5QeEjaSTLEegjh6zi5YhwxSBnWvO7W+KFwh4j9F1J2mlu/ysL
 7alaOtbvzXeXF4/SuqJrCqxgNWw1W42h1maxONt8Fmbozk1UeYYRLC4T8IhoXxS7ZADsi0VsHfj
 jOvCJ4WOr7VkxE8oSpP8egJc4dxt/OGDGlvUjHq+XCMBFMig2tUQPmTVd0Kxb1leodxZwMURNt6
 JhLTkrvcSk9yOGTEfaFXXC3FA==
X-Received: by 2002:a17:90b:4e8f:b0:38e:5c6:4db9 with SMTP id
 98e67ed59e1d1-39b261ba63bmr33887224a91.11.1788779663921; 
 Mon, 07 Sep 2026 04:14:23 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b260fdf9asm20388323a91.9.2026.09.07.04.14.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 04:14:23 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 19:14:16 +0800
Message-ID: <20260907111416.2522216-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6f138a9d-1428-4813-b102-caeab9591da4@kernel.org>
References: <6f138a9d-1428-4813-b102-caeab9591da4@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3XIz-0006Vj-QB
Subject: Re: [f2fs-dev] [PATCH 13/14] f2fs: allow large folio support to
 writeable files
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
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, 31 Aug 2026 16:31:36 +0800, Chao Yu wrote:
> We start to use blk-crypto rather than fs-layer file contents en/decryption
> code, I think we update f2fs_mapping_set_large_folio() to allow encrypted
> file to work w/ large folio.

Oh, I missed that information. I'll remove the encrypted gate in
f2fs_mapping_set_large_folio() in the next version.

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

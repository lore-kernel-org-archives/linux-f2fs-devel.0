Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F7EC61DBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 27 Aug 2026 02:09:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6+VDR9NBVk6un3Z7ovoH/Q7Q+1zqzaRRdlEOv7G1AIU=; b=QeQUKgkC6nBQIwIiZ65UziHBPG
	y26pNTtw100vm3jxd6BmN+kAsNu6kAvnucnJsthYWiADvKCdpeCw2eOCxp8DLe0ziNv9UnsnNJR7h
	3VDqv5cSOMEEX5cXL1ZU9WC8LSQjF6E/i9TPJ+TvTpyXbAVd5ud9gNwxFMgcibZp5W/Q=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzPY3-0000H3-4b;
	Thu, 27 Aug 2026 02:08:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wzPY2-0000Gr-Ac
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 02:08:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=ev+lby/76ZJL82oPYvE3j0ihzk
 o17fQn+MH2jGPifHEfcDzjyS1Np2nIXDStqivscVmAvHqKMTS/jPtpQeBnmBCHuQhg3qpDkxmequd
 hjLw2rlvUIU00S+pwPApE+oVk8GG/4cxN/C34FcnlnH9DxYRVMQ7smHtD7qNeD5dtr5E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=; b=f8kmhFEKjdoFSkHoSCXCVkuASL
 ifB0AtQ7QC/TVb5L/1GkAy23QKbrVXDaQWgITDKDU3whMtXPJ09gc8vHXYqhlurEq/ryE1UeEARb1
 2J7PLl1ljO7leDUAdHPhZUSL2AUhPbaeB7Q/wdrdl7r6QhUDyiZ2V0N80rcWsyVd3Nf0=;
Received: from mail-pg1-f172.google.com ([209.85.215.172])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wzPY1-0002Um-PU for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 27 Aug 2026 02:08:59 +0000
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c9e7391839cso1498440a12.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 26 Aug 2026 19:08:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787796532; x=1788401332; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=Iuv9ul5pIUvnKaKE38X8ah7Swd4Ch0LY7Yew+BfFW8t+V7hRD2NVSjJ1eUUhkul/9x
 7OWO14NbVdhZ1U61m3JheT4KWrOlnYGEmhw65UYJV8gDnG72Tdn+JTAbdeTocpZD1wue
 usnX32eg0BKjFfA7pHqI2P+qLJyNfZxGu/62g8e1oRxMBJAr+N8Q0RSsePNQihb+cMpv
 j/Q0/m5TPLMvU5oOMotsNVTELDNALVsKAZ4IremGD+TFpk6p8iPbXrD5j0Sb1swo/+JH
 iGUzy9oqeDWMhDs3765DGOgANJCib+IAx7dOhABEANt6eV5kBmQNWlTV1wiSOhlJO8+X
 aT2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787796532; x=1788401332;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=bd1tWYCe/xw7dqGl1zLqdcu74EzhsWFOTCGYYlkv/3M=;
 b=rSw+zZCh0p3R+0dITpQe42j7dOCS+MnXh6jQ1kjfpPNlTuSzwoKNrXfCv3SXK/B0Od
 7oaBud62vQpiBzF8WMuwWWvr/vSy7RUUq1k+8lYVgw1axouTKNgNZph0cbYeGLE5qCoM
 Vrd9Zg9uWjRyxGxT8rTj4kDxJY+Jxw6yNzrUiY/yqceDjQMvf//3oAMzpY77YtlmK1Jp
 CZZj+WE/UTNIywzCp9P00ksVaQMhfAk9GKGV55C6DL4l9SWi/Arf7/kXeedg8tTlt+z5
 pLni1pTYjqnah42Tv3nvEUB8j4EHF4GxZ88L6nAmqMD5U8Ea+ZLclEjJ0FiFqkl8nrYI
 F6Hg==
X-Gm-Message-State: AFuF++mzCubTqfSDm4Noi2TMWPwADCSLpsr3M+n1JHV4ZxnYA0+RMlLa
 B+7Qv8D95mkRXRitp91KY15etuLwREbRM/2KcnrMp38OAc7djLPNUVCz
X-Gm-Gg: AR+sD12YWvjYQN06yigLeQYaLeQ12w9O0fY0mQHs09bPfhYnILmpeMCLuMw/8za8mQp
 Fey2ZJPuM0TyPsrrd3t9++PU15BIWMqcDx5sR1275QkQ2nAu8863pQo2tXdUoaaveDN36vseg5z
 03GhpQ9OViEcfg23lm5h/d3tKKcY/DWOLUxUHcmkA6qKNUowjZJn9GaLIQaR8BuDcaZMHE0+5Ed
 kq3dTiCbtsPUx7L72NOqsQbwmQi6feQYF3BflBy5F8W7dgiB0/Rgc4SAmKF5GSpmKkVJ1ncXFTZ
 l1/6d7/FHooIHik3hEF7LIAVmZBJZ5tMupTQPuo197hc7yMpvdXeyP7Z4bxk9DZNQUA+UTJzTKM
 FPDq62UAXB6MutFvyRDcCHjEQDr79O2Fj/P1TWhn8eG4ec1go0mnCB+9p5/ysqEJfo0/pz9ZUQ7
 uVZh04b/yxbGB97L58M5jaw+ks74dTcyOu7rYmUymnF0pi4XRvLEZ9za5ruSq3lrEE/IBAvrx+o
 etVpMhG6Gojszcr0yfDTQWV
X-Received: by 2002:a17:90b:268b:b0:380:fead:448d with SMTP id
 98e67ed59e1d1-3966d73212emr23919557a91.13.1787796532088; 
 Wed, 26 Aug 2026 19:08:52 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-396b0ea80edsm618536a91.1.2026.08.26.19.08.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 19:08:51 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com,
	jaegeuk@kernel.org,
	chao@kernel.org
Date: Thu, 27 Aug 2026 10:08:45 +0800
Message-ID: <20260827020845.4170188-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826181121.3825702-1-daeho43@gmail.com>
References: <20260826181121.3825702-1-daeho43@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wzPY1-0002Um-PU
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: enforce alias_filename to match
 device name
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
Cc: qwjhust@gmail.com, qiwenjie@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Reviewed-by: Wenjie Qi <qiwenjie@xiaomi.com>

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

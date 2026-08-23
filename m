Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07A55C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Aug 2026 12:57:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yA2xmRdQyhs/HomTAdcJE3cOClrI2Kyyhu5fIfVT3ds=; b=ONp4w+cWoB2MBpTS4czCZ+4C0R
	7FdIx8ZLtXSAuK4RSEOHaOROzQ4xmAomNAZlBr2foJJfOgOf7kpv8/xsKnZ/TyFnfXzxvlNpVM54k
	EQRukRQ1DU4Mu11qpowqjErfhlQvIaAWATPY256aZlYj9DwhjkjUfZI/pbt4H3JdA6VA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wy7ln-0004Et-Jp;
	Sun, 23 Aug 2026 12:57:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wy7lm-0004En-AV
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:57:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:MIME-Version
 :References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MZRGavTfVZx/BWBuhDttPOMzo+S9nGuMMAOGWOpf63Q=; b=UyFFHzsNDRlbdCoevrTWCXJr/Q
 385YRKJSc2f6TWIu5NkugR4UECBtmj9tZtiDezZp3jSlmGDFbMks3eEhyptYmKl1eMq1Uv388fxLx
 HKQ1dEsHofcE8Ky8vfOiob/ceT1frxg87/oX+PzwxlkGs/de91ZGeML92+ikH+OgbTBo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MZRGavTfVZx/BWBuhDttPOMzo+S9nGuMMAOGWOpf63Q=; b=hJs0oEm+1GDKEtN1F11W8kPVX5
 lGVU0MjgQVaAs9milrN4VYtdWGL0KQ/zYKdfhdNpMTi/Qw/zY6Pxnmmm3RCnWzLFkYlMw7ezrCgS5
 MTXXMozEfsDE/5bEtk5Y1NnUChtwfqn2ad5rhdqgjeiFamaK1qu1pd19lYSlouTBKaYo=;
Received: from mail-pl1-f172.google.com ([209.85.214.172])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wy7lj-0003Bo-FT for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 23 Aug 2026 12:57:47 +0000
Received: by mail-pl1-f172.google.com with SMTP id
 d9443c01a7336-2cf452def93so25419075ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 23 Aug 2026 05:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787489862; x=1788094662; darn=lists.sourceforge.net;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=MZRGavTfVZx/BWBuhDttPOMzo+S9nGuMMAOGWOpf63Q=;
 b=QiqzpmOAT+LBDzbVqZk980cfTVoEh7F7vOKYj9lUhTWNMFQkw9nwMnB/bCRRQhHRib
 DrSaQa8Y4iL7rKnAlwnBcBw0gP72H1AHeLBGdHohuhPUROJ4kE/4HdR6gPDT1qJhnrt3
 LCMieKiLqoloQnjoVT0WE6NEsfyZOFKWG55LqMzOzsDp0SQMcX8VltlGNCHMZWEfPpvD
 YDgAOIt8uZRi+wTTukNjU6kPFvnaW0+3tGIarWi54Q2Zrg3JIPv/Lf6cYq++I+ZJsOMO
 J1IQ42ZefYOrgUicjY67a2x2reY10fFjt1+8OdKyXvADfdqV9lPgTqAXrS0WrBgD9ESA
 UlqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787489862; x=1788094662;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=MZRGavTfVZx/BWBuhDttPOMzo+S9nGuMMAOGWOpf63Q=;
 b=FmRxSSuDPan9PWrszH5Crr/HMfV0ZdYKE1WXo/yHq32higqf1oSMO++V5UWb4I3lzy
 mtyFEVPf9UQa9hRkzB3NK24w6oUczjY+ngrg4bB7bNmnUx6RGLOeY8eOOnsedqc1NxxP
 uBbWnXw7HWxdSJTF6BdllHRBnue0u2EGY1HsWmwl9s/iFSbRnTsXrTTpK6eQ3xeiYMYP
 gaxMGby5MwRxqiGPdV6LsnHrac50SJ0IzQYaD/zc4VxJxPnuoaZ69KhW/yWU3rszeddO
 JNFtxXvtE4o6Jy4DLNZzp65TSQPZNzdwbKSsO/CHXlDQ+f28XHqLSXEJC0USSia5mJNV
 s8nw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqlJ1Apdy2o0cIsR7O+5aM+XiKp8a4Y6vIpTgwyx1znqVV6vR3QWqS1yOpJLD2hAsEw/zIYm0+A1V+ONcYiRMgt@lists.sourceforge.net
X-Gm-Message-State: AFuF++n7YTnBV8RDgG3taH5YO4aw6LFt8MTMuhVAB5KRQ9tkbnpctHxI
 i3khFtJg4EaWmX9HZUbQue/as7IqGLeZmRWHuiKLPyPA5weONMUXQUqc
X-Gm-Gg: AR+sD13CR2cTywAXKyThkf0oNWesIvKAFpOJzZEeo0HWz7GJe7aQFDmRC0cuyIzpALD
 ue8v+3mqNVguUVf+qLDfQr38dEhSBbw/DxKNwomXTx74rBwld2XdbRkXiy65+vyawKrHdoCRlQ8
 AguDetn6Ir5ylv9BBTFnK6Ahxu7Zs4kJTo335XaYVOSFTAITSxOX8sNynxcX8Kyj225sRtRmWuf
 4kPAJLt14xMJSq8Ai5hvkB2QW5Z5wmtSM7xCfgWiVmoFdopYFDtFRSmEcO31nuIunljZM6ovMlB
 E3xpSDtx4O3+qvUCil80rtcOMoTc8n7g7qEQM0ujEHC1AFt4wwJymK6MJYoCxDUWkzhYDUjvqYo
 fbPDlI4dLME9lFEasvx7DAT3f/ez1SfIoWE7hYk3NgdZ1kXAG9OoeohkmtpsvMJWeFc5QKJE3sF
 k9E3kS+xvaHoJIDV93aVeCwDeHtitJ+mPTaMFSsbVLXZsDP6dTlLIcqbRZmjk5MLOntL+hk5sdU
 400Yey1NguN1VZWpXbKf9TUu00QmQ==
X-Received: by 2002:a17:903:230d:b0:2cc:89ce:2f07 with SMTP id
 d9443c01a7336-2d64d135a06mr178538735ad.1.1787489861724; 
 Sun, 23 Aug 2026 05:57:41 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d67cbde1fasm8264355ad.56.2026.08.23.05.57.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Aug 2026 05:57:41 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Sun, 23 Aug 2026 20:57:35 +0800
Message-ID: <20260823125735.3230503-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820031721.12218-8-chao@kernel.org>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-8-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wy7lj-0003Bo-FT
Subject: Re: [f2fs-dev] [PATCH v1 07/12] f2fs: cache: use node cache
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
Cc: qwjhust@gmail.com, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Wenjie Qi <qiwenjie@xiaomi.com>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> entry = fn->entry;
> f2fs_cache_get(entry);
> spin_unlock_irqrestore(&sbi->fsync_node_lock, flags);
>
> f2fs_cache_wait_writeback(entry);

The entry reference keeps the entry allocated, but the waiter does not hold
the entry lock.  After WRITEBACK is cleared, invalidation can detach the
entry and set `entry->cache` to NULL.  `f2fs_cache_wait_writeback()` checks
and uses `entry->cache` through separate accesses.

Does the reference taken here also guarantee that the parent cache remains
attached across the wait helper's check and use?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

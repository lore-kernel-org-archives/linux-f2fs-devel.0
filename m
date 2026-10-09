Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA82CA6012
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2026 08:44:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0HuS+aAUPorSgTDat539PXzV88neOmFjIgTnjURvEFU=; b=PcSpxLAYTFfDOc2kC3J1QyTKT9
	8jeXRhaNcv5+BwHnHK8J8hVP37mBC31xD7JNsUJb2TYmIRls7dU9QUBkLqkZaVaioZkZzoW/OORbV
	5ZckmCJWhCzDvlr23TUbwgb2yTFXQzQsWnxkoOyl4wworcZvP2LbMCpPb/llBaPb3vHE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xF6DM-0001Ms-94;
	Fri, 09 Oct 2026 08:44:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1xF6DL-0001Mb-4P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:44:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Ynd2/iYhnHg9LdFpo2/wM0uFXELOfDTv+ihIyOe0vJ8=; b=kCrI3ow/w/PIofQv1fxXlNPgjr
 r/hYtN8AJ/8l/KBR90OenUNVT34IgNritRJHICpi3WdB44D/xtgKZb1VOgrBfs159P1PGkiJlJgbm
 JxHgen8BlPUQyyzDqqhAoq4JHAJ+SStx9Xe3YCH5BCmJb2tqJtLTwlgogvp1BIZt+ij4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Ynd2/iYhnHg9LdFpo2/wM0uFXELOfDTv+ihIyOe0vJ8=; b=lo1Aw+QMNvSfreRmOv0FQvLodg
 qxIq6VJJQvEEJhCgwtNXzLHh39P7Jyh+669scsvQ4Z9+3bJPNtMPEEgz6Uozafz1bBEifiDlvDG3l
 rr+bfOtBaGxioTdaY+Zu3tuXC7GSzTNXTxiHd9Ob8EH6hrg6KqoXWIBa+YKJ4oQjyEw0=;
Received: from mail-pf1-f178.google.com ([209.85.210.178])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xF6DL-0001Od-JT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 Oct 2026 08:44:27 +0000
Received: by mail-pf1-f178.google.com with SMTP id
 d2e1a72fcca58-88d48da248eso3071510b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 09 Oct 2026 01:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791535462; x=1792140262; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Ynd2/iYhnHg9LdFpo2/wM0uFXELOfDTv+ihIyOe0vJ8=;
 b=mT4WMHfRA3bKbnUhVCPYzdkMJJRVqCdG8iqIYvXyRZXr6A9ZlUjoTlLkigGK2jlD9l
 tO2zNw1zPXxawE/KQJ9YAbr20/MpINB/jI8vptCkZUI5l7Hk/W9YA0N4AFIahxDbfuVc
 1E/E0KKWkQus+4hfRnIIy8fwA9wguQOPN61FxFcQONSy1hGoDy57UP/QmYfoy0u+sbV2
 Pj/POWk4j8o+nUluaioAMMSoeNsxeXbAcMBxAARdgTbRlt9TyAhmxwgYeIK8IbIt9y31
 XtXTvltYWbxtiUl0khAWGUQa4dQecv0XD+D6copKUnHCOxe8Y6WWB0tDZ7tPy8+gpbwm
 8KpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791535462; x=1792140262;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Ynd2/iYhnHg9LdFpo2/wM0uFXELOfDTv+ihIyOe0vJ8=;
 b=zwI7bfF3GFeSVzJdU+WVy48AVjTJBcgvJLzQlmmV/uwcB3diuPKZDoBj9EeZX6VvE/
 1499c5b9zve6CUqrSypY4BdPZK0Mu40Mg4oZCdgtS+L8PqNmCetucDyzpz+FrFHqzaTS
 4rju95kk5Ne90JvtOlZdOLeeUEZ29nCNfeOnIfrDcgYYxMNQtlD90ELrJ2PNJpGDQSwt
 GFoD0IJ1MHuUQIBa4TmTd2pBU5G6JmD2NuSrQq+Qq9xocrzAd0FkoNMoJui6vMA/kfz2
 74sB+aptAQgqFuHayv4kv3uUSa7sYIPetBDqIUlTsDgKZ0roeOn/W+VT/mOnUWgBbUVA
 5yMA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxXoqmSRe3mcobSnKaFrjFTH1GFzFjIKFFnroNk/zb/0xHPqaysWXkdnZFEEtcjhyqvLzvcW6esdM0zBFsjsiAt@lists.sourceforge.net
X-Gm-Message-State: AFq9FYKEnbMJ9TLrR+qENpsKbgixexMKo8SyrCoaShULT4Y29XWlN1cR
 IzFUBJT4kcoPZvdXa+EI8g4DK7afBw4zenGlKyoR/V7R77JFeAf9+xel
X-Gm-Gg: AYBFou01QxkpedgF/OlXkou2FCb1S9J87dW0z0EHuYcOKlcQr095j2+Sx4GzvOFUMP9
 WjzCTQu9ogXpJ1Q/MSnmFMALPSpVyNsh9XKEU9LqvnQOJ890H+LMMKvp6N2UdMtKP7Mstg2Y7tr
 SpUQgnvye4Mb/L1MDQsG5K7jNbnEbN/5KdvHUnYmwNmxeQhSzdDAgBaMzDH/a319/B2SaU8YiFF
 wbb30IC2BwC9o87RbcVaatvDByAuxeGMBi9+A3CAdLAtpZLt+vLKlpSGnOPKUojA2QfOikXWpOO
 yO8zSh6xW+y9iasbYgLviZ7C6OIEhnij1/vH4LS2ArbwTcyM4gWFrlOek57GduIDp/P125AxaoV
 LrtWKAzQuyWdceuHQwj7h80qXmhJkCVNb4d+VgGO1maltu6kQhXMlY/ZMhuBMEbxQr/gpLmDfqo
 ryPcjvhen/VZonA73hEpe7UUufohU3dW0GdcdbJ8xL27IXpOOit0t2+L9ypB5nLRCDqjt3knA3g
 rcvGgdUgqp9VRvTotjbeC0789BW1qUega4=
X-Received: by 2002:a05:6a00:6ca1:b0:882:905d:aa05 with SMTP id
 d2e1a72fcca58-897c7ec1e93mr990174b3a.50.1791535461838; 
 Fri, 09 Oct 2026 01:44:21 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-896c3ec7c82sm610867b3a.35.2026.10.09.01.44.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2026 01:44:20 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: chao@kernel.org
Date: Fri,  9 Oct 2026 16:44:13 +0800
Message-ID: <20261009084413.3478653-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <29c03ab9-fdf8-4e45-8432-84690e656157@kernel.org>
References: <20261009035354.3330915-1-qiwenjie@xiaomi.com>
 <29c03ab9-fdf8-4e45-8432-84690e656157@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1xF6DL-0001Od-JT
Subject: Re: [f2fs-dev] [PATCH] f2fs: avoid cache writeback busy loop with
 zero thresholds
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
Cc: qwjhust@gmail.com, jaegeuk@kernel.org, qiwenjie@xiaomi.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

On Fri, Oct 9, 2026, Chao Yu wrote:
> Thanks for the fix, do you mind I fold this into original patch? as it
> is still in dev-test.

Yes, please fold it into the original patch.

Best regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

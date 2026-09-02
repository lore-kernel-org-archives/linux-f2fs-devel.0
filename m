Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C53EC61DD6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  2 Sep 2026 08:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eEmGXgxsDeh05bUQYGCR1y+yqDi/Z2QGuOuwRZd2MIQ=; b=TFXVDNW1EwHwp527e2VIYUsfCE
	RX/4HO5wedORbizWK7lAgZzFrfb1c4THU0Xf4Nnj7APlgX7yzKJKZhTjRAK79sgtMBwg3dN57eH+h
	e3LuSHhEkfP3HLqlQFfHrO2EfijLyppy8DarMRS7ChW9vvw57GqbtWoxLiTs2tseCj6Q=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1g9j-0004s7-Tr;
	Wed, 02 Sep 2026 08:17:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x1g9F-0004rW-3C
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:16:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9ugly3DA88PHzTcF6g5Lltp+fotX04uzRCQV3bTwQjE=; b=mCbmX+FEuVJr6M9St3Ci3QvZSy
 XtoU9QYQxrnYAa+BeFno21kjfbHTRXy0SL63M8oYpJg1gkZdPkIC5H64taFY4KIuzeazFr3JGfd8C
 rafvy5cSiUcSQI42BIcZpUnpEhtJ0SfJommvzTAly1HJIz3aMBJ+F3S5PKb0ccwCe3YY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9ugly3DA88PHzTcF6g5Lltp+fotX04uzRCQV3bTwQjE=; b=cIae/TMncZ6OlfFB3fEe681Y4G
 6MGcT9fE3tVnPPQT3O7eAl4/Lj/ik97YvbjxnUh2OTu8EWHgTC3Fhvr7DzyOhj8g7X6a/FImjV0yZ
 j4dQUo7hbwlJO7eC8jYbqhuKi3+aKa2fp4AU8dCj5C0fYKyyHBVrDsb18MEx8vM9L0TE=;
Received: from mail-pj1-f46.google.com ([209.85.216.46])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x1g9F-0001bC-FZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 02 Sep 2026 08:16:45 +0000
Received: by mail-pj1-f46.google.com with SMTP id
 98e67ed59e1d1-39927410578so1445687a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 02 Sep 2026 01:16:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788337000; x=1788941800; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9ugly3DA88PHzTcF6g5Lltp+fotX04uzRCQV3bTwQjE=;
 b=cfOVnOj1UxErD4hm9pl81joi9V1f0Ct0dAj2GuKOh1eGPl5wyNHC6tisiaetZbiWJe
 5GfkOE2JvtyGO5PNy6UsZW+1bWMafGZRU67Kjh2B9EjDr9U/htPW4UirPlyEzVCvJN4D
 /NM6BgrVsLXU/MpzxmSP6j4iyNAIFpNgitfDPyG+5s9f2yGwzfIWA44NBystw6sYD7S8
 R04aW3/9XDYD6nfXfdHv5a3Clel5yPMSMXOk+zqBXoIp82O+hqxy3TKtI/b8EAldwOG6
 rlIoRuXaokBhVEVDEjqUFi5MAbdC9T730ZOrziA1Rlo9Xw9apkAYF4FxEZDUipeOMuaN
 VuQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788337000; x=1788941800;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=9ugly3DA88PHzTcF6g5Lltp+fotX04uzRCQV3bTwQjE=;
 b=L8YgLRFN26AtI1uedHZqJxQrPxVTITERFVr67A2YtmB+PGiGUsJCmCG5+UmTLOQCiR
 MJEI0GF3t8n5QxyKyqsVpRKEVkXrqjA4ALIrRrqfs/uAFqw4j1xxKtpURzq6XTYvnWB/
 vASGRIAt19o7VJAb+Tm7K7YBP+54AsCLKxwYDHw/1BCQQeUKsMHhIvmdmLTyZDkCV8ug
 zbu54iey5fHG2bolW2ayg4bv1MNKUBAKmIGAGS2bzJNJwKyP7vWcLwnx3fUNGs4D/u3X
 +5nXl2wlfpdUWXJQWGt1A/kxKQDFp2yRWAV97tc7D91DF5CC3c93pTBRZVvMsgt04/w8
 +WwA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzt1OsdWXvozciGYgULTph+9cMPayBT6Q1WMZkFSPc67uJt1+apbMrZ/V0AXl/f7CZ82YLERaAROck+s1IB5IFq@lists.sourceforge.net
X-Gm-Message-State: AFuF++l+PRL/kU3h1eZrFcKeqMuqRkiOlhzGuNcljCCRXNPMbNsxAPPJ
 LLqh2mVtnyyxXbLuYAF3c+kIjgdqCOeta/9EfVnV0MaZ4CKX3cNbBneU
X-Gm-Gg: AYBFou0SWk4+pXHv7O3nwrI9Mo/l1a/3rKe3vvct/tqmJMwdJRMqEgBHtdHxZpHaWRi
 vNxJkhET+ZiqaR7TbzJ2GD5Vb8R3MdiZG3P9Bc5gMrwcSAGkQ1hxQ3obWLefQBauiFiZs4mjcor
 N52Cdc+doWznCU37HOAIp7rYMceGJHIGmWBc3KV0o2zBtQCEECwA2e8HxFfZQXwQND2hRlgcChS
 DlVtpgmKrLItfxrgSjMCRHWjuQTRuNdRQGh5gCor9BAMLLIWlQVkiIZd/oYQHn1Qk9/3+yd7lpl
 2+5vHfnMwZNiGVI9uJRcaSuIvUvOblJwjiF1jOm63OEZ59j62sUkUucqgVTuD/+GLDlmEXINKmR
 1+EUcnodjZcLKQKnDbV7Sx+JqYPBzM3CeME3TlUpkAL6s1OQXRc9jQuQWjNBL6A2agaOhjKBHOQ
 heKK8FeO5ueU6fMqMq+PosCalgg2xVnl1Yo89G0aCsM9QDwN4HpoohkgFSe/7OvI8mQBS8X3BNd
 2504sTy9l/plqPoqP09mkxeNQ==
X-Received: by 2002:a17:90b:5281:b0:396:635a:9b10 with SMTP id
 98e67ed59e1d1-39aee030d9bmr4725312a91.11.1788336999723; 
 Wed, 02 Sep 2026 01:16:39 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3990d463798sm10105680a91.6.2026.09.02.01.16.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Sep 2026 01:16:39 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: chao@kernel.org
Date: Wed,  2 Sep 2026 16:16:33 +0800
Message-ID: <20260902081633.520538-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <afbed6d5-0c11-4041-ab8a-68f0264dceda@kernel.org>
References: <20260901140849.3405971-1-qiwenjie@xiaomi.com>
 <afbed6d5-0c11-4041-ab8a-68f0264dceda@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x1g9F-0001bC-FZ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: wait for inode record work before
 clearing ino bitmaps
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
Cc: qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

It does not miss UPDATE_INO. The mode argument only selects whether to
wait: both APPEND_INO and UPDATE_INO call
flush_workqueue(sbi->evict_wq), and both updates are queued on the same
eviction workqueue. Therefore, one call with APPEND_INO also drains
pending UPDATE_INO work. A second call with UPDATE_INO would flush the
same queue again.

Thanks,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

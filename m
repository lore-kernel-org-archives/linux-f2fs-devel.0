Return-Path: <SRS0=CtUu=A4=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56034C433E1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Jul 2020 06:16:39 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D8552071A;
	Fri, 17 Jul 2020 06:16:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="jfOiHkJ1";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="iwDfxMIP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D8552071A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jwJfh-0005j8-Bb; Fri, 17 Jul 2020 06:16:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jwJff-0005j0-Pn
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 06:16:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:CC:To:References:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g91rAVltbz9uHojaFxejkDZnfEx29vpsXkQtMdg7ayA=; b=jfOiHkJ1SYr/EtMJQJqx1hVbVd
 mffE/J9lXVOGvs53o/k2XeF9BGzeaajX6JKXdBjt/KtT4yzBSTYraOVZ3nmGuD1sUVKTBwM0Lq+iC
 wFetG4dDSroP605dMY8SyKqVVfv1X8LENRq7DR11emdjEvHZsw3LFli9srRV97Iw/BU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:CC:To:References:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g91rAVltbz9uHojaFxejkDZnfEx29vpsXkQtMdg7ayA=; b=iwDfxMIPJBbZzeYRn2+L53VQ80
 js0g8bRf0J+Bq9ZeAgs+EBfqCcUlXIBbwzTP08IyVUzpe14vFoUQN4NHgcf8f3B/BtfaD1dijfa/V
 4KYDWHYfC56xQvkDWzGMoDtdiZgsEgXNQLwxGMFgeyn2Z7Hgy4nM0PGkHaG0Ae0cgl6w=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jwJfd-00Bb6P-Pj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Jul 2020 06:16:35 +0000
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D9C2C45181C9146E3F82;
 Fri, 17 Jul 2020 14:16:15 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.209) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 17 Jul
 2020 14:16:14 +0800
References: <bug-208565-202145-boDe7CCxPJ@https.bugzilla.kernel.org/>
To: Eric Biggers <ebiggers@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
X-Forwarded-Message-Id: <bug-208565-202145-boDe7CCxPJ@https.bugzilla.kernel.org/>
Message-ID: <25bb20b5-e628-8807-d4ec-d05d77607a69@huawei.com>
Date: Fri, 17 Jul 2020 14:16:13 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <bug-208565-202145-boDe7CCxPJ@https.bugzilla.kernel.org/>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jwJfd-00Bb6P-Pj
Subject: [f2fs-dev] Fwd: [Bug 208565] There may be dead lock for cp_rwsem
 during checkpoint
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Eric,

Could you please help to test Jaegeak's patch with generic/204 testcase
to see whether there is a regression?

-------- Forwarded Message --------
Subject: [f2fs-dev] [Bug 208565] There may be dead lock for cp_rwsem during checkpoint
Date: Fri, 17 Jul 2020 02:26:47 +0000
From: bugzilla-daemon@bugzilla.kernel.org
To: linux-f2fs-devel@lists.sourceforge.net

https://bugzilla.kernel.org/show_bug.cgi?id=208565

--- Comment #4 from Chao Yu (chao@kernel.org) ---
Passed, we should ask Eric to retest in his enviornment, to make sure there is
actually no regression.

-- 
You are receiving this mail because:
You are watching the assignee of the bug.

_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=lp92=77=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84C82C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:09 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57A292071A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 18 Jun 2020 12:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="cGolC98t";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="KFrUl5K4";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chrisdown.name header.i=@chrisdown.name header.b="Dq0okwnm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57A292071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chrisdown.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jltzb-0003Ms-TT; Thu, 18 Jun 2020 12:50:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chris@chrisdown.name>) id 1jltza-0003Ml-Qd
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 12:50:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=; b=cGolC98tdhr9CUmIU5wFNTPmbc
 LhTPV5HqLWGRnGNTSkaWtlJ0R0uL4hx93zORuvhLB2i6i70Pt1B80Fnph+/4qTnSic8i8XxiKmTOz
 4xWLbCh9S3urqwxL+OR3W4xxyxAK5TwD8DhaHAZTDcmMJWZ40/0tSv+5ZAC1UNDUZI1Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=; b=KFrUl5K4yRc2rAWJzvAV4Pq9dR
 NHn+1T3XjQFBKm6JbxDxLC5syOklomcX+puhChL+3FEnKifxkLS1KBTn1CPA5QorQBMaVcVQX/uvh
 4vqpnXkiGUOYbAwkL0u46l4DYNYvgzR6RmblSnK3xml+Hp5rNMvZEDXOvSYOi9vljU0k=;
Received: from mail-wm1-f65.google.com ([209.85.128.65])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1jltzW-008QMG-Hs
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 18 Jun 2020 12:50:06 +0000
Received: by mail-wm1-f65.google.com with SMTP id l26so5077411wme.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 18 Jun 2020 05:50:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chrisdown.name; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=;
 b=Dq0okwnm8dIAP3kvoa45FnYbLZDxzvv8uoBKmRBi3WMPUPQIN78xVXty0qrja4zjPk
 EkOCjrVdGpZC3fyFgN4PiU7Z/JrNCe2w4BPn+7D78sGoz+KoDFgVPEaOKPEm8CFlP4at
 ETRL68tu/ftXB8IYZAvreyq2MYw+RProIV020=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=2etjjb3Ig5XsGGEiKGN5JpNnFUz+x9R74hJMp+6KTAE=;
 b=FZkKB1qrhaGoFoDWCTH9AEuvrj5v3jTwZr26LDDfoJPxJhIRZq5iZX9607OyJtT8O8
 LEhfAYgaLka8yy7PzHwPmRJL4RYj/v2pmAt2k9qXgZb9iclfSNaFFH6AdwUW4uhHekkY
 4lIHzc0+SN/hgPZanGtdxvfXvIOIBMfXPKSFenQ75F9Kr2hQws2x5M+p/WeAp4X3t7VB
 eS8dO7xBMbJ8vEHcr7UhCYHWc/H7CUBFqHDo0Vpc6uTc4pkQSHr9OyjS4UVpHL/epplP
 9RM4n7+UgrhV5CY4ILGeQOMBHxb5Q+fhU1WeL32wDDH4wLMQ1Q7ATvt2rl/6sAyc4WGF
 xzuA==
X-Gm-Message-State: AOAM532c7yVoi02467Fz5taLwEfM3ruWffp8/Ub3sECvrXMc0+1MU/v+
 Mnt9Yaasb29/HD9VZYUMDlHvkQ==
X-Google-Smtp-Source: ABdhPJylqVUy/P+K1gxZzXFfcVj7BdacNz4q5MIX08y2VIvq3tIsytvwPasTJsxBLJenfxoW3Q7jKg==
X-Received: by 2002:a1c:2044:: with SMTP id g65mr4329441wmg.16.1592484596106; 
 Thu, 18 Jun 2020 05:49:56 -0700 (PDT)
Received: from localhost ([2a01:4b00:8432:8a00:63de:dd93:20be:f460])
 by smtp.gmail.com with ESMTPSA id b19sm11396014wmj.0.2020.06.18.05.49.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2020 05:49:55 -0700 (PDT)
Date: Thu, 18 Jun 2020 13:49:55 +0100
From: Chris Down <chris@chrisdown.name>
To: Michal Hocko <mhocko@kernel.org>
Message-ID: <20200618124955.GB694719@chrisdown.name>
References: <CA+G9fYsdsgRmwLtSKJSzB1eWcUQ1z-_aaU+BNcQpker34XT6_w@mail.gmail.com>
 <20200617135758.GA548179@chrisdown.name>
 <20200617141155.GQ9499@dhcp22.suse.cz>
 <CA+G9fYu+FB1PE0AMmE-9MrHpayE9kChwTyc3zfM6V83uQ0zcQA@mail.gmail.com>
 <20200617160624.GS9499@dhcp22.suse.cz>
 <CA+G9fYtCXrVGVtRTwxiqgfFNDDf_H4aNH=VpWLhsV4n_mCTLGg@mail.gmail.com>
 <20200617210935.GA578452@chrisdown.name>
 <CALOAHbBp7Ytd-Hta9NH-_HJtVTAsR5Pw2RYrVScp7PPezCEv2w@mail.gmail.com>
 <20200618123743.GA694719@chrisdown.name>
 <20200618124129.GC15447@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200618124129.GC15447@dhcp22.suse.cz>
User-Agent: Mutt/1.14.3 (2020-06-14)
X-Headers-End: 1jltzW-008QMG-Hs
Subject: Re: [f2fs-dev] mm: mkfs.ext4 invoked oom-killer on i386 -
 pagecache_get_page
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
Cc: lkft-triage@lists.linaro.org, linux-mm <linux-mm@kvack.org>,
 Yafang Shao <laoar.shao@gmail.com>, Andreas Dilger <adilger.kernel@dilger.ca>,
 Cgroups <cgroups@vger.kernel.org>, Andrea Arcangeli <aarcange@redhat.com>,
 Anders Roxell <anders.roxell@linaro.org>,
 Naresh Kamboju <naresh.kamboju@linaro.org>, Hugh Dickins <hughd@google.com>,
 Matthew Wilcox <willy@infradead.org>,
 Linux-Next Mailing List <linux-next@vger.kernel.org>,
 linux-ext4 <linux-ext4@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>,
 linux-block <linux-block@vger.kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Theodore Ts'o <tytso@mit.edu>, open list <linux-kernel@vger.kernel.org>,
 "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>,
 Johannes Weiner <hannes@cmpxchg.org>,
 Andrew Morton <akpm@linux-foundation.org>, Roman Gushchin <guro@fb.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Michal Hocko writes:
>I would really prefer to do that work on top of the fixes we (used to)
>have in mmotm (with the fixup).

Oh, for sure. We should reintroduce the patches with the fix, and then look at 
longer-term solutions once that's in :-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

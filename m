Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A44AC4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 30 Apr 2024 01:04:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s1bv8-0004TA-LV;
	Tue, 30 Apr 2024 01:04:35 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s1bv7-0004Su-8H
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Apr 2024 01:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cF0+9rEL1kskQRxHfKxwY5K9ckn6EPwkyTuLSO9TSfg=; b=U9u89se2qo8/ckLRLFm2oSjucN
 +c0IK/wTUAMlT/cR6OID+SswqZrHn00Oto0h7RU4e2tmX0AY05TUpnRr1GPFj3JlM2SdI0MuXwEHm
 qwj9y2aAx9VopcR7WVkWTdHUeku/KDIZoVSH8o5M9dkisrpdGQuELsI1R+fEEE/nVklk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cF0+9rEL1kskQRxHfKxwY5K9ckn6EPwkyTuLSO9TSfg=; b=KRrnpH/Eb2JOBc3+ydoMQBBvWe
 l6g0eqGnxnYUChhkutaIRK9T+bj/69MWYT4Tld03YjFJdH3yvWl5uQUccwFrUAPc3JFRF9cuiTSLe
 g+0Q0Ov3HDbXbhK2BRM/eAX+OEfAN4f9pR9HH95fBxjGLYNTUtTDCdfMDw0zFzAS7Q9k=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s1bv6-0002i0-Nr for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 30 Apr 2024 01:04:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 6E493CE0D34;
 Tue, 30 Apr 2024 01:04:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA210C113CD;
 Tue, 30 Apr 2024 01:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714439060;
 bh=bBPqlQO2oBIQSC0251jGuonLUJKhwO1cZZQXMvuKcFY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=o5FXYCyUZOc79zNIed2XkWFQS3ikzxlo6BgSkAs3U9tyDf9ntkzFtNm+K7L1wbMbg
 3DjjhjsK1KWQFd3NfkRw4JD7yYua7HDN2parVDaj2WokTEThzTo36FkqrkXtTsVXFk
 Va0vYY9sZfePpzLrbSGdK3dslglDaxAegx3oJ0OwXfIWbA0uNn0vlB/tL2LoeZ+rZA
 Mxk70XERkis/tN20oWkN5WEVxHQn6g9KiS0Te+W6ghReIKB7cr+sqGrbkPxXKgm4Tu
 HhyFOfs4cfHI9eYXTowd/ZDZktnVIlt6tHGFzpZp/2oCswfX6UCckkgqJ1EfzNT4Uc
 hofKUgULJ3Aeg==
Message-ID: <b3545ac2-dc2e-409f-ae2b-4738de23ae17@kernel.org>
Date: Tue, 30 Apr 2024 09:04:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240410123848.1291821-1-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240410123848.1291821-1-shengyong@oppo.com>
X-Headers-End: 1s1bv6-0002i0-Nr
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: align each device to zone size
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/4/10 20:38, Sheng Yong wrote:
> For multiple device, each device should be aligned to zone size, instead
> of aligning the total size.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

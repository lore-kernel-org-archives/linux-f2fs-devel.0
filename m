Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CD1CC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 23 Jan 2022 08:52:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nBYcJ-0007ID-Q1; Sun, 23 Jan 2022 08:52:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nBYcI-0007HZ-7z
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 23 Jan 2022 08:52:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C7JzkqYkhujzzhKLyJaWgWl3gbvnDON52ETkXDnAE6A=; b=j6H8kf0Mx9xvxPJtEjOfXW2fDZ
 gD7CLZs9ym2MWsiJ9JOHyMDVrjN9QQEwqIObaqHmRTexg5X9EXQQXGxQtfJM0WWTDDSEEWoyCMW5W
 xmNi/N7xhN7wT9M1Y8Z3r7mn4gt4rNQTZA/ZxPZlaxWYG5rcUm/11ZF9kmKy10zxkIEA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C7JzkqYkhujzzhKLyJaWgWl3gbvnDON52ETkXDnAE6A=; b=RBPmQgb/En/5/gCyXrVbZ+5L97
 3EVUmPDTAThtXMiqVogDZyQGGestghMOghOIFVCSVtTvEqWJ0dPT71dAuh2cspydXQVxPUAZn2N5W
 qiYSOgd5sIzREAYE/lUzKsT430wJzzBQd6Q0Kx2rsZ+b+HkP/jleIyV82hqzCIpgS6Wk=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1nBYcG-008VnH-5J
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 23 Jan 2022 08:52:52 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id DF0E5608D5;
 Sun, 23 Jan 2022 08:52:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70560C340E2;
 Sun, 23 Jan 2022 08:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1642927961;
 bh=NYsqCCt90fQdzerQuxJfqP64AtikesjKGjnT+TX77jM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=coeRNDIOzh6gBvra5K6VTCV60+ax8efalm/FFgnQcqJfCkR6iRVaYlwtUgn+MmF9J
 +G7qVm2q33VArHo+1aoyvFJbmtMxInlg0YuFDn8D8CKRGrkyRDS/cGNFWnKKMl+D3M
 8JzMMQMH30RKeViHql7c/PfYJH0hQl8FKZucjLdzf5viuu8vwlpw0nfS09nwblYQwl
 sGluMxfqKUgJI2aBqFOp5bNmO5O4+lOMAZ7KNcuIQRieiVI5hyyReQgsrhjHt9Paot
 vh+ymx5g+30EMuaqZuHfX2zXReH4DgZTInerOUYI0veTS9VJwmQAdgPzlH3DkFC1Zs
 dY5+kAaAj/c8A==
Message-ID: <5e2dcf6b-b2a2-868a-9287-3482c4a2287d@kernel.org>
Date: Sun, 23 Jan 2022 16:52:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Harry Austen <harryausten@hotmail.co.uk>,
 linux-f2fs-devel@lists.sourceforge.net
References: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <AM6PR10MB2838873D61CE1C0DB91EEDB9FA5C9@AM6PR10MB2838.EURPRD10.PROD.OUTLOOK.COM>
X-Headers-End: 1nBYcG-008VnH-5J
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix fileattr_set unsupported attribute
 handling
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
Cc: jaegeuk@kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/1/22 20:59, Harry Austen wrote:
> FS_IOC_SETFLAGS ioctl should return EOPNOTSUPP if the file attribute
> (e.g. FS_NOCOW_FL) is not supported, rather than silently ignoring it
> and returning success.
> 
> Fixes: 9b1bb01c8ae7 (f2fs: convert to fileattr)
> Signed-off-by: Harry Austen <harryausten@hotmail.co.uk>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

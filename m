Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 929D5C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2026 01:58:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3C3IiX7aECpYbAZtTuJUmtksy933INDBACdT54JLarU=; b=TlgYuWSLYnw0agZ3fSTWZxzF7G
	L447jHXwaMHpII0+yr1Z9lkwLdSR8igbJw0qKC9vvOGk+qC1osl1fclDfOOknb/BUvN+PXaJf6Mw8
	WcV95lXey2BR9HH8shfz6RISzutMNsUtf5w9rQspnGTDycTF0mJKXB2N1O81A+BYsImQ=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgv4i-0005xp-V5;
	Tue, 07 Jul 2026 01:58:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wgv4i-0005xj-Hr
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 01:58:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=yX6kQd4IxcUrVBpyK0AZR0ZFyYkTIptJMlIrBriMmSY=; b=kFZB6Zp5XIHxg0iYtZvlKA/tdZ
 WxquEE85myCiw7+jsMPOmHOdWwAKXJVD3CH6aAN285OGD8QKWcefvZJ1/xNh/OUdeUzRmOWGFLWCs
 /lXi0qlmg8WEsUWBfUFFBkM9ccVhYt8mjAcYGBP3gf4CiRc49t55GU8hvUdMgW0/13CM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=yX6kQd4IxcUrVBpyK0AZR0ZFyYkTIptJMlIrBriMmSY=; b=gsOKow4JYdj5i7b784zg4kr6Cn
 ZCq2aSdqpCwsHoDHPUFnHOOcb3bwSFd2l+YIOlop3GK1HSUHHzZ4tFGYZr2lGavmyb1fXpagzqLQo
 f/Ff3YPVJ+PsneXzlZrHFyBUepz/vT+gZxIL9rNpRzdQzRK4pPS4H7YNVi5KDHFYUi0w=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgv4i-0000oA-CJ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 07 Jul 2026 01:58:17 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 871F74061F;
 Tue,  7 Jul 2026 01:58:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE581F000E9;
 Tue,  7 Jul 2026 01:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783389491;
 bh=yX6kQd4IxcUrVBpyK0AZR0ZFyYkTIptJMlIrBriMmSY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=OpgaYWNucNSz/C6IiKyQu23dJbn/Oi+ZR2f9xvq+3MRZ94VMSBiUHS2UDXABp+00i
 eUU/G7bIkYKxqOMKx+ZdkF1CpAh9FcqNHChwlfB3P94JQ9fpBvrYO4AyGHJkvyurB0
 VP9Kg4ezadElVCmVYUhyJFaliqz204JO8bPCrk0a2mDRi/mABXDHi8tTrU5urc4WIy
 5jtvqyT8b+QuOI94s6gdEQ9Fws2zWZkd+JmqXvzm3r1sNbYOJ/bW+mJDpwp2atx/sr
 1UR3QaoB0uCzam68k7oVDOQjaAtQRPbAE8eukuGsrabEbeTKKzxpwCegOi/AkkLw68
 Nwkz5o0plWfSw==
Message-ID: <dcc490cd-01f5-4d11-84e0-f37efd1b6b47@kernel.org>
Date: Tue, 7 Jul 2026 09:58:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Matthew Wilcox <willy@infradead.org>
References: <20260706095943.2560208-1-chao@kernel.org>
 <akulrzxMUbI5Kr3D@casper.infradead.org>
Content-Language: en-US
In-Reply-To: <akulrzxMUbI5Kr3D@casper.infradead.org>
X-Headers-End: 1wgv4i-0000oA-CJ
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: quota: do not use GFP_NOFS in
 f2fs_quota_read()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: jaegeuk@kernel.org, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/6/26 20:55, Matthew Wilcox wrote:
> On Mon, Jul 06, 2026 at 05:59:42PM +0800, Chao Yu wrote:
>> -		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
>> -				GFP_NOFS);
>> +		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT, 0);
> 
> 0?  Surely you mean GFP_KERNEL?

Oops, my bad, it should be GFP_KERNEL.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

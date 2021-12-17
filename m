Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5503DC43217
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Dec 2021 16:54:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1myGUo-0006YV-EU; Fri, 17 Dec 2021 16:54:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <jaegeuk@kernel.org>) id 1myGUm-0006YN-MR
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Dec 2021 16:54:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=knNDUQ7niGXHQZ5y7HivfjeJ7ga02BuvQwiwXgcriTU=; b=kEqe+WTtupdlEQNRmhSbwpAGNa
 tgkw43YaxwzTZ1yhdviQcaUD/MkN5fqsKJrEMbmSfjYy46TtfHN8T/O4tqyve6nNvWAdBlQQsWHw2
 wo4h8pf6Y9bhfgFkrE0rsQ2mghI0wYRRkiSJbCpvKkHnLoZwiYbONFD98DxuRPNzRsP4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=knNDUQ7niGXHQZ5y7HivfjeJ7ga02BuvQwiwXgcriTU=; b=W4K6sXdUntuIZInm7GP9LXvsD3
 fwwG5ED/VxfQ10/KkqTobAB6/qAgANLw7l5Jz3VCaJV2PGwftyqR2fQHxs5cJVDpud12Fkg68zOw4
 TRVZtq2jjIu3KW6CKh40mUzcdOHoRujJvbNsX321IOcFTm1FZ/sTGXz/A9LvH/tje5+Y=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1myGUm-0015tQ-2K
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Dec 2021 16:54:12 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D2081B828FF;
 Fri, 17 Dec 2021 16:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE57C36AE7;
 Fri, 17 Dec 2021 16:54:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639760044;
 bh=4qkBQD3tIu/ijOewv4T54vWUsvjDwIv3x7p5rF+QXFg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=eDg9dp3ckWRHa2B0PTZmxS0cj1PM51Z4Aq9UwtNzHkcQpTUannyqHQCzi503/gxHT
 ATbHDuaJ3Bkvq5LFm+eN2tuJZeKfPy1Qe0AaPap8Y7AdxMIAm8cy71Y7VWw+j/bxCU
 TWiYPN6E5fbcpTeHyjeMy3gBfS5J2ZAXx2hR9UpJ4EaUm6vlfNYx3aUUQf/oTlJz+v
 a1mvFjCy9cQO31k9YomJitxAvAENTDn4WuOA2lvGOnoZk+1cj5d4ZtJFq+nouU4MMt
 dyh/d/05Rf63DvJes8weGRzegatEdPpxjEmoTQd/EMkjLaOrAL1DIrf/v1/lS9/4Dw
 dc8K7DhMyES2g==
Date: Fri, 17 Dec 2021 08:54:03 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YbzAq43KYQqYx5ar@google.com>
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
 <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
X-Headers-End: 1myGUm-0015tQ-2K
Subject: Re: [f2fs-dev] [PATCH -next] f2fs: Simplify bool conversion
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
Cc: Abaci Robot <abaci@linux.alibaba.com>, Yang Li <yang.lee@linux.alibaba.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/17, Chao Yu wrote:
> On 2021/12/15 10:38, Yang Li wrote:
> > Fix the following coccicheck warning:
> > ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> > 
> > Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> > Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
> 
> Thanks for fixing this issue, do you mind merging this fix into original patch?

I applied this separately in order to avoid huge rebase.

> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

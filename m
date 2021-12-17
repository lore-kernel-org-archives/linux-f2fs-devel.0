Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36215C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 17 Dec 2021 01:12:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1my1nr-0002wX-Pk; Fri, 17 Dec 2021 01:12:55 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1my1nq-0002wR-J1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Dec 2021 01:12:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/1K8rYOLHQkDou7PWTTSpKBAyKRFE3mD+Mqnd9ZIX7w=; b=jAFkaGKJwIRfHI7JiLaIipdpZf
 Idz6VfCWSvB6zRh0NXmNRtrPmixAJDNm7yEZGbzE6J9Mi0GQuAdAV67stLHp3Ov7/MHo6StQ7o+O1
 LBFVoM8tOItWcHOtugWiY3g7c6qtDeypds+UQcOwfo4rm2nhW86jOK+qjLzkZEeiIyzw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/1K8rYOLHQkDou7PWTTSpKBAyKRFE3mD+Mqnd9ZIX7w=; b=SjNwWnVePNXKQ0KHWVLfRohXKi
 0vc1ipOYlF7RRAuUe0h69O8jv+Ib4QX+hQRJ2Q6PbG3kb1Gq9EPvJBDIeMA4c2rG4Bqq8egJuOHY2
 MHwxVDnlyQmgVXE2lie28Un6Sc7eyzCJauWV3Y2TKbRG+A4DbJwjBBzbCBGt1WGLScy8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1my1nl-000UzA-GB
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 17 Dec 2021 01:12:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4AF5561FE1;
 Fri, 17 Dec 2021 01:12:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BB51C36AE0;
 Fri, 17 Dec 2021 01:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1639703558;
 bh=dNEoYEQgjj/zA52x4TpNaVzOp8rqbZ3g+gwju71c1yY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RsYt1dh9l+cW+2LV8c+4GZPm5wPN4dUi4gsocaAjGENWnsa08X6cuOTRAYzPO+bhw
 O7s4h/P+up6O+1QEZDU/4XkDrdEofwGHFva5+dC7I22vO9nGynm0OO0IroxBFU6Hwg
 BVEX1cxwcRzpIv3EqBfc3uWsFtVCi+W5rjLtTEwyilvg6dSSwnm9WgzGuhbQphI3rO
 kvoX1eCRtTLLTW+JO+nfxk5as+R3tJmIQrCScTUAETpUFGrwImXU0MenyY0S+oZ+Vs
 el8pDk5hatdP4MP9XgCEkIRUiFJhHOG7bIf5uCCtL3ohNdR//iig7PjgUHQm9ThnRR
 zhmPfkJRaObeg==
Message-ID: <7e51b00a-ae83-66d1-8f0e-920423ac7fa7@kernel.org>
Date: Fri, 17 Dec 2021 09:12:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Yang Li <yang.lee@linux.alibaba.com>, jaegeuk@kernel.org
References: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211215023858.33303-1-yang.lee@linux.alibaba.com>
X-Headers-End: 1my1nl-000UzA-GB
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
Cc: Abaci Robot <abaci@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/12/15 10:38, Yang Li wrote:
> Fix the following coccicheck warning:
> ./fs/f2fs/sysfs.c:491:41-46: WARNING: conversion to bool not needed here
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Thanks for fixing this issue, do you mind merging this fix into original patch?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E0CC5ACB3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Nov 2023 03:25:15 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1r4uuQ-0006oJ-Sf;
	Mon, 20 Nov 2023 03:25:14 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1r4uuP-0006oD-Q2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Nov 2023 03:25:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SQZ7fihhtInVa5HCb4ucXfmi6ZGFbd6lJsVVJkhKHoM=; b=FtXLpOITiv7LUzL2LObmDZGLXk
 emuIjHyYdgRdbjU5GfYyUlUYJFBSiRjD+Jad4v6ivOnoL8DJWRKfVcOb0dvW3ELCjXzEACIT0gh6M
 fPcCoK/mpGLUOez/LkhNcBn1+thJjMsTjHH2jnEJXOY5OInruRwf2DGVeEv0hHq8774I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SQZ7fihhtInVa5HCb4ucXfmi6ZGFbd6lJsVVJkhKHoM=; b=VxwaOi1MUJ0PETBnAznWlpT/ai
 0rchggD7OfXBra0HtcKTjZUs5qLjj+nRwHwArJoOdLI1Vcnz/ZomZWykysyOS0RueP4klhJ2aDXKx
 C2KJfCPmO+Tm6fW6f9HOM/aHm+MRw3QxaS9F2euidDJnhG9ekbfv8/hh8lRz+1hiFwis=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1r4uuP-00AgIP-54 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Nov 2023 03:25:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id D1832B80DCB;
 Mon, 20 Nov 2023 03:25:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F0D9C433C7;
 Mon, 20 Nov 2023 03:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1700450705;
 bh=SNahtbYOT42GOgyX4yJZ4HZNK3VBMBuf+Ch+EnYue34=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Cncp8Lx8ZmMohGUop5OY3ghiPxwwTCAjKT5wPUb8Vo/1wwlrBMv8B4tEOYVkjD0uW
 8o+CJ+tul9aVXqPCZE+bNd2lCNjpakYTrvyumu8pECBEgkVSVwfGfb90Nwq2EJeTeE
 UvKatNVQfSc10X9bm9KnWHXq/0c5BONNWPiFpiKOJpnpu/i3hmdT9vmG3eHdA1Upx3
 4AAqhK6ijyk65IJCiWeozwwfl24CDZdPa5QxnAbmmwS+EV2UHRqI91vJ+SI7yul9Lq
 GpR47WL6B9lCX5jNL0WcynwE/KJ2vQB+4qIq35GcsVHjXs1M9R3WO0lg+1XSJ2Vmgv
 QwLdxtoQwWJyA==
Message-ID: <ea0b14ff-2198-ac42-b61e-653eefce0b25@kernel.org>
Date: Mon, 20 Nov 2023 11:25:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20231117203855.3415891-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231117203855.3415891-1-daeho43@gmail.com>
X-Headers-End: 1r4uuP-00AgIP-54
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: adjust nat and block release
 logic
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/11/18 4:38, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fixes: 0f503e443ccb ("f2fs-tools: do not reuse corrupted quota inodes")
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

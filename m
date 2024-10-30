Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA38DD7494E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Oct 2024 01:15:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t5xJD-0000fQ-R8;
	Wed, 30 Oct 2024 01:15:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t5xJC-0000fK-Mz
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Oct 2024 01:15:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sKMjunQSU62K7iSM8LlbPn/LZV6FceuwI50A1bIrc8M=; b=eYkEttjVKGMrEexHbIw5ZafuTf
 eEWht7Mo/7l7R9wr/FtAOCPsJwTeHJwd/ZEp652WpGkKFuCk9sQUJxDxnA4q6FXDLTrMedah8bgGS
 6iD+5E0qxwFEUXAy3+27UV8x+8MEVPswJlu8YM5W8+q6mg6+VMWjmp8+BEDm1CLH4rU4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=sKMjunQSU62K7iSM8LlbPn/LZV6FceuwI50A1bIrc8M=; b=FP0RjxiGNgyefWrM1VJ4YKEeT/
 0E/AurYQY2Oc9dnBYEssDxilC1Fpmi2jSdjEERiKj6Cqv9pjn8PoRkeU++5fJoOlL1NWPfEKGGBNo
 c7yRNFymyG9HGHfrYR9vdx4IyISVt/XIcXjJe2AU51l+lf744jGfVZyq3tGo5KiZnXFs=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t5xJC-0004X9-PY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Oct 2024 01:15:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 28888A43688;
 Wed, 30 Oct 2024 01:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93CF9C4CECD;
 Wed, 30 Oct 2024 01:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730250932;
 bh=nPbbsTDb7XfaekyVKBI0hGWozKznf6W/Da+mLTQB0Z8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=bLIkzWgrPFxGJNEn7CpiQwT8lpP4gfuUFY+ibq36wZC2O/2QoQRGOVtdN4Kfq3UOg
 jzrt9bFALMibSSfEXdo9Ka6LDiG9YXZ1OOVQa+q26QOMwIoNiGr3SlBmuzHozEXff8
 5o25be3+mmo7zJzpjYUq10e0MM7AxP1GXAD/VG0IeY7XTq8JE2Nzw0RaHx5JPbVSJj
 66pi94Byxr12EXttp3xgTVeIGgddj/p+Y8e+fo67+Am6O420x2q1FPfXLXTzc7qmBY
 UkVnQxZ9kU3TOWQcWFOmMSKVS5h+yHuQ9/F2Efc5Vbuwoooo2kU8mSek5VK1I9Lovr
 Oh76XqFuLZxiA==
Message-ID: <e3fe4218-4d2c-4bc6-beb7-0f69a2f780d7@kernel.org>
Date: Wed, 30 Oct 2024 09:15:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: LongPing Wei <weilongping@oppo.com>, jaegeuk@kernel.org
References: <20241029104907.310781-1-weilongping@oppo.com>
Content-Language: en-US
In-Reply-To: <20241029104907.310781-1-weilongping@oppo.com>
X-Headers-End: 1t5xJC-0004X9-PY
Subject: Re: [f2fs-dev] [PATCH] f2fs: clean up the unused variable
 additional_reserved_segments
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/29 18:49, LongPing Wei wrote:
> additional_reserved_segments was introduced by
> commit 300a842937fb ("f2fs: fix to reserve space for IO align feature"),
> and its initialization was deleted by
> commit 87161a2b0aed ("f2fs: deprecate io_bits").
> 
> Signed-off-by: LongPing Wei <weilongping@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

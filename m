Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9D8C3DA49
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Jul 2024 09:48:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sXHYp-0005jN-Dv;
	Fri, 26 Jul 2024 09:48:26 +0000
Received: from [172.30.29.67] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sXHYm-0005jG-1n
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 09:48:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vidH4iLP1JWHsUEWB4/libtZns1v4/S1G0IlFrO97ZU=; b=I/S6YJqr3yjLQIZgAGQz2juLl/
 ZGMroFnAuu6YcQm49yMwjy0Nfz/nVmRIg5yo5ao2I4lSo/xPDmW+2badqT4ReXTPei4q7HmODAc3T
 RPHBUhb+Rdmq45Uq5xRqSans4fMo6yzQq4qPbkMu/GaHoiWceH4HbbrNvCzfLhN0sFrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=vidH4iLP1JWHsUEWB4/libtZns1v4/S1G0IlFrO97ZU=; b=BLua9dyZ5Na8T4mBubkRl/3uXW
 bW3E6izRkVNSTOS+oN/UiYrSduwuBTZ/FYZtaDMoKmUcjmJXNUk7FDKa7xVn5wFpa2X3Y05RARHmB
 06KjLpBi+4Kls11rCoJuBKtHgj4i3JQs/Sf65moIxgahpymaxEM/DaHdi/4ssnSaPFOs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sXHYk-0008KX-Sq for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Jul 2024 09:48:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 866426167A;
 Fri, 26 Jul 2024 09:48:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08B3AC32782;
 Fri, 26 Jul 2024 09:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1721987292;
 bh=ayFiWm/WuLiRqH9qfUcMqJzUthosUQpNHRXQfqPxzh0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=eaPSsyuCMQP86llfgQDA1ySdbYR6aBaLeNkBRtKVR3X6CHh69RkYzp2JzVIlpi01d
 lGHolw4U+Pfyb97x6qOgs6jBS8z70YRixoApdAR6qWPo38re8JBrWCYUTyrNs1sTbC
 47HYB6nXLVu7T9mzqrsDAjPfAnfl8ujwmGnYF73VeFXSQEOTdrYXZ/FIL8dUrS3iCZ
 pKIdiVpLAOWWp2v41kBMAIl+WAI6EjECKORLUBgZAEhKdJ6iqBKcTtzWYzH0XcM87l
 VmUYTMTFin18+kxe1Vj3Ab2fIDYFKrYkwT6rFN+KudvjlznCIowQPztZfFFdCjdTkY
 XQdAaroVat6gQ==
Message-ID: <3b871ee3-c246-4eee-8929-d0aab014a41b@kernel.org>
Date: Fri, 26 Jul 2024 17:48:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20240726022550.3117469-1-bo.wu@vivo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240726022550.3117469-1-bo.wu@vivo.com>
X-Headers-End: 1sXHYk-0008KX-Sq
Subject: Re: [f2fs-dev] [PATCH v2] dump.f2fs: add checkpoint version to
 dump_nat
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
Cc: Wu Bo <wubo.oduw@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/26 10:25, Wu Bo wrote:
> The cp_ver of node footer is useful when analyzing data corruption
> issues.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

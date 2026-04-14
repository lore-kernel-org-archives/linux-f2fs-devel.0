Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19B22ED7B82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Apr 2026 08:23:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7sIdYo84nHg6Pb82ArKhsF2ioBZstldCdKDUqfuxbzI=; b=Row6nb53BMK/jprj6XtjrKvFz6
	4XUbPgXuflFtBHk4obFT6k+sCHGjFEloK+m1Ydvu5lVHPeoViZ7qUlOlWtUTM7XRmoFoGi+xr8EzN
	r2gUwkHwa9oGwwhLYRdBljATShC1luHqVvGdI/Yh0i3fCNqWPUKQnm1erVr7jAIHz5B8=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCZ3h-0008GO-I4;
	Tue, 14 Apr 2026 08:23:45 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wCZ3f-0008GF-Jp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HsAGPfK5DHBnIvQrxGIFbMNzF8JIBL8C6IEgTjsWExQ=; b=aKsSeUGQKwASDj+k+440CpaRpm
 E6U8m+gJPqF+z48jimxNEaeZBvhuWuKppnBnZ/bSdtJZBquK3VUMVMmsomeWKZ0h+VMQEM6dJPFRf
 WBhZ+huXVP0SstB9ANFWsiSwMNwhJDawmDR+4wVQTWYDALBQG3vRjTcEg5+vzWbYPFtQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HsAGPfK5DHBnIvQrxGIFbMNzF8JIBL8C6IEgTjsWExQ=; b=QSQwxssZP183o4/so2cqEzBALc
 BrzevEXWYnRP97t/r1Kgw7Y9xgPfrOtrrTLM0HONgRbqNj/NHJazWaPl90HdCaYMwxTTIrPpxUy7+
 uAM6Bjx+6P5JhnS9Q5bpMvgXPQqs8W+/F6ntAzvKn1L8k9cAieS36AUAvgqXSa8Ahw20=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCZ3f-00058P-70 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 14 Apr 2026 08:23:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8BF536013A
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Apr 2026 08:23:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0538CC19425;
 Tue, 14 Apr 2026 08:23:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776155017;
 bh=GY1UGE4XxmrlwbSgbeyZ5DGUELQ03qNS4/iU5TvBbvg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=CfPH9BW0Zw3JBKQ7Jmij/w1aEHRABVgwsiIw5Rizf7Saoe7MYj7+FHJMUEbH73Aj7
 yvhXo+h2u+Ct02Pw0lz+Cwm4ZhNp/68ABBx/EFpvqZn1HTF8ss1kIIfXn+NYO9//o5
 t/7BeIRWLEToXH6UXmW5BxFNudIWnjGioBDAdUBB2l7W/SLUzbB1uy+M94BI1+6TyN
 BzqXqDCTSmNtoae/zQCniJyKuO6w+CCkdJCNeI8qJaM+7fF5srPHHtLA7f8P+Qwbyb
 ndD/LfY0ZA2T4w2H2eQZ44B/NuoEuxAFu0bRRMFI6fWdCcXnmLKH7mdQhopBqK2GCP
 z0gQJO9xv088w==
Message-ID: <1e352056-fe01-474a-bf2f-8749db06c4a1@kernel.org>
Date: Tue, 14 Apr 2026 16:23:31 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260406154940.2407853-1-jaegeuk@kernel.org>
 <adaasm42rLxRY2GN@google.com> <ad1yRX54HIx-PAf3@google.com>
Content-Language: en-US
In-Reply-To: <ad1yRX54HIx-PAf3@google.com>
X-Headers-End: 1wCZ3f-00058P-70
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: do not support mmap write for large
 folio
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/14/2026 6:46 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Let's check mmap writes onto the large folio, since we don't support writing
> large folios.
> 
> Reviewed-by: Daeho Jeong <daehojeong@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

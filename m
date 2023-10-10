Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BE96CD68E2
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Oct 2023 01:33:49 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qq1d5-0000Qs-1j;
	Tue, 10 Oct 2023 01:33:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qq1d2-0000Qm-Kq
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Oct 2023 01:33:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ATijSjr3XrdfhruszY849EXi11uQKJ3vSHd3p9+RMuY=; b=VA5VoNJJnZBHRY3vuiMjKxMykS
 k2+Zm0ynbbDKf6Ge1mua1lHU44h4I9Kz074x1n0NxW+LanmwjJDqx+YhR1C8sZt4P4TAh+UcLmBWT
 tuJPpWRiCFJUvt3wMTYjF7Gf8ogOh+QRcootw75UXCcvE//34kmvBsJ+gIzeJ5CU0hik=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ATijSjr3XrdfhruszY849EXi11uQKJ3vSHd3p9+RMuY=; b=OJ5eo/FLKGg9aOD/GjVynL9fRZ
 +ZqxKbOUEzQFsgmBWgSUpZ4LT/kvKneqsP56/jRFM04DaR19+SDqQstxTEZd7amJW3tiwWM81Gh/t
 UmGGwK3Y6M7/TEni0QuRDQVk/aPsJohl4RIQEFHANwg+NNP3G4vaLFHS/hdsHe+5OI3M=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qq1cz-009Y96-8M for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Oct 2023 01:33:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by ams.source.kernel.org (Postfix) with ESMTP id 8D353B80B55;
 Tue, 10 Oct 2023 01:33:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5F3C433C8;
 Tue, 10 Oct 2023 01:33:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1696901607;
 bh=eGsp9/T6AgDMD7GkgtTAVxyPrD/DSIMJzyoXuo9NnEg=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=RSbezX6ZUdEhKvcV40mbAmBg+ELQIGIiiy0HZJ0EsaB7TNIBfe24HWb0OYF0gB/Aq
 61p8H0FV783cAnuu6IGWgP9D3iwk9XWMMUgzUKDTWgdrt8S7gfhlRssm8C6KmCKGnS
 cuvxrcVC+H9zofp/aiS2JAeQAR4zSHzlLcoRwxnvqdQtUFJxKXCua1OSpe0PkeCBm2
 HgHpsedveENpXASiEKsFwNM33TEsffJni0cKwEPnRO7Qs1ynjxcyMym5sFQT+GFlbL
 GgBo/zLYLbKIvNcEZp0YQkWhX0tx76mfviVxe71nNYLHadDUn6IrhJdJTupmcNQuh3
 G89pqYnEssZww==
Message-ID: <f8ae6ba0-7dee-3dc2-1e52-5da101c10c08@kernel.org>
Date: Tue, 10 Oct 2023 09:33:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20231009202917.1835899-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20231009202917.1835899-1-daeho43@gmail.com>
X-Headers-End: 1qq1cz-009Y96-8M
Subject: Re: [f2fs-dev] [PATCH v2] f2fs-tools: use proper address entry
 count for direct nodes
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

On 2023/10/10 4:29, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> For direct nodes, we have to use DEF_ADDRS_PER_BLOCK.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

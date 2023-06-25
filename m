Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B43EEB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 25 Jun 2023 02:49:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qDFoo-0004FE-O5;
	Sun, 25 Jun 2023 02:49:38 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qDFon-0004F5-PS
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jun 2023 02:49:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=iLGRoeSGyFmOPC1Qyb/FuUW283/rpk6k4bUV2iHsDVw=; b=EYG+/A/jgmhtFbXsrW/609MGby
 /FFHejZuTl8tPnssc88Sn5aamacH3jsCNZyuhyHDr+i0UPr/tFn6dfEf2D6x7nIpBdArxnKDw358P
 /VIv3Bq4iUTScS4Fe+h9vFjWsTwMx/iK2MEvJoAqNLWTprCVXLGKuqIiatifBgWBJ1vU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=iLGRoeSGyFmOPC1Qyb/FuUW283/rpk6k4bUV2iHsDVw=; b=l+mwMptxBnQTAqrEJmGzldI4kH
 loS67aOYm+etAvJ7NIDjfMs2RwaUiEDA2rt9h7Q4BvEKbwmHp8EDzRNqbfcYfrxbKqP2cXCZor3qE
 H1kSn11j4NMG4A1ybOiyzgYqGlQ0w5bbJEKN7jDX4/vNWWlDrvI1Yd7gmZEt4PgDIorc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qDFok-0003tt-KU for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 25 Jun 2023 02:49:37 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id D3E6660AFF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Jun 2023 02:49:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8130DC433C8;
 Sun, 25 Jun 2023 02:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687661368;
 bh=tL3Gj1PIk7UuZH0l9O4zgOWekRCYpOwLBRqQia9M+ok=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lEvAu9XPj2y/JfnXjJdiGEx728X/4xT7syjWHZ/gPoajwdRwmYXX1Kl3O3MGTzCMC
 nZXa9JRdhIx5Rvw8Bitwrrpc0aK+34re3QEZ4JjK57UdaFFVaX6YjuU4IGs5ZAgg5N
 xTopSIMt/EUj2gp28HxowRp/AVTZPZtvYwKCduRE66w+itp5hiqqOAYGdo4rpX7se4
 8wxWVeJU3EevYYaNubP3mSOCPOzySOB6xb9c71V4MBmxcWwYvX5zf5md11JNkrdazG
 uQyJ98fpPB3lyhJxBlCDj66pUrXbbI99+387LEBiD/ozhklZf0LxUrK5ZQLufMOR1E
 E4TZcRxDSjR/w==
Message-ID: <3dcc04bc-7388-42ab-a771-1fc07e0b772d@kernel.org>
Date: Sun, 25 Jun 2023 10:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230606203645.3926651-1-jaegeuk@kernel.org>
 <ZIjqKHDUmN6u9pXa@google.com> <ZJP0aoy03Vx2Q2K1@google.com>
 <ZJXvYG/q7gZwEuap@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZJXvYG/q7gZwEuap@google.com>
X-Headers-End: 1qDFok-0003tt-KU
Subject: Re: [f2fs-dev] [PATCH v4] f2fs: compress tmp files given extension
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/24 3:15, Jaegeuk Kim wrote:
> Let's compress tmp files for the given extension list.
> 
> This patch does not change the previous behavior, but allow the cases as below.
> 
> Extention example: "ext"
> 
> - abc.ext : allow
> - abc.ext.abc : allow
> - abc.extm : not allow
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

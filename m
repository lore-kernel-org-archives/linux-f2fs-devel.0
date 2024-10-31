Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0369E6895A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 31 Oct 2024 07:52:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t6Pyu-000287-C3;
	Thu, 31 Oct 2024 07:52:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t6Pyr-00027y-2w
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:52:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+fK7l9lsqeJNcg7mr3dl2DsjGpAnTlP+yHPfAdAFvJM=; b=mpMPplhadxSlhmkHnQ/kXBND/e
 9tpzqyzTWFvc3DzsHbd3sNuQ5SEvocOmpNR0PT0daSRotoaavnG/ELedVIMieyWMCDSL5byuJuw31
 x5OILDWUYaKn40WNT3MI1dH5DOG9Zq5LtNLqaHrxdj1W+SCdAKLpuY1dT0rm5s2yi/Cw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=+fK7l9lsqeJNcg7mr3dl2DsjGpAnTlP+yHPfAdAFvJM=; b=N8JkVVUvDZWGnD2XAWxN5PL18U
 dxH2P2dV5E6Re/9jHNrTl0NMHp7WTXFZ5byZeiIzZfC5Q9yFzYnpSRYMM9J3Jl95digF980Bl1oLr
 +s8VYDMWOz9M6I1g5DwjSciE+E6rtfsnP90IaKefqPX12S50cBjStFjNeMrZCkxiARK0=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t6Pyr-0001YF-74 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 31 Oct 2024 07:52:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id D717FA43A89;
 Thu, 31 Oct 2024 07:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0D2C4CEC3;
 Thu, 31 Oct 2024 07:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730361142;
 bh=Jl0XW52+cFk9nrdRa6KzZgnMH8eJ0pB33RCLMYvamS8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=rXADya1nPv23ljwSNaT5ufh62cgCTwzHcalOLNZerQfPWbBudN2pNyDFDqnv6p6ZR
 UHQI0pXlZg7fI3HE2P31DkD5zes5k0lUPXCurOr4Kh6QKlCagO+hrRmcXTxdoS9k0d
 vbOmstGmkce6CbBHio89wOSwNQ94DDWmuFS38Qu4KV3nkg8lsJ7RVvbmadctmMV9ES
 gEznWe0ZFmOA5/vkf8TVowjvhB6W56PP6IWRPypGFWe26J/P0/X64uwEPWBV9dSxg9
 T2pn+me3zncpOcb6zPp3Esmh0lg+IVchDFxqXodgZu/8GNSaXspJhFWtlrA0m7+Hub
 6r4SXQrjZlcRA==
Message-ID: <8b06aaba-e626-4b9a-9963-85ad8b89c866@kernel.org>
Date: Thu, 31 Oct 2024 15:52:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1730354393-19672-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1t6Pyr-0001YF-74
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: remove redundant atomic file check
 in defragment
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
Cc: Hao_hao.Wang@unisoc.com, ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/10/31 13:59, Zhiguo Niu wrote:
> f2fs_is_atomic_file(inode) is checked in f2fs_defragment_range,
> so remove the redundant checking in f2fs_ioc_defragment.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

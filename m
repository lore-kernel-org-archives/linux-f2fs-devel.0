Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44986C43217
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Nov 2022 14:21:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oyD6e-0003Cu-Dk;
	Thu, 24 Nov 2022 14:21:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oyD6d-0003Cf-2c
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:21:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0Hv71tDXcUPEB9qe7O5v9FbjvA1c8tTKfp9Ik1D2zp8=; b=W22BYUFB+KCnPK+n1d1kKEyCWK
 S6KjMqTwCBoCzkhCWp34X4fLEHIpqNkLfGQsJr4Ckfl3e4ONYNtmMRmCxE5m1G79gTdD1lska8geA
 uquhT3nq5OvmDtpwaML6CBuWI0oM2/lOTmckmO+kATK2AlhKtcdtEiK3Gt16WJ70sNBk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0Hv71tDXcUPEB9qe7O5v9FbjvA1c8tTKfp9Ik1D2zp8=; b=Ktudb/nNjyJtydU2tSX2Wt+wxZ
 j9ET109EOHTkPQ3Ige4EgqI6FQf572gjWFsQMUG0Gf3cGtZGT2xlwyQgf94LpWyobeJ382ZhBQO6s
 HWdwlfZUX1KQciDtstE/BCdKyLCi3M4ZjbhKOST5hRPhyI5tdGEWzssv4MdeMkaRP/z0=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oyD6c-004oDo-ET for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Nov 2022 14:21:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 26851B82803;
 Thu, 24 Nov 2022 14:21:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B56F4C433D6;
 Thu, 24 Nov 2022 14:21:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669299686;
 bh=jCX9ZgHFTBOM2D/hY3GhY26io0Yi+TGwAvmul0YeWJA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=nydjkvx+OF5lVTYV8rH43vkpHcKhQQqC6tEEYd07Oiqzn1WiXzZu0kYGbU+uywXil
 6wk/zH42/un26PPPmGaLOCJLOpByZTQ3SRitmI/pw8miyBrezuOSODRkF0gn6K/VSP
 Mj8TCXFkOaRxAQ5nsY+6BuoC0k8fQRPTadr3FtLfkV6NPdsH/4nif3jjy5GKClYJ5V
 znpKU/cONFfmS68Yx56gyKLBBgwcxVV9Y8XA61i4AH6KV/UNv1k4Q/P7uNz4DZYFYL
 t4YFS122XHyyjPyKjBIUHViCYx1peSrTpLMBRLnbQj2ypFUcZVW1FCaoU+QnrO6Ilf
 XhS3VeTJsJe+w==
Message-ID: <84482d90-289d-7575-ebf3-2affa16a370d@kernel.org>
Date: Thu, 24 Nov 2022 22:21:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221123164402.13849-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221123164402.13849-1-frank.li@vivo.com>
X-Headers-End: 1oyD6c-004oDo-ET
Subject: Re: [f2fs-dev] [PATCH v2 1/2] f2fs: define MIN_DISCARD_GRANULARITY
 macro
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/24 0:44, Yangtao Li wrote:
> Do cleanup in f2fs_tuning_parameters() and __init_discard_policy(),
> let's use macro instead of number.
> 
> Suggested-by: Chao Yu <chao@kernel.org>
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

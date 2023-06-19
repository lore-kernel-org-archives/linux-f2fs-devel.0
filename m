Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ED10EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Jun 2023 05:20:35 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qB7JY-0005ru-45;
	Mon, 19 Jun 2023 05:20:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qB7JX-0005ro-7i
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jun 2023 05:20:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZxpwI7dfhBwFKwaQNvHNP489mvSi6n3Qqmaud4rDcBI=; b=bvdg5Fm+U975XUi0oQJn9BG0m6
 bOhGxGHrS0+o1MWN6iJvTxU5Cqh31JeTySU8eRzAd9Zs1R2u0r78+c5y+Ngq6PfJv5ZNv29hHyftV
 JIzsyFUPJQTLflF5KNkUfptuJcTWLch/SFu67fNS06EhVXgz8r1Yf+flq2wqliMz006g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZxpwI7dfhBwFKwaQNvHNP489mvSi6n3Qqmaud4rDcBI=; b=BvpxY2v7x9ArA+j99oLDPQ0ki/
 v5oj0ENXQNyzgBzkaO01gbqBTQgRyhOUkOxxWSC9NkFWbvWNilsXLpzwqbEBh3UutRS0iqVjX7FIn
 pKmIrNw+ME1AC45Herh05HXzbrOsPMbpSzWugZ4akxtgmLwt0uJ4tntDKpotHdIf6SYQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qB7JX-00045O-5m for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Jun 2023 05:20:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2CC2B61129;
 Mon, 19 Jun 2023 05:20:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA02C433C0;
 Mon, 19 Jun 2023 05:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687152019;
 bh=ZxpwI7dfhBwFKwaQNvHNP489mvSi6n3Qqmaud4rDcBI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=sJlEq6GcOw1C6O2vsuGdQu7YZKvTkEbH4hDdMSlyNizSUeNbMuh/DBrLTM1MjDqQv
 xCrHiTjINLySXaeAiCwwbJwgb/JPusYGtqtNpDcfo9iHlL6kVYjDb2bkX2uLH+WnpK
 /j2jdeevX1ZO0JllzJsGDbZRmsdQEuhCjSJGhm0/wDTrwefTgbAcvbflQ1uXkb1iI5
 SP2pkusiWgJCi625UnM0uCXW2eOwPXZMrUNMqr7o7qiKVTBGhuFZuo5UtOuAfOWrV0
 BfcTIaqqBLYpccvtuTRpdnPSIzmFv9wb1+VBjLlFf7sb0yc7I2yfknG0Z67VqbnDGE
 +khQk7iSsGA/w==
Message-ID: <5409930b-4379-b279-886b-a05149436a68@kernel.org>
Date: Mon, 19 Jun 2023 13:20:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230425165857.29175-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230425165857.29175-1-frank.li@vivo.com>
X-Headers-End: 1qB7JX-00045O-5m
Subject: Re: [f2fs-dev] [PATCH] f2fs: no need test opt for f2fs_issue_flush
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

On 2023/4/26 0:58, Yangtao Li wrote:
> This information can now be obtained from the mount, and there isi
> no need to print it out every time the trace event is triggered.

It makes sense.

Jaegeuk, is it intentional to print mount option in f2fs_issue_flush
tracepoint?

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

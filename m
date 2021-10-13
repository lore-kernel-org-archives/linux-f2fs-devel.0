Return-Path: <SRS0=H3Ty=PB=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4A7AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 13 Oct 2021 15:22:52 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AB8460F21;
	Wed, 13 Oct 2021 15:22:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7AB8460F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mag5j-0004kB-OV; Wed, 13 Oct 2021 15:22:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mag5h-0004k3-IB
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Oct 2021 15:22:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nlx/pgy6sjc+wQZy68oQipOZb+n8R/lYATW3AIC2hpM=; b=O7Em4M2aZEuHeP0c6WhPXpU/AS
 DbP4llnTHMvOAzZGnxh4Dfk1SnPob+DFsOyzCmzApwBNo/IWdfW5r+jFQZKhY1OgdpT5GevAysmK4
 WNdkHOakIA5nUHiHP3eP+FMT4JqSt7+daNSH8CrXm8nFcXdtFQCbzWmsiETHxLASw8aE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nlx/pgy6sjc+wQZy68oQipOZb+n8R/lYATW3AIC2hpM=; b=BKUDveY7zfCdnATSX98odG7Amm
 H8PtoRcsj7JuXh3KITeX98eb0ozPWiv11K6tnGvR6WVTuKLIWNK+SOQQ7jOw/MJRLeIR3hfeo9Lde
 4Hft3VO8yTeJaJBxRr0L5wgoKOPpSw1xG9+QajKmBTktVh4JqQH9rljnXte23cUZhp7U=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mag5h-008azM-0n
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 13 Oct 2021 15:22:49 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2B7A860F21;
 Wed, 13 Oct 2021 15:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634138563;
 bh=BtCe891vLfW+speZQd9E3ZgbCkoMfZzWSEEVYCAx9iI=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=YO2Q3KYQzf20NEucNUVx6Oswm3ZojnFmUJpa5NoUMhECTlHOuK039nOXFIdSZ3oC9
 pAkhRpKgy7KqmdYfcxGd2odq86WdIdvjfFIs7lbtRWAkQjYkigrCPLzUh+JbhyAlNp
 vCKTdHpsZoIth6vKb9Xf5WVAHhIEIqBbX70XvevJkp6rlMXlqrxtv395Tt7FGDoNnD
 myESfy8qvCfE9JppV8rnWQ2jysqlelCdUlklBhLisWiBCwaxJeYy5IuCpTJJJVojIj
 BR4dmZ0bMvkAqmTsCUr3CorX80pQ5FGnBDR+KOrmmxZOoUx4xFEJsxpLaMzreqwmFk
 Q5wsxyy8LoFeA==
Message-ID: <5ebc307e-09e5-e064-269d-027c3ba615ef@kernel.org>
Date: Wed, 13 Oct 2021 23:22:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210928204658.2230524-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20210928204658.2230524-1-daeho43@gmail.com>
X-Headers-End: 1mag5h-008azM-0n
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: fall back to the original
 version check when clock_gettime is not supported
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

On 2021/9/29 4:46, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> In lower versions than macOS 10.12, they don't support clock_gettime
> function. It breaks the build, so we need to fall back to the original
> kernel version check algorithm, in that case.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

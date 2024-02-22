Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23F1C48BEB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Feb 2024 09:10:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rd56F-0007kV-T8;
	Thu, 22 Feb 2024 09:10:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rd56E-0007kO-Nh
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Feb 2024 09:10:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Z2LUNTSLbvqqSUsjRP0tLHK/mYtVKaofFEGgGpi4xQE=; b=fKVARocYRpN6fUgwIQiGxMGG3z
 BWXcFd7durtfLGdwZHScVUEvsBGCCMY/sBYo1vmJJrYXIxtmGx3GFG34axs16I+pA0bLiBOcUwxTB
 D/kDviGIej6sZTUzkaY4f9pfZ/PRKDfc2P9WUc/Cbrjoc4Ip4aNVcJbqeuHOi+UyfSGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Z2LUNTSLbvqqSUsjRP0tLHK/mYtVKaofFEGgGpi4xQE=; b=Zv6w1ONdMrm6Cc9uLAfiOzZA4/
 nytRiUbJ3Gu6qMjjMdUK1ab721WzWjjLqpJvl5iNHFH1ggWhQ+5w56gHVClkY+yP8cCs7k6V87WA6
 yrRxOqJYsW9Jbjx+TkaP0wD82wjtdmq0+4mYD8siZM1sJWrR0i41ylE//uXs2fwPmbCM=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rd56D-0000HS-6L for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Feb 2024 09:10:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id CE00ECE2176;
 Thu, 22 Feb 2024 09:10:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F4F6C433C7;
 Thu, 22 Feb 2024 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708593031;
 bh=RFalUYkBmcGTV3GPMXC8E8juBdZB+mNdbxu4e+7Hxyw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Shrc99by/J6jsJD8H9x3QKQ6EdYH1gmWrP/HSD0/w1TvyWKdtV4wkr5QZW/0vX5HC
 rGVfgPj7puHAfPPplbPdc2YMcuD82aysSmh0AbrjZNQxeokeA1ps+RW+4dqq2rlaHG
 wILxeVsklCgLzIDSGGmmPeSUNKzz/AAfsUNrX5Bxhg8m0rKG65oMQqfEM2pT5c6u5T
 Iw1z2EamV7TQLmTFEdp/9AyRbyd9i3No48oZl9u+Am2b+YwFfzrq9wldjC2zBIO4c9
 IHTO2sbviRLTPK+bQoC9rWO/aZxblo1HdjslFDQ5YnegGCD6xTsVqSbN/aLLX4E4MX
 4yx5Sbj+qO1Aw==
Message-ID: <c037eb03-430b-4a64-a8ba-2a02da18dc4d@kernel.org>
Date: Thu, 22 Feb 2024 17:10:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240215201633.2365333-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240215201633.2365333-1-daeho43@gmail.com>
X-Headers-End: 1rd56D-0000HS-6L
Subject: Re: [f2fs-dev] [PATCH] f2fs: support SEEK_DATA and SEEK_HOLE for
 compression files
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

On 2024/2/16 4:16, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Fix to support SEEK_DATA and SEEK_HOLE for compression files
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

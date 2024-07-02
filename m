Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52A6BC2BD09
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  2 Jul 2024 03:16:25 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sOU0F-0005zW-8U;
	Tue, 02 Jul 2024 03:16:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sOU0D-0005zN-NI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 03:16:22 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KZ94xE2kUUhJANlJ1yUZ+uoYnUZWwQg/3d1neOHXNFY=; b=enuOjPkwcPAxQ/ci862O1Jp1QP
 /vshOJ4pm58SWsVTB7ddY5P0/lagmpBlXbfnwsdPOEzqg6X0ukqT1Ql+7uBdT1qe+EyVh1XF/XvK9
 +5m6rALSpXhVgTWK73ZLsjq2073aiQN7PrG6ndI/anbriw9biqZLjTgWO/tR9ZMe/Uao=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KZ94xE2kUUhJANlJ1yUZ+uoYnUZWwQg/3d1neOHXNFY=; b=gPl1JM4DGHAdsLmo6M+hDATUoi
 FDI/jq85D9fZTtCAn6y7oudf+CHKWSqtnr4ohy2Iai+suBrKU0adUV+PE1YJw/ZmCSAkr4CfYWiUV
 OsTwu/n5VMxFA1HfVjXNcm8UmH8PpSkXeXIPKNyG6d/h65FTCSI3h023P0HgiMMnXcKI=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sOU0E-0000ut-5Q for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 02 Jul 2024 03:16:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 83200CE1B52;
 Tue,  2 Jul 2024 03:16:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09588C116B1;
 Tue,  2 Jul 2024 03:16:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1719890173;
 bh=rjCPkBW3Zodt1US3UCxj12wcCgbfUIOp5kMBGaPMW9o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=lFyOWh7mhXDP17umMa7oftXH551hRRJXurJmjgXv6LRt/4sBPYK32mr5NoZLq0lof
 VTGDSmMOn4saP5CdI00/swom+snm5ktOjqQDi3kIACojE7KD5W1Kz1uFlpJsyRxbx1
 rn0i6VaAqgHuzKqNR9h3ak4ss/KT/7UM1gcqX46lRg7xZueMd1S19bPKMckD0p7drX
 QFyR5UKkSgoDnkzB5lhnaohnssWI6l/KD7qUTYqVwEAtg1cj1ETa7yjqdGlyPQ3uY9
 h5WSBx2mT4n+0ZQLKSc4g7LTi3B93QhWR/6JhJyWhR/k1rW6jyogWH6rKsV6xdfD4n
 IUfwi+rQFKUSA==
Message-ID: <f4471761-8f06-45a7-808d-86f56c09e476@kernel.org>
Date: Tue, 2 Jul 2024 11:16:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240628013140.2444209-1-shengyong@oppo.com>
 <20240628013140.2444209-3-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240628013140.2444209-3-shengyong@oppo.com>
X-Headers-End: 1sOU0E-0000ut-5Q
Subject: Re: [f2fs-dev] [RFC PATCH v2 02/10] inject.f2fs: introduce
 inject.f2fs
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/6/28 9:31, Sheng Yong wrote:
> This patch introduces a new tool inject.f2fs to modify metadata or data
> (directory entry) of f2fs image offline flexibly.
> 
> With inject.f2fs, it is easier to generate a corrupted f2fs image, which
> can help verify fsck or reproduce userspace behaviors of some a fault.
> If option `--dry-run' is used, nothing really gets changed, and that
> could be used to get the value of a specified field.
> 
> The following patches enable injecting each part of f2fs.
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

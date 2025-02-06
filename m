Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E067C02192
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Feb 2025 01:59:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tfrAj-0007oA-NY;
	Thu, 06 Feb 2025 01:59:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tfrAh-0007o2-UB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Feb 2025 01:59:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P7TTK9mmQhO7SBtmpAOVrkK0TQKHU767JXGpSpI/xWY=; b=GXBdCiUl3jvm1oM+teDNpL00Al
 fVrf6fnBXS+5kzwFIFOP3yS6RzWAQxTnZHIz2jBWtbQLKLf+IHRjG0EwQ3Uob3+pLGW/WGI9Za6u/
 LAt88bnJAJcdi+bujbc77gvraAN/G7m6vn1Lt0qJWLQ9rw7NBCxTb+WNmaTo5THu0aFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P7TTK9mmQhO7SBtmpAOVrkK0TQKHU767JXGpSpI/xWY=; b=Xvocef98H83K8Gy9Sfm13uv7YM
 VXUnV1ybiWZTCGnGBYDNs7lroGx0DZEMEzxRBRL57dF1909EoUjR2rsVYlAE+pH0iOoVNt00GkH85
 njMcO1vtV39oNJLLP67giTq7F+1WRvtCLVwBVxhQZKhDrF66lnAqQDN9zRQ3LSPQFnpU=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tfrAi-0008R9-1T for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Feb 2025 01:59:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id 3DEB6A43C6F;
 Thu,  6 Feb 2025 01:57:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E148C4CED6;
 Thu,  6 Feb 2025 01:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738807149;
 bh=AHdD10tbnINLW6D6jFPVay9LIhQizRKek7+d9U5ngJk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=G4zlYcGi4tsBtZkiOsu/erLP5AwH20YlT/Ap7VSvNREoDOdwnkSfBfBojRX2sdGzM
 y7IP3idc6j+1ntHXob4YteufYtJoz2IuAVdGrrU9XiQgTHIvO+wqagXYaxCcX7buMp
 dnPm/t/p8BySKwn7piYwK3Dop0q6kZMF2krflsO9hMMshdEaoYY8ncsQkmnRr/AFJ2
 4NqjWU36iTB/d6unEe4ZBDvc9Fab+2hEVECrdAuLllkniACokjG1pLZiMVPaJ8NcVE
 WIUJ4zLdsfb7tOsCmY8QZNV5/K2y/YJzKBYu9PoPtBllR9+qxY4OCDcgu4o3oB92JK
 TS9yMrg9Lk9tg==
Message-ID: <d5f02fbb-e100-4154-ab4a-cac47807cc38@kernel.org>
Date: Thu, 6 Feb 2025 09:59:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kohei Enju <enjuk@amazon.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org
References: <20250202043253.64389-1-enjuk@amazon.com>
Content-Language: en-US
In-Reply-To: <20250202043253.64389-1-enjuk@amazon.com>
X-Headers-End: 1tfrAi-0008R9-1T
Subject: Re: [f2fs-dev] [PATCH v1] f2fs: remove unnecessary null checking
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
Cc: Jens Axboe <axboe@kernel.dk>, Damien Le Moal <damien.lemoal@wdc.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Kohei Enju <kohei.enju@gmail.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2/2/25 12:32, Kohei Enju wrote:
> When __GFP_DIRECT_RECLAIM (included in both GFP_NOIO and GFP_KERNEL) is
> specified, bio_alloc_bioset() never fails to allocate a bio.
> Commit 67883ade7a98 ("f2fs: remove FAULT_ALLOC_BIO") replaced
> f2fs_bio_alloc() with bio_alloc_bioset(), but null checking after
> bio_alloc_bioset() was still left.
> 
> Fixes: 67883ade7a98 ("f2fs: remove FAULT_ALLOC_BIO")
> Signed-off-by: Kohei Enju <enjuk@amazon.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

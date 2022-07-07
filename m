Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C7FC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Jul 2022 13:33:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o9Rcx-0003tW-4n; Thu, 07 Jul 2022 13:33:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o9Rcp-0003tE-PQ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jul 2022 13:33:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MiKZkV3R1x31QYpZgX4QliO2g3D0Lq8/9dE3A75c9+8=; b=Fcog7cVBgXP3YadCZ0oQnL/6Uh
 WMEqeKFo8gOUsvIIvNZGScOj8lG2DObGsKsIvftQ76eiC2jczX3/Thw9FqIsAONJX/boTIGdmwt9v
 C+/DBCxF5qbfb58SfJbBPV6Gr3Lap730dcydjdabJ3J6v87ZRr74G1mM25bbhKR5T8QI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=MiKZkV3R1x31QYpZgX4QliO2g3D0Lq8/9dE3A75c9+8=; b=SvuFibKWDOxWOmQY05Mo5WpV+z
 cuGDeXv7hlKToXelILHRciQlCv0AxnzK3wiQyDksrw0wWNZrHFTA0xXrbe+KAlx/CR7fhdUMbSfS1
 aG2O9NmaBBLeRcW2ZaVP61mu1bgr4doQ7xqEgh4jLtM9rssSc0Qz9ja79DFBbNM2NCoU=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o9Rcp-0004WW-N9
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 07 Jul 2022 13:33:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 6355BB8215E;
 Thu,  7 Jul 2022 13:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5937AC3411E;
 Thu,  7 Jul 2022 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657200767;
 bh=oRBMaGVn1cl239Cco0RUv0lBgGDfW5Ex3mNFdLKR7zo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=hukO+DZS4phyRv+SQJDyrDwFokujShVXN4rDkd9bc/QuhjMbAwVAskiLPTE+/yNvN
 MyPe5oflLGCoMRZEihDt26qse/vl+X7w5czsnHUKwAguDbzNt/8JEmSs/iBA//KDQQ
 KRXIt6rN0aSV/VXbtu7V5iGqR8KU1p0CdA6zvsIhMHOr9qdRqNwFJcBZKQRF5/SR3S
 iD6vpAd4HpUKAnJeS3R1oZu8V4axoiOf5gcs/4xzdYYfNnKrDi8RdZ8fQRignQJrWB
 REL1E4GfsuSunKLzRhbcokxtiZfxxKlsL+R2eFWhPMkrbc4abCext1DTmLh5tRyZMM
 q20REdzUQ/OkA==
Message-ID: <e019a7c6-e112-786d-b431-49e355fcee8b@kernel.org>
Date: Thu, 7 Jul 2022 21:32:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220707090924.4183376-1-chaoliu719@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220707090924.4183376-1-chaoliu719@gmail.com>
X-Headers-End: 1o9Rcp-0004WW-N9
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: allow compression of files without
 blocks
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
Cc: Chao Liu <liuchao@coolpad.com>, Wayne Zhang <zhangwen@coolpad.com>,
 Yue Hu <huyue2@coolpad.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/7/7 17:09, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> Files created by truncate(1) have a size but no blocks, so
> they can be allowed to enable compression.
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

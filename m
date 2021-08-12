Return-Path: <SRS0=Ue33=ND=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD766C4320E
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Aug 2021 12:19:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89C566109D;
	Thu, 12 Aug 2021 12:19:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 89C566109D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mE9gC-00015d-IN; Thu, 12 Aug 2021 12:19:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mE9fz-00015G-4c
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 12:19:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4FjN+fLDV4fXhnggatYLByzq1EIBoFJ/RZWYWZeamTQ=; b=g3JBZOMedG/j2biIHOhKdneDZU
 qE2W6PaPWQ05HlnfOiJHdk4nUnkjxCBYBPnYHqFQaQOXg8O5A/fWA5V5Vf48OQnv9jq2qh7/czIqk
 KfvXtyNUh+B/Mi1x8wqBjW0OMMLIS/J7+MkoyfIRxWZKRZa4iIHDdM4xFEwx8vT+z//A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4FjN+fLDV4fXhnggatYLByzq1EIBoFJ/RZWYWZeamTQ=; b=TmgbcVZFMbz1pw7ksVnECfYLgE
 LM9pz1djyUKrrh9EaNaGiDrlsBoYOBpyEwVYvhtVer5bCJryL88kmpAhBeCpCdRsPSZtZVH/qJOsX
 YTgTu9p/agmm/jMgYwRtzsP2H/TXsqDU7gF4iKMJd/wR6nC+Z71MbMbTWvtAnOotlKXA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mE9fy-0045kD-5A
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 12 Aug 2021 12:19:11 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 04D376104F;
 Thu, 12 Aug 2021 12:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1628770744;
 bh=XrLZuHpF2KI+gCimFQ3vxJ6AZTBWt58yd1ak8rpA7Jc=;
 h=Subject:To:References:From:Date:In-Reply-To:From;
 b=Rct36/c3RElp9XkzXvw1HWBzvIEONep4jwl+gJ6oHwCTwaiShzEliirxL3ueHkzSF
 Unr0LPKe9R0c2m5VVacLJYiGnm+81++tUlimPYG1nTzQn4oirHz3TW2IXwWxP700KL
 BVmY5UvXoXbvpqSlWHcLgQyRVEq6gH9LDRhnKHXfIdBfbB8Q5YRfH+gTdv4gXA0v/7
 1x/7lt28Nu4UCxCYcEXQ8BDlMnWdTGG4zWWCU+rDAqBF4PmOfGYB11jzdFNT0eKR8X
 hwT9HBvYfc5SGWHSeYUD4O6zi9VbDa1YSS3xbNj4IVfVHNB+Fd2b8eTpgpzBO0+ydi
 y/LvNTKfmMEuA==
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20210812113641.217670-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <86fcc421-115a-c7bd-b1b6-dd511ffae498@kernel.org>
Date: Thu, 12 Aug 2021 20:19:02 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210812113641.217670-1-changfengnan@vivo.com>
Content-Language: en-US
X-Headers-End: 1mE9fy-0045kD-5A
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: compress: avoid duplicate counting
 of valid blocks when read compressed file
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

On 2021/8/12 19:36, Fengnan Chang wrote:
> Since cluster is basic unit of compression, one cluster is compressed or
> not, so we can calculate valid blocks only for first page in cluster,
> the other pages just skip.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

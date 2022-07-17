Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CEDBC43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 07:24:09 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCydL-0005uH-Sp; Sun, 17 Jul 2022 07:24:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oCydK-0005tu-JA
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 07:24:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bOBxuW6uMn6PD/78eLs3EqKRCrdw5M6BSvbsvMxt3Ro=; b=K08v8Ke2u/rRng23cBT2lrj1H4
 vasj0DjdHTDw41ztHR6EIWHGenUrbQkdfVIiB74dS2GYbL1uEBH7JPxpnKGH2Y2yPfKDGu3Imad0E
 53LriKtGgXMjYszw01bIZACQQ02QSCKN5qPsIuAoOHO+7OZrHRN1YhayMMbCo74SnZfc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=bOBxuW6uMn6PD/78eLs3EqKRCrdw5M6BSvbsvMxt3Ro=; b=RkIv6WnC4KUg14+wq72hap1B89
 qCuhBqpHRo98zz6Sq/eFTQ9N2T9E/Ehf44itrIFvH7i45fdDWegrWXK8mE0fcSVReQUI02lnAMds7
 mjxbfFS41/bbVHpffV5pSDbnYL7cIJ84yH/Y3il1qYo6vGXUB+4OBxEEA7sZyrKhgqe8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCydD-0003ly-4o
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 07:24:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id D7912B80D04
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Jul 2022 07:23:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4F6CC3411E;
 Sun, 17 Jul 2022 07:23:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658042631;
 bh=kPTHNrNqEviF+AHppXmwwaB1/kGOB9DjJGpsj32sTtc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=LsfsvyN3+Q4RP10WX0b6g9iiPrV52lVF84xF7HgqJLwaFlSwl3N926Z0b1CtEPMdy
 2cE1yuiHW3rORZd7AVNmAZt9OIQxgarTG+dH4S3F7jWyTjLyn82Xltqb/eoblSMmpS
 Dmxq+WQO8sKZrY0xSCq1tFlIPBmUW6xnQ2KcnlvhePE+BQhLGeD3cajXOViIjbCPsQ
 w7xqzIOhnbIarZbiYK98zGp0UzWop0bz44a7V1lLKSweXO0UhGSuxAp+m/JEQ0fhEu
 XF+c0OSzeZXfCABHf1rC9c+Ed6ocmV3XALrh3+ZzEZltqE1oNRgDeiXiXatyLSNYB8
 XfmJj/TiSbnIg==
Message-ID: <c265cef1-de1d-5077-6727-d965ecd10fa9@kernel.org>
Date: Sun, 17 Jul 2022 15:23:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
 <20220628234733.3330502-3-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220628234733.3330502-3-jaegeuk@kernel.org>
X-Headers-End: 1oCydD-0003ly-4o
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: add a sysfs entry to show zone
 capacity
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

On 2022/6/29 7:47, Jaegeuk Kim wrote:
> This patch adds a sysfs entry showing the unusable space in a section
> made by zone capacity.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

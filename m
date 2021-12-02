Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BC38C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Dec 2021 02:02:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1msbQX-0001nx-IQ; Thu, 02 Dec 2021 02:02:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1msbQW-0001nq-KL
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Dec 2021 02:02:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hvqPiyH2iWk7xK/KIrIyVBzKd+r/JcWG69uGdvmqFmg=; b=Z4K/6kMQJu5vMJMeQWPZyH3vk0
 ghrdxlFIZpDkvbra7ZLCepqq3QWxkHBSRwmfKOPgogtIiOO9ZZnngqSR74unoK4onrzO5C0KnYy5m
 +zHWUH5yXAtUefdPlnK3okTSMPdpcqPwnA0yEX8Cwaa0McNUn6ba4iz9FUrSo23zxuec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hvqPiyH2iWk7xK/KIrIyVBzKd+r/JcWG69uGdvmqFmg=; b=d6oyEFogAjcaPbXSBlxSJCbZer
 zCDRhVBkMola0PT+3/sntyN06dSyt9qTKk9GsSkUNJvcdtqid6Kv1hActWsRtP0NCnweozlzzQJSb
 wQ1rUfOD+ociWhNMUQb1FrWRySC0QUqdRgFe6bnvFkF38UVhY6jjXjM5sg4ePghU3RYo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1msbQV-0002Ue-Qe
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 02 Dec 2021 02:02:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id DF014B821BD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  2 Dec 2021 02:02:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEE8AC00446;
 Thu,  2 Dec 2021 02:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1638410530;
 bh=16Aj4t3kzRV9C2YxN9lR+dV2tB6ndt6yB0ZioM2yKK0=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=hrYsu56wozRMQDybk2aWcTV2X6e+0GmLw10jkVoF1KjJXtvEqujFXl6xEiDhwzaZd
 zv+Fy0xx230uJxO6LsrdX3mmGCi0rcHbiwHVLL12DNOBowE49lN6Gh/HygbDAzqsKs
 tC2FPZRIMTJ3WgnW9+fELKbG89K7Bla6W3trGQzgxjh6WlMCnbYq155mNLV3gXEn/s
 vQp4S89kXYzJg0cntfN2uYK8ukP1vrS7ZanfCJ5LVCVPCmEzfzWOY7itkWGhitDO+t
 qNF0EaWL7nxCxxFSuf5I41YXQm8AJP7wZIreK0BNdUu95BRgFPhbNsB5TZplaoYwDE
 ZCqj2yR/5trTQ==
Message-ID: <17aae2df-f9d8-c039-e3b0-551ad897a134@kernel.org>
Date: Thu, 2 Dec 2021 10:02:08 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20211119211222.3114368-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211119211222.3114368-1-jaegeuk@kernel.org>
X-Headers-End: 1msbQV-0002Ue-Qe
Subject: Re: [f2fs-dev] [PATCH] f2fs: show more DIO information in tracepoint
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

On 2021/11/20 5:12, Jaegeuk Kim wrote:
> This prints more information of DIO in tracepoint.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

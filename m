Return-Path: <SRS0=Rvmn=OG=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB3EC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Sep 2021 09:29:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CC560EE5;
	Thu, 16 Sep 2021 09:29:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D8CC560EE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mQniD-0000oL-Bt; Thu, 16 Sep 2021 09:29:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mQniB-0000oE-3C
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Sep 2021 09:29:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OrOxBTAGYZu2A2A4zb08A7Dzb9HVczbdm4W2/Je2C7M=; b=PfEUzId/2b1DUfT6xubSXVVOKo
 SU4qm3WgkPhxL7Qrsg4mYjO3FF63O/wAYZ4HVxpG/DsJ5nCeQEd9PLyNzO2tLwwgIhiQ0BHd2ErMQ
 5AK03gUA2ndxpsmyRcYUs+k1UPZzdBzUYdr19F84jqL0q2HrA4+U+WgqRcwT0iYLYqNw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OrOxBTAGYZu2A2A4zb08A7Dzb9HVczbdm4W2/Je2C7M=; b=EuhwhObtBNiCUZvP8FsK8F1FY0
 zB9sffhGrAsfAmbIAeY/D3z+caJGXWBqttXAu549kbC3a90oV9uvvGxZnUlK2JDRJ++xdKRtzYxQu
 qzwNv5GBPCn7wPHy0Rw2/SfAJXbPEqCAyNZ+PruCUrkIf5oIIja1iFb7scdSqtNJVoEI=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mQniA-0002JD-IU
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Sep 2021 09:29:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id ED5426105A;
 Thu, 16 Sep 2021 09:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1631784574;
 bh=1xwGx6mCFguoiIzTx/ZWWvzHvEP11WwHMg+BrtskPRs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=Aod9Y8wKUCXKs0Rm04bzVO+vxjD5bvqIJPHM5fmBG5UoOYwzOubqzR+w3WuYSp+Wh
 hmA9XAvyBBg/MCXc9OyQWmJGv8l9LFSA5OQPkyeqB+FGjyTRR3EnmZsQaLpX1GoMLK
 pjlaeBTCflV7+bumx0Co9Mrwtn4SedbyngCzlzLnQTAHeD48VXYe01pEfVIhp5f/1n
 48X6K66lCyY9uvrZvquwQcz27U9NWGnsq3vsHJcsmGQgo6aCejU6SVcKLUyLcwwy/6
 4nU7tNIHvbzZcpn+ZjWUrnPfOrkDs2CU4G2ef+ALCBxm5IDPR734Zn7vOA6yBI+MlD
 jcgXvHpA+HqlA==
To: Fengnan Chang <fengnanchang@gmail.com>, jaegeuk@kernel.org
References: <20210912015058.14063-1-fengnanchang@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <022896bf-f5fe-1995-f158-c1da1a5b9017@kernel.org>
Date: Thu, 16 Sep 2021 17:29:32 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210912015058.14063-1-fengnanchang@gmail.com>
Content-Language: en-US
X-Headers-End: 1mQniA-0002JD-IU
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: separate buffer and direct io in
 block allocation statistics
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
Cc: Fengnan Chang <changfengnan@vivo.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/12 9:50, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@vivo.com>
> 
> separate buffer and direct io in block allocation statistics.
> 
> New output will like this:
>             buffer     direct   segments
> IPU:            0          0        N/A
> SSR:            0          0          0
> LFS:            0          0          0

Need a blank line here.

> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

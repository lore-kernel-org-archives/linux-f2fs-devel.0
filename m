Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BD6C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 May 2022 15:30:27 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nri6b-0007KH-BU; Thu, 19 May 2022 15:30:25 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nri6Z-0007K6-Qa
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 15:30:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1S20JCzcneSFdQsrs89B00Hokq/thRFgC1Iv5sb25ak=; b=L4sD92IOGBcvoWi4tfAVdC8xsd
 x/fp7uqKPlSJMf/Vc1movR++pAfnxbiTMYk2bCM1qNX/t5x24C+PXYk6ezghFtZy6F45hJ0Qvgtyz
 6wQNemC1DUO2tLFTfK/A64asLtVANx1pwbaR84s9ztmS+dB1Mf9otayWHzL85IYmVPIw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1S20JCzcneSFdQsrs89B00Hokq/thRFgC1Iv5sb25ak=; b=cktgu5+y6nMeOtQKry+KjvSNS7
 xtg6DeXqwST9m0tLe4y2Z1NvTVL/oMQYNlDBToOawnQXZ0bBd4BeFL0YFGFKnP8tETsVHBHsD48jQ
 gyT1W1JH7aisPD7a5l/jy0BH65mvCgFreWtx9y0fA7SpZJG+RXo7rYoog9YeY62AcMb4=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nri6Z-009dyP-Af
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 19 May 2022 15:30:24 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 0BCCFB82568;
 Thu, 19 May 2022 15:30:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B708C34113;
 Thu, 19 May 2022 15:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1652974215;
 bh=tzRUqmBOG/j1qnFGl9Mf3VOLrKBnNATJIoMIm5y8DLU=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=H62aCog291QEMK1cW22c3HyyS+7mpmPcZ5vI2yPWfGk5wrhlNzZr9I45Ox1FywU/l
 ZBijtlE6xiaZoRmzT65RGW2gXud9mnPHJsB+VQGv3GrScFWh4JhxTkieaJBZx3GpuM
 U2x5CMJ4opRjX80VkOo/96jrvYYhPr6tS+XiWBCptZWy3+hR3exmODHSPo2CYzQb5T
 GABJy/7V8QRvLXMp9SHwDQFK8Ueayf1/W4yLah8vAepLfYMHBiUtAbexd7wvLfnytC
 UpJEFgcH0jf021sqR+uD7oXfEWWvAOK4EiNlND8LdUhTSrvuAK1C97hQtzn2B258la
 RJoZJqzgzJnJw==
Message-ID: <78b1e40e-69cd-465c-ee78-698eb38892be@kernel.org>
Date: Thu, 19 May 2022 23:30:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Content-Language: en-US
To: Chao Liu <chaoliu719@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20220519104010.2814819-1-chaoliu719@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220519104010.2814819-1-chaoliu719@gmail.com>
X-Headers-End: 1nri6Z-009dyP-Af
Subject: Re: [f2fs-dev] [PATCH RESEND] f2fs: make f2fs_read_inline_data()
 more readable
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
Cc: Wayne Zhang <zhangwen@coolpad.com>, Yue Hu <huyue2@coolpad.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/5/19 18:40, Chao Liu wrote:
> From: Chao Liu <liuchao@coolpad.com>
> 
> In f2fs_read_inline_data(), it is confused with checking of
> inline_data flag, as we checked it before calling. So this
> patch add some comments for f2fs_has_inline_data().
> 
> Signed-off-by: Chao Liu <liuchao@coolpad.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

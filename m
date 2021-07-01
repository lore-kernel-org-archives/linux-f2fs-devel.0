Return-Path: <SRS0=edr7=LZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7269C11F64
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jul 2021 14:40:01 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 875446140C;
	Thu,  1 Jul 2021 14:40:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 875446140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyxrD-0005Gt-OQ; Thu, 01 Jul 2021 14:39:59 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lyxrC-0005GN-65
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:39:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ijKNUARGwGYE1TtGCNO+cYoM+Se2Y2aWi4mkV2o/hIU=; b=Mw6DUxovCPY89FqSwfRAELOaGn
 YK6TwG8KQt+JevXU1L/D4FxjwJIteKy0C/KGoZgUOq3Czj/KzDL4QyeA1nJddLVlKWqU9ESBRiyel
 MSn4b5OOtlQh7sUDAxOjRMQVHebofrGe/Wq4EaHX4H8XdIY3J5s3037ct70B64/kr/qM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ijKNUARGwGYE1TtGCNO+cYoM+Se2Y2aWi4mkV2o/hIU=; b=imtngSvqVc91/89jkaNc4dCcXX
 awwJVptaUhY4E9NqpNdblrRq7uDvE0gCL0Hr1giLxeo8clG3D8HDM2Yeoc/AE1x1KdWB0FMd5EG9M
 HKef/bST4JBrmoiiv3IWlLmok3pmK5v3qwTsWa69H8eDxOAZpUC3YnSSjlzoZNEnENAk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lyxr2-0005wi-6P
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:39:57 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id A5BFD6140C;
 Thu,  1 Jul 2021 14:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625150377;
 bh=nKVMnaaPD8SdRCAlhgi0KbgzL39fEBTKEHKnd+egGNI=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=cJu5tc1uL5WNXBHDU0dreaWZTbWudVad+Nc4iLPYkj5RkMDUghT1GvfgxBxpmfGlt
 YSYMNA3/+jh2B/7npFOE8fzOEKJRoyETNuNIAxHWOlnrdFvM/Ur1dTUrHwuc59e+Jj
 pD/ekv/KC/hGm8z2nrmdsoSRnpG/PdbVe5Iehfmam6gMvg2EsskRBs3sp9h99I2lZc
 9E8xfnwnRNbxcfRHqsgTlQ7TRX8EbH02fw0O8qkoE4aLYaD/lSSFj2nshe/iDCw0R9
 ADabY/wJ2oYni17s6yJezLL/JjGuzg2iZ0apAdo0GRcVFntaoBwRfMY0R7crN2DCpE
 3GFDBrDVV3NDw==
To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-2-sunke32@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <cc9344d8-9bb7-d876-71b1-56937b16338c@kernel.org>
Date: Thu, 1 Jul 2021 22:39:34 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-2-sunke32@huawei.com>
Content-Language: en-US
X-Headers-End: 1lyxr2-0005wi-6P
Subject: Re: [f2fs-dev] [PATCH v3 1/3] generic/042: make a bigger img for
 f2fs
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
Cc: guan@eryu.me, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/30 19:37, Sun Ke wrote:
> f2fs-utils 1.9.0 needs at least 38 MB space for f2fs image. However,
> f2fs-utils 1.14.0 needs at least 52 MB. Not sure if it will change again.
> So, just set it to 128M.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>

Reviewed-by: Chao Yu <chao@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04E30C19F2D
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Aug 2022 14:01:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oJbQ7-0001E1-D3; Thu, 04 Aug 2022 14:01:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oJbQ6-0001Ds-0O
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 14:01:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hp41brJIUVIHG2xspiWq+hOK9FB2tSXQymu4BLFxGW0=; b=gbsl+2VUHSALb3IArzAh153Z2z
 hj7Z2Fj1zhCIbN4fpT2O9/oHkEvthc0xmBG2pBJ63IqHyrVJsEBZGyQt8Mp9NTsH17tpFCwbcQu0j
 9nw+ebAU27P7Ux11UeXSHML2ssSriZrksGTdUbpt9SkHRBfub44c+Ie72ndhD20CVozs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hp41brJIUVIHG2xspiWq+hOK9FB2tSXQymu4BLFxGW0=; b=Ztr6tnKN9mg+r9MNb3TViOCXQz
 dQPJRAx9x0t4Ry//y1Optf1CdfC7Mb1JQRKvLE8RE0KcIAsdtPkojUB6gukx0zGzSI0RuOqy9idxt
 aJnQftTnhZ7TDr6Ou1bGI11r29GZsuq6MZ4Q6nAZRXz736/lxCVF3ZfE9do4Rkh3CCJE=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oJbPn-0008JS-Hm
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 04 Aug 2022 14:01:49 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id B6CCD61886;
 Thu,  4 Aug 2022 14:01:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D5D6C433C1;
 Thu,  4 Aug 2022 14:01:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1659621683;
 bh=bmGuS99cEPJKjV5L2Q9jbgjSmWnymUsW73DyV4qtku8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=DBCkvZjiG8cei5pG/yYtWpxiIy3p7SUGYUxfViwPys8lYpbAY1kkK4zFhbyJPtGtv
 lD5yUJ5iTonG0Ux/DCSU7DFc+JYqEi4zsx0Qft4fsGYdJVN2S134965RziFP6TMSmA
 kTmWjB3iNoKiGOoX1/I51bRjJOk1kyAblzxOvorbz/xrg1V4STpPJhIhhiW14p0ZWQ
 axWx4WkcZIGdLfuzrQbczQ1Skd7kDByH4ydlCZ+B3MsYCySocENYgM/xqQ7fGXh5HR
 kVSaBfKjLVrchKO4LW4Fsv+bqloT2akEl8ZeNizaOXM3RR2IyO/gIKratHYfjWXDO0
 btwB+ueFK9nHA==
Message-ID: <b8a21196-0d77-413c-79b3-b9488a40dc77@kernel.org>
Date: Thu, 4 Aug 2022 22:01:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Fengnan Chang <fengnanchang@gmail.com>, jaegeuk@kernel.org
References: <20220731033347.455209-1-fengnanchang@gmail.com>
 <20220731033347.455209-3-fengnanchang@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220731033347.455209-3-fengnanchang@gmail.com>
X-Headers-End: 1oJbPn-0008JS-Hm
Subject: Re: [f2fs-dev] [PATCH v4 2/3] f2fs: use onstack pages instead of
 pvec
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

On 2022/7/31 11:33, Fengnan Chang wrote:
> Since pvec have 15 pages, it not a multiple of 4, when write compressed
> pages, write in 64K as a unit, it will call pagevec_lookup_range_tag
> agagin, sometimes this will take a lot of time.
> Use onstack pages instead of pvec to mitigate this problem.
> 
> Signed-off-by: Fengnan Chang <fengnanchang@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

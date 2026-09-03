Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F63BC61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  3 Sep 2026 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=idtbz5MZQpGrtFsheQrjv0PpRBiLDUGU3DZYznn8Lek=; b=Fsse2r0Jveo7CfH62a/ANQwCJi
	tPEIIsH83tUu+L7x4/M0SnBDq5+muiPiaqn9LK4Ar4KtUxPQVI6EgKRUyGqhMIYnD4DpBrSOiF4Zl
	W5JC4lm+oHtKiaZtMk3gruvpkM7L1vqyPrSowMafxhS8/Qcs7EqWLV15XHtdKfpwpV0A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2Gy1-0003Dh-OG;
	Thu, 03 Sep 2026 23:35:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2Gy0-0003Da-0J
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:35:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wgqEUxliYrFxQGsD1XhQ1lqH4ox71paP4RLruXC57lg=; b=JW1ejvjiVQ33WMrYkGbaWYJOC1
 9IyJ3rGGixL9fJR1OZdjdnDXtnCSix/+5p3vuIchK0EzjkLnwUGNDATeEW4DTGxF+fUn6UVm0hpIx
 gaIIPE2fuli8PdehZlZZTvpyftD5QgU9kAYURcvgb8LJ7JISsZwbq3yQEAS3xPhmBa0I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wgqEUxliYrFxQGsD1XhQ1lqH4ox71paP4RLruXC57lg=; b=OQp1C2ocLDCV/I3ZuWc9QlkauA
 VJ7GcGIWvAoiYAWADq5evPxLBJt26QcU26kZi/+cRpD4LZ98uoehhkpFRlYULydBnVQs1Eql+25KX
 W2yyIPREV1RRvjXCygo80/hclnwp5TtAAN/AfDx4Tf7u4cEU2XYuPVuZWMFx6XDh7hVU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2Gxz-00080H-Ej for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 03 Sep 2026 23:35:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0DC29435A8;
 Thu,  3 Sep 2026 23:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931591F000E9;
 Thu,  3 Sep 2026 23:35:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788478529;
 bh=wgqEUxliYrFxQGsD1XhQ1lqH4ox71paP4RLruXC57lg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=erh43BEykPb8tfzknpnDINUwC5ogzKPZQJiMSdGQxgJRN2ebF81K+1sEYaUAGpAIj
 lYXNnfX/jJgxeWLGJZoVsVrutlJksUdi6cvnHdehKxG7so2scFdpRAyiF16VmNV/CM
 R4ZTML3LGfZLgrgudmVV64P3ETx7BObG7+4PQtoNewQdYa77NEXCc/SER/0SlfCMXs
 SSMVQ/guDhXkrVpZt0iBx7G+wu5sf0AZZ37s+m1V2lJEjUYv9NppfZb9WCE10CA9YR
 ADHJyR3+gXWLG/ZyHGgFOU9l2J4d6nFtSVvpwV7LS4OMNtntva+xIXkdi8CSwTEQxC
 v+gr1MQToHeSA==
Message-ID: <c46d8ed3-3d3e-4ab1-81ba-4a2696daf410@kernel.org>
Date: Fri, 4 Sep 2026 07:35:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Prabhakar Pujeri <prabhakar.pujeri@dell.com>, fstests@vger.kernel.org
References: <20260903035344.752-1-prabhakar.pujeri@dell.com>
 <20260903035344.752-4-prabhakar.pujeri@dell.com>
Content-Language: en-US
In-Reply-To: <20260903035344.752-4-prabhakar.pujeri@dell.com>
X-Headers-End: 1x2Gxz-00080H-Ej
Subject: Re: [f2fs-dev] [PATCH v2 3/3] f2fs/015,
 016: add missing _require_scratch checks
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, Zorro Lang <zlang@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/3/26 11:53, Prabhakar Pujeri via Linux-f2fs-devel wrote:
> Both tests run _scratch_mkfs in a loop without first requiring a
> scratch device, so they fail messily instead of skipping when no
> scratch device is configured.
> 
> Reviewed-by: Zorro Lang <zlang@kernel.org>
> Signed-off-by: Prabhakar Pujeri <prabhakar.pujeri@dell.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

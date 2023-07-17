Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2AF8EB64DC
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Jul 2023 15:16:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qLPy2-0001un-5y;
	Mon, 17 Jul 2023 15:16:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qLPy1-0001uh-HP
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 15:16:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 Subject:From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nRuz496COHu+19LmRmDkMKeeMWQOXeL6TdyZBF6i+78=; b=i96zhOulM+CsD/T28XaLNHJu2A
 PgsCCjCXrXxZCxNVVsMs2tEZvUepO3p4cCSmyw2cg55Hiez35wLS7n1S1vAQ3U7LHkrjaGz+gmc+g
 ATwNUqg+0Z0oCQxAJH7zZOwEOLGbELzsUwTJ37YpmrdztXWQ1ORYbUBH+PnzL42xHhL0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:Subject:From:
 References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nRuz496COHu+19LmRmDkMKeeMWQOXeL6TdyZBF6i+78=; b=bWUGbqPg1Wga/+tY9WeNfh0VP/
 dMxdMKxwoqKEz2bdYYVEjX6kK2mH3qvPJ2VIZvWJ14CoPAMdJwNP1yvP3DRUEaMKPOazW11snqbNz
 yGh8CegvAECdYQMUca9zG0LD2IF7jCwTa4s9MhIPvIn41AoptLN1bCgFYi8SMXtkoHDQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qLPy2-000647-RR for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Jul 2023 15:16:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2B15C61126;
 Mon, 17 Jul 2023 15:16:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7149C433C8;
 Mon, 17 Jul 2023 15:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1689607006;
 bh=nXX5U3Wy/uzuYdNNloz6mHy7t8LtYCxpWlLoF99FxDQ=;
 h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
 b=CsjRT3HQRDgaDIOwyPR3PRm91KqKsTsOBhJbjXmP4wPTlSVBg3Iom2xz1NeDZ1L13
 DpgBvAQSgFn8/b4aiGaH42Mi8rOpl3p7oK70uQvCTN/hWtsquGJhhVwegkhNj/gW1r
 iXeTkdbKbzKmfEDw3NZldNiu31dB0GvTet7OENFbJp5H3WIA+zpzAwuJx7BNIRaT4p
 EDKV8c+I/JJBDSVb+dV5dT7TR69xICNxzsTNWS3kyBF0lw+WeNoEU9Dv7WWSNjICr4
 HtQoqI2ZDo8qAQY1hnr26O6XPbUJ5IUU2UdxGGlIJ0cKD4JLjNZ+I8FIVZHs4lNjAE
 WKaEnGG50dgPw==
Message-ID: <bb6503f1-30a0-dc63-5b28-527bfe722135@kernel.org>
Date: Mon, 17 Jul 2023 23:16:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230707094028.107898-1-hch@lst.de> <ZKx2jVONy35B0/S1@google.com>
 <20230711050101.GA19128@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230711050101.GA19128@lst.de>
X-Headers-End: 1qLPy2-000647-RR
Subject: Re: [f2fs-dev] [PATCH] f2fs: don't reopen the main block device in
 f2fs_scan_devices
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
Cc: linux-block@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/7/11 13:01, Christoph Hellwig wrote:
> I think that's because it doesn't look at sbi->s_ndevs in
> destroy_device_list.  Let's try the variant below, which also fixes
> the buildbot warning for non-zoned configfs:
> 
> ---
>  From 645d8dceaa97b6ee73be067495b111b15b187498 Mon Sep 17 00:00:00 2001
> From: Christoph Hellwig <hch@lst.de>
> Date: Fri, 7 Jul 2023 10:31:49 +0200
> Subject: f2fs: don't reopen the main block device in f2fs_scan_devices
> 
> f2fs_scan_devices reopens the main device since the very beginning, which
> has always been useless, and also means that we don't pass the right
> holder for the reopen, which now leads to a warning as the core super.c
> holder ops aren't passed in for the reopen.
> 
> Fixes: 3c62be17d4f5 ("f2fs: support multiple devices")
> Fixes: 0718afd47f70 ("block: introduce holder ops")
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

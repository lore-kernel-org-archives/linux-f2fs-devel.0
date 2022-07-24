Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3310CC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 24 Jul 2022 09:36:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oFY2e-0002U1-HO; Sun, 24 Jul 2022 09:36:52 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oFY2R-0002Tr-7w
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 09:36:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5QRihrHOOWo/wN/wUSlASv7c+4tTsf3o3XdNT+T8lI=; b=fR5E5+prdxWZusr4cPURp4KLHx
 TD7ZtcdyCe0JfGTa5v8M3eKzXLb8AdpAh+nHH6XKm7ve4MngN3yG8nfukTka1VV2XFjUJSPSecUXG
 12OpWDfDGA8GqqGR2hYUc9gzE5+xbiYCaxhDcW0Znw7iHaHbq3ZDhnJUXBReq5y7viWo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G5QRihrHOOWo/wN/wUSlASv7c+4tTsf3o3XdNT+T8lI=; b=NV4CbPpZ3QaTO+UyZzBpvDWKt7
 OzTwz0EEDmjljCpQr4+5awFjdxbWxbvZLnbCG5cHpnEyYZHutm8Nk9RpK3eYrsAxqv6MN+rIxrj12
 bWJ0/qkltVQxkKi/jE2PQKVtdc4XagftKaOvJnMDTDwsStBNUx6IeHvX5eTKvjVT67C4=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oFY2M-0004Wc-Pb
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 24 Jul 2022 09:36:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 70EA661008;
 Sun, 24 Jul 2022 09:36:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4CA0C3411E;
 Sun, 24 Jul 2022 09:36:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658655388;
 bh=xRUEVlFC9qF++FRwkW1zV4hpS7DJi7f3CyZS48uen+o=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=bnt4WH/tDBYhXbxGfXr11QCvP9IeQgRtgrbUVQWIpHqzP4m1IOk0hmxIp9JJZN9KL
 jP6N2dumOyDFwmDMOBcOz5AQg92s5F7m+WPGLFgbQ5uavl8aNBZSUaiadKx7PX6jNl
 Tp4Z60oDfdxWW9V92MmgCdtafTx+nRcQQTEfLbO4d24Pv31z2Io4G7gU2pu7yNH2xC
 uedNLywLom1WaHZloGmnCxmnXFP7X45sfmsPa/s/4wlyyys074eDaKqzNipK2sm57S
 yO4d5SUUO3cZR5HeUnCHREV9z3HAnInIIAsMaNvMNBng80fsVHXYum7FpCOZlnTlzt
 E2En8wzZK+upg==
Message-ID: <095ae0c1-ca6a-7c71-360a-883dad84a18c@kernel.org>
Date: Sun, 24 Jul 2022 17:36:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Fengnan Chang <fengnanchang@gmail.com>, jaegeuk@kernel.org
References: <20220717053207.192372-1-fengnanchang@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220717053207.192372-1-fengnanchang@gmail.com>
X-Headers-End: 1oFY2M-0004Wc-Pb
Subject: Re: [f2fs-dev] [PATCH v3 0/3] support compressed file write/read
 amplifiction
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

On 2022/7/17 13:32, Fengnan Chang wrote:
> From: Fengnan Chang <changfengnan@vivo.com>
> 
> Optimise f2fs_write_cache_pages, and support compressed file write/read
> amplifiction accounting.

It needs to describe what v3 updates?

Thanks,

> 
> Fengnan Chang (3):
>    f2fs: intorduce f2fs_all_cluster_page_ready
>    f2fs: use onstack pages instead of pvec
>    f2fs: support compressed file write/read amplifiction
> 
>   fs/f2fs/compress.c | 21 +++++++++++++++------
>   fs/f2fs/data.c     | 46 ++++++++++++++++++++++++++++++++--------------
>   fs/f2fs/debug.c    |  7 +++++--
>   fs/f2fs/f2fs.h     | 40 ++++++++++++++++++++++++++++++++++++++--
>   4 files changed, 90 insertions(+), 24 deletions(-)
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

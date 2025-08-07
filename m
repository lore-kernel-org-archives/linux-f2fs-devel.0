Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88126C87FCF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 Aug 2025 08:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sJyQJHJTWSZ7iWyHhJ2fScqmST3Td9VH3tYuT1eRWuU=; b=gSL5y/wkJcgzOSKOsM92v0zZj/
	zE7JrU4V6ZaGlgEO+JSZGzQXFW8Dmwmhzdr8TRwOVPrXwyjqLAsBHId4HQNW1VBUNstNxuMbiO3U4
	ZZ1I5pRxCssxGUUyK0m9HUDQocpwo9M5go0R0KfQ6d01k0kdDZE0n+N3KkzJcWDkU8xk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ujvYi-0003hu-9b;
	Thu, 07 Aug 2025 08:01:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ujvYg-0003ho-H1
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Aug 2025 08:01:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NXrqzFw2dN7JI5rIFs+ANCJIqQx/GUomxzIRFKrY154=; b=c14KDM15sWm4u97Nwv5WbkusFx
 Yw8Ai37gEANYyBnVGMXsRw4nh/WYhmIvQOlb1KWOWvEsXS+kJZPcqdhc51qtluGasmNn9Bq7s6on2
 PScsENO6EGAiwS+4qujJDK6pai2doPzS0hOfoqeOswtYvM6ckG2li766PHeXTOWSu/sw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NXrqzFw2dN7JI5rIFs+ANCJIqQx/GUomxzIRFKrY154=; b=BFfDmbknw2WcOX5KqtT3VgUgZ9
 mQx2N3c48WCk4UYmV9kgQ3TYIiBtwYFlZOp/jO+MRRq68WA+VvfGLhQio4gpJHHSHW0fGChZ9aIew
 WVqmCFRZn8NTrRqT/KRhYOTqAs3Na6spLipM75RN/dPFWvR1Oqy9LNiF31XU/h8I9hPk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ujvYg-000465-4M for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 Aug 2025 08:01:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 7862661416;
 Thu,  7 Aug 2025 08:00:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46835C4CEEB;
 Thu,  7 Aug 2025 08:00:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754553655;
 bh=9hADTosUKOFNWZ5EYqpjsUWzyHnDqVR4ADC7eW1jO6A=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=mbvX6hfH5Bld4lKBQl8GMpFGnfx65tkxSJC0WtoSH/TTWK06hY56oR3EYHWXxNzrf
 K0LCmvLTqN5ICXChSR1ZVn/m1cuOP8BUPZfU6oLLH7yY/m9aLggqQEIDSgZMIJ33ak
 lU9rQdj2lDT0Hw2dRmPSyFddeQkEOx2pnq87VpFeitVWUP+Jn1vuWtadt0mO+jtUcz
 nZ05kxcEq/70Kq4mBdNcGLrLua3E3Sqb74ybCNfJJ4hSMT5Q2O+++bdJHP+7WVLE0W
 OXqBL7nkE5fl9q4GN1Of9QEKRi/69UUzl/vVEnLvZ0/plFGJT8haGaKxEp0weUetKw
 LGeb3oWMGoC0w==
Message-ID: <631b2bd2-f642-43ea-b3ad-423d19eeae32@kernel.org>
Date: Thu, 7 Aug 2025 16:00:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: "mason.zhang" <masonzhang.linuxer@gmail.com>
References: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
Content-Language: en-US
In-Reply-To: <20250806123236.4389-1-masonzhang.linuxer@gmail.com>
X-Headers-End: 1ujvYg-000465-4M
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix CURSEG_HOT_DATA left space check
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/6/25 20:32, mason.zhang wrote:
> This fix combines the space check for data_blocks and dent_blocks when
> verifying HOT_DATA segment capacity, preventing potential insufficient
> space issues during checkpoint.
> 
> Fixes: bf34c93d2645 ("f2fs: check curseg space before foreground GC")
> Signed-off-by: mason.zhang <masonzhang.linuxer@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

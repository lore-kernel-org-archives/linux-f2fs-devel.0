Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8492C3ABC3
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 May 2025 06:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4k6GOxlAiU3qn4VWZUHZyk98yYXZwzsmX9xQebWtBeQ=; b=RYFKKvEjeDNmw1T8kA6VHOt/Iv
	7UXEFFGlESJEHGGepSgTYqeYj5ZT5mvW2G6VmAUg47+pOO1F4qSRt90vbTMYqYDvqMcjMMD0KDSJo
	P1CaYsi4bqXtn7S4bno8DKxsrXA2xRw9wGvUtz5bGJHx6VW0sDKk0fU4t5iW3hj9sZDM=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uDH8S-0003CF-Lp;
	Fri, 09 May 2025 06:23:04 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uDH8R-0003C7-Ij
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 May 2025 06:23:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U8X8942qVnmOdUPIibDgJd5NRjdfFidiYD8/xOi1lqA=; b=HHDUnF/+pql8PLBfopaRmwn1AH
 b9GA+hOxxasRGxEJlR1MJPDcavoGQ4AdrAC5Q7ty3MTxW8WyVHWU/gBrSW93x3zI8xpCg9gvZeMjO
 KC7CQt5zYieFTUCXWCrEdXAnPTqUKcCIdCXlIOEg33DMckD03nO2e3yXcgst9nBOSzxw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U8X8942qVnmOdUPIibDgJd5NRjdfFidiYD8/xOi1lqA=; b=GcvheBgVkd9CFTL/vmQnKaYM2w
 RqpAgK4WaJx39wFi0sfaGTTAYIt69gN/ERyp6ovNn6ZAXEGZfu+JSVITYjKGLVweRAG3b/3B2qpXF
 Ml0yjR9760tydttyW4SCZEWIle9xB8PVnj7Z89Bt/Qd1gQ7sUOnEosKvwpffQpA5o4r8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uDH8R-0000M9-2A for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 09 May 2025 06:23:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 6781B60008;
 Fri,  9 May 2025 06:22:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2447CC4CEE4;
 Fri,  9 May 2025 06:22:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746771772;
 bh=4pkRrc0G5/RiFaQ8hi6jCkDU42blX12NXAr+OVG4TEE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=g3fzJ5UrVaJaoTlgo0NnCYmRggdFaAxN7OCEa38L82U0pSMqptDU3cWOQynW0i65c
 lsBeSD21fTlRqXAwJIvm/nPU6iJKeSXkbmJlH6LokG++MmrK3viDmAd/IdCB5qFnaM
 hoAtuv7hDUcv6qLsMk7dx46xpYpoPknDIcdvTWXW2NjaeKn8PW5Z1tRsyEq5Etr9k2
 qOx6XnZDX+0UbdY9686oQpOxJsO5bblORGtKne9/IztXbZjFyaZ6ycN34r6KF+9K9X
 tWmHWF66Mz88idqWBonNQS29SxnAnVv3jSGW0N4SCh/3pThjhKBHLX3PWRkQQb9uUp
 NUotF5wLMHvOA==
Message-ID: <dc862381-225b-4d58-8389-71b1d6881ba4@kernel.org>
Date: Fri, 9 May 2025 14:22:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jianan Huang <huangjianan@xiaomi.com>, jaegeuk@kernel.org
References: <20250508124235.58858-1-huangjianan@xiaomi.com>
 <20250508124235.58858-2-huangjianan@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20250508124235.58858-2-huangjianan@xiaomi.com>
X-Headers-End: 1uDH8R-0000M9-2A
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs-tools: clean up dump.f2fs etc. when
 uninstall
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
Cc: wanghui33@xiaomi.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/8/25 20:42, Jianan Huang wrote:
> Otherwise, some lonely soft links will be left in /usr/local/bin.
> 
> Signed-off-by: Jianan Huang <huangjianan@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D46EE7AD7A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 26 Dec 2025 03:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bjZxWpm1f71Wg/NyC62gMCPa8Y8p6aULIa19DA14rDk=; b=ImjPxGoqgM3mHw60qrc8sMxfGt
	KsP5ESJmM8FKYqXy7SLECLqod/v5j+vLRatIodgknBPZOX175fwiI7y8aohLGeEWO0DcydtIA27sX
	aP7OK/W4kYzURJir+NGJGNEN88ggqF//e/SDUjTuUXm5nWFhYVkcIugZx54ffh/FV7qY=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vYy5I-0007Oz-V8;
	Fri, 26 Dec 2025 03:01:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vYy5H-0007Os-JK
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Dec 2025 03:01:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=eEqtkfNwGjIVjGZuo/m0jiX6702pvu8ipk7I+YheuAs=; b=aJnRiYsiQ6VlDvgQbkmgOUNAwR
 wYkTcavdUVC/52MDRIT7Po84yiLU6H8B2avlruGmPsK7noJgv4afrYBL91panZaghCrVYEjk6teDn
 Id+736C91mpAyq8ThaRxCDfokBQ2tSqZAczek3TQT3RcZpHoAYrMNAeq875YJiEMCcDw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=eEqtkfNwGjIVjGZuo/m0jiX6702pvu8ipk7I+YheuAs=; b=icJzAvBPSoqdYb+IiR3b+YNOp2
 jGdz8j8VOfXxK4ciknr9CBs3NLOLDyuklibvpnWYHw7A4DqToOC7VEcqyWlZ7s/I3hazoQZig3qMo
 lxbZK7DquGSRdctIhAYKnpYXgZhaPRPZ3uvanw8cAXPzF3wdIOnzYJ+etFJkVb3t26/8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vYy5H-00015e-6s for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 26 Dec 2025 03:01:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A99A76000A;
 Fri, 26 Dec 2025 03:01:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB99CC4CEF1;
 Fri, 26 Dec 2025 03:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1766718097;
 bh=fuYj4KdP2PNrLis9AZFKfu9P/pJJ0u7VVte8eTlFxhE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=qxwY+L1ZF/lm15IMYqRL77r0kkSJanE8hshiDDw2XHOp1Z/7fJ6EjeWMy/MW1grCn
 Q+JFwYqICxln19/UKaktILBUuO9NUrOr4nXeKZIx3rwTZKJITW8iHSeG45J377ZyVG
 XEXIXHOGeHe3l+qCROO9COPg/k+mj0TujvDy5UaN8DugcF9N8QlrdQ+/I9ukJTTkMK
 GGHG49YHcVAJPuGTn+p4y6zvgGFk6SnGBL/BgKjlrjGDS1FiJywzEByatvJmcu/B7P
 aaPm0Q+HyCoJC/r0s3UqCnGaQFUf1QfvF43pllXq4DwyPKIysoBg+Du5qk6M0D7FXs
 hEa+eZItEQzTw==
Message-ID: <b60ffa9a-3482-461e-a36a-a2dcd39b4d7f@kernel.org>
Date: Fri, 26 Dec 2025 11:01:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1766717764-19956-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1766717764-19956-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1vYy5H-00015e-6s
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: fix to add gc count stat in
 f2fs_gc_range
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 12/26/2025 10:56 AM, Zhiguo Niu wrote:
> It missed the stat count in f2fs_gc_range.
> 
> Cc: stable@kernel.org
> Fixes: 9bf1dcbdfdc8 ("f2fs: fix to account gc stats correctly")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

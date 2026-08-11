Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12DE7C5AD7B
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 01:49:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HbaYUOXwZnhY3Wi8wBQxpANjPdtze5v1UNKHkYEBe2M=; b=BLH05emzPniF4U/wWs6I+o+14L
	Pgk4p2UYsoKmGmsAdCFdTlQx0GDC172HjmL9uq8KlTT72GBODXJsYCPI1P31VdUvqvho0uGCEb7T/
	VpRDni0mD0tMSNYFDukKh0AjJCJBGquT986gtai2kzMB3gG16cfSPD/bu7YOfJdYAhFk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtbcG-0007E9-3i;
	Tue, 11 Aug 2026 01:49:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wtbcF-0007E3-AB
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 01:49:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=fbQdEIkPKTw83MfJdf7DZIxef/pakG3anpSyXn5xx0g=; b=fVh2nfRSQFdM0vhVyr4AGSEDCY
 635bW4bZfaOoHdsKf6TFF8k7IOSCofF08+ALfRncjFOcs5fW0l16Yhu8Ozow0bqsyCOHwGVk5aQx2
 n8ueVk9cjcS/VT8kfRdmfTqiYQMRj5ddH8yoyBozLKxokBekV1TjEFNbNxBtRnNGK9fo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=fbQdEIkPKTw83MfJdf7DZIxef/pakG3anpSyXn5xx0g=; b=fW/F7TK+VM8iO2tHP1X4SLf9V4
 RfNMHlco7c6tM/jwp/v4cc45q2Q+28kwF4amGQOQReI/3FYM4SyK8ZBEUT6r5QVENknc2nWHPWinr
 0Z2fL7vH2Z4PT/WhrLIv/FmLHfaW9u7YwKkZooMJJBaCVC2Dw8VgFdQxjojQuLbMZy8Q=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wtbcF-00021O-VO for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 01:49:16 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BE2F56001D
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 01:49:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A357B1F000E9;
 Tue, 11 Aug 2026 01:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786412950;
 bh=fbQdEIkPKTw83MfJdf7DZIxef/pakG3anpSyXn5xx0g=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=aYS6WtjT+Vuk2zfrsAfGMOuSeC1lvGDww95hmcn05dM6Y71Weksp5ORA1mvtmPKae
 5TD4DbUyPd9OQOOHvISZDS4+6F3fO5uMn7V0s97R+RK4rlOJTvDoQ5Tl+FrD6gI8Pb
 WJIFJ5sfX168uDDJC2GBr4GZFZAvU/2eK1ye3mAFdg0ZHPAthxDmtCgAq8bKg5Xnt+
 Mg/3FTF8tZC75UaaPRzyMzeMbZpaoM2eeWywDaT4H/WNsogcmW2uCwgJ7Y9TTyx43W
 0xv2mpGHrh0EWTsvY2WPyxoLM0r9RR0bx07T3OIk764BYgPxHHvf+NX8CdDzZ3btxw
 nXn4uGOLmEy3g==
Message-ID: <26a8478c-e8e4-47a3-8ffa-6a0b0b3182eb@kernel.org>
Date: Tue, 11 Aug 2026 09:49:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20260807220235.384637-1-jaegeuk@kernel.org>
 <20260807220235.384637-2-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260807220235.384637-2-jaegeuk@kernel.org>
X-Headers-End: 1wtbcF-00021O-VO
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: call __add_ino_entry out of the
 eviction path
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/8/26 06:02, Jaegeuk Kim via Linux-f2fs-devel wrote:
> The f2fs_evict_inode() can be called during the direct reclaim path, but
> __add_ino_entry requires allocating some memory. Since we don't need to
> do that in that context, let's migrate it in other workqueue context.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

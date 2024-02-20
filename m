Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD0F6C48BC4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 20 Feb 2024 03:24:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rcGkY-0003bW-K1;
	Tue, 20 Feb 2024 03:24:54 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rcGkX-0003bQ-9G
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 03:24:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=z4ipq5a/1VP65hQUaQXQcjkUsYXlJ23rFdE1VbfF64I=; b=HKXCnNQPed9/nnsO050eamheY/
 aFvE2inY3ftFhCr+rviA/uLfAuq+S0SoP8srgBZtSbiJSyO7BFHP0HXfCDz7U1chhEh2PknrlpiJ6
 OIKgpEYRo+MbY7fVvPcbfQBKdqQQb30q5x3ZbqiIpsNB4ayF1184L/nwzcWwSKIxkX5s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=z4ipq5a/1VP65hQUaQXQcjkUsYXlJ23rFdE1VbfF64I=; b=FSCtSsmBc4ziEvH+KRssYsckBE
 F3JjrryxTeY4jUFBbybLBgR1H0A3UVe/9QmT+RhywU57uTpRlq+LV9Bm9IrD4rzoEx9Vh9JAKW/+2
 BIlVzDQ0mn+5R10TZ9jr1YW0351GdHWCQxsTpuch5gAamLSC9U4zmO5ypiW6eSR54CKA=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rcGkV-0008ID-6n for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 20 Feb 2024 03:24:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 76CA7CE14E8
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 20 Feb 2024 03:24:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82305C433C7;
 Tue, 20 Feb 2024 03:24:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1708399479;
 bh=xwcV2MmN6+t8RyOcfoHvmKxUeRCEpbY+kIdVMp2jgbc=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=avniwqVkLfr3pcJtvrgnS4a3pYVGiPITKaQglrqsjcyjMmKkLI7OAQ0z9yNlAq9P4
 PDS3Md2+U9wt+08w9Ugli6zjpWWlTCi22b/xH2aTaQetT6YhIxelY0FEU8rYVjuBTu
 lWEJjfrM8Jw7Cn+I0HAQlf5TRXp3vGW2Hh4mhtsWMuOks8AQYeM0yIUS9U8A8bkuBX
 CctthJmaMovWejNQg6jSKJiwHiuc27tAX8RReJ5pgHM/Us6Mq0PnxQlHIBHzCzm8hl
 W3KBFTJzS8f8WxWXoqNOy+GdX2T0W2g3AC069E4J1JQsxdhNE2IGrvu3VFfAEpenua
 KnAan9DBBhxNg==
Message-ID: <a30b6bc0-f86d-4696-bd87-9edd9d324cd8@kernel.org>
Date: Tue, 20 Feb 2024 11:24:35 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20240213234100.2445417-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240213234100.2445417-1-jaegeuk@kernel.org>
X-Headers-End: 1rcGkV-0008ID-6n
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: fix sparse_mode case on stat
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/2/14 7:41, Jaegeuk Kim wrote:
> When we turn on sparse_mode, stat() will be failed, as the file will be
> created afterwards. Let's fix.
> 
> Fixes: 14197d546b93 ("f2fs-tools: fix to check loop device")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

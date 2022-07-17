Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7BC8C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 17 Jul 2022 07:23:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oCycx-0002yd-SJ; Sun, 17 Jul 2022 07:23:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1oCycw-0002yT-Kl
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 07:23:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P8/TyJSyH2kbXCLEBgwM679Ps/5vLvFGuUIX7EeZIBY=; b=avRp8wFRM1u1ZMYV9TiJYMuorH
 /Ys3LSrFcbETH3F5B3B8ELnujebwASLLKLWdeCQh7rsc8lvvU5iOY9rHYpZYkDAai8vkcd/Xdv9JL
 fkvXQM5bqu3kuE7u6+AAc7tJ27LW60lNdxWnf5q5m/DM0zRZWzSlecFryZ5UjW0xPuW8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P8/TyJSyH2kbXCLEBgwM679Ps/5vLvFGuUIX7EeZIBY=; b=YgLG1wut6WmVO3ctJ11N6NhnsT
 qFGR6cdfIkXnroIoMRWvx1AIp7yggbWzW0jif2+TD2WCFvl8bzcRnBcIDMAbG+S6t7jHwLKu6ZhEm
 3aCFbXcilukaQdRrwjCG/3uG6NtrshvknjWDVYBj6SR2PuTTKmxb5ocxX1Fop8YQrYEo=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1oCycs-0003lH-VK
 for linux-f2fs-devel@lists.sourceforge.net; Sun, 17 Jul 2022 07:23:43 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 4452EB80D37
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 17 Jul 2022 07:23:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20969C3411E;
 Sun, 17 Jul 2022 07:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1658042608;
 bh=s8rXbFsbsWSW4DLeRPcbLqxDQ+kDUrSs5IV2B3SPpoM=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=lQUlzztexfj5dkcTO3Ql7Q24+k6QaY9mtco/H7/qq4+v+GB5ZUbH9eUGZulAH1DLG
 IUhMQYQHXaX1SUA3CVhPvJf7Je95nYopGCujYd3FIfEJkl07LFnavhqeOO/3gzyevq
 bs0/YOyPEtvO5oT8c+J4fwlqRpBzfIBeJIW+JcQ14bunSrSMWI3xKBWP5pE3ZDllJ2
 3/5M4A3B/hIejmnpyNYXZzHI1thwwriTLdeyfHqfNi7Uk3eoNYjxNsNUMaZ+RUBUl6
 MbSlTx7we5gXxEw9qvAxZFDIlUMPzpl+WNg8UEA6KeIXoxRZORU7YhqjF6932VKnXY
 pRhnsXpD9hWyA==
Message-ID: <feac68ff-c70f-fe7d-bc5a-63e53dad9a2b@kernel.org>
Date: Sun, 17 Jul 2022 15:23:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220628234733.3330502-1-jaegeuk@kernel.org>
 <20220628234733.3330502-2-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220628234733.3330502-2-jaegeuk@kernel.org>
X-Headers-End: 1oCycs-0003lH-VK
Subject: Re: [f2fs-dev] [PATCH 2/3] f2fs: adjust zone capacity when
 considering valid block count
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

On 2022/6/29 7:47, Jaegeuk Kim wrote:
> This patch fixes counting unusable blocks set by zone capacity when
> checking the valid block count in a section.

Good catch!

> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

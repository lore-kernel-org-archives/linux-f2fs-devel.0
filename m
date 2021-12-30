Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C659AC433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 30 Dec 2021 06:36:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n2p33-0006D9-Sb; Thu, 30 Dec 2021 06:36:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n2p32-0006D2-28
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Dec 2021 06:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/NQGjjtePd/HypvuY1TM1t06vDaG9V4+og5AXYcK21k=; b=duNGInAbkUA8Jsd5QMuq4Blj9k
 CBuc09wv50faFHuYoAZAkkcGDwsppU5g4SKkycPBzu+l1OCCy2sgREJRKMbdoVIi2/S+iJbUJFuBp
 BdaYMmygbolyMFpslwNdaSD64ettHAx9gOGfUbDKjrHfT83R9w5lgwgW4wHu3sRLnNfU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/NQGjjtePd/HypvuY1TM1t06vDaG9V4+og5AXYcK21k=; b=NCY5tpVYamyiWEGYWHVvKGrJXd
 Q3aewUx9TMyQnXPn4mzpJUPVWiiFqku98I5zDgIHbGk5flCUbZ8yFQtjtj5CTSw4hFR6rEDYZkWIr
 DN8cTfATaqb4DeAJj7FiqeTQbfcLupRVspd2SzNXd6FtnQJCtL4Mu65j0tx/MMnQfQ3k=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n2p31-0007n2-7R
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 30 Dec 2021 06:36:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 37297615AD
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 30 Dec 2021 06:36:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA0CFC36AE7;
 Thu, 30 Dec 2021 06:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1640846171;
 bh=9QOHvBuZEzzxfHF5D63r+Ymjp5/qBkI1gadU29wm2fo=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=bNsPh5ruh2OE2RFfmT5STNFqnSZGzSU2qeTn1BCuYnU4Tko99M4t5xTHKOePXHttY
 gE3UiyL8dD1XNUU1lmvI6Ni8NJsKWE6TW/tz54rSDfq6YXRAp4RKqTCXkkycnf7oAY
 akN9D5eX5B0J1bsuQbXLuC+ZYftZRVLXIDiSeWQ08T/v6yO45bTQzKm8/9mngrL/cV
 C6RYpV/+ePvD9mjbpjnxZDGd2vZqHfjB7xl3jZ/ryKOIfOM5S+oHx1g79k4QPRKqAr
 8MstY3M2aUOj81VKd9At7swfT01s+5yOn6U5IzRqLNpzty7K1JTdxxH3CnUcVkmiXr
 w9odNYcQvhwbg==
Message-ID: <dc36ef4d-a66c-d02f-e54a-844b95acedde@kernel.org>
Date: Thu, 30 Dec 2021 14:36:07 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20211214182435.2595176-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211214182435.2595176-1-jaegeuk@kernel.org>
X-Headers-End: 1n2p31-0007n2-7R
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: avoid down_write on nat_tree_lock
 during checkpoint
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

On 2021/12/15 2:24, Jaegeuk Kim wrote:
> Let's cache nat entry if there's no lock contention only.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

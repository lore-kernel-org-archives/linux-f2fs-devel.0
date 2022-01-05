Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F422C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  5 Jan 2022 13:19:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1n56CW-0005XY-45; Wed, 05 Jan 2022 13:19:36 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1n56CU-0005XS-Cc
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Jan 2022 13:19:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zw5CC9m0m8IVO1gnSdiL1eWE1uP0AFL4MCtEPJU5YoA=; b=LVognLdzlcadl/VkgJMwq6F/Xx
 CQfYaSX0eMCRjop2IsreCUP0Cd2Yt4bBREba2MC3JOOFbMrTpS2tf6xq4Zxw8NyQXrsDSWZOkYi/t
 P7iF4JpY7Z5ecF3mK7MXmWu7C82ZRDIfetNoP8zG7SAujZyUcBqhmejPpYBW3xns+JRU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zw5CC9m0m8IVO1gnSdiL1eWE1uP0AFL4MCtEPJU5YoA=; b=AXjc9jNILxlRQXkVZ3VnzlLkv2
 b+MyhxQe0GIQ9V17MQ1Jvi2A4trivgag38V5XtaaVENOvEosyK0sRBT4cj/T8kqxnU1OnA7F29Y0M
 Rt8+0k1ZY0GW2OW2NeEQ0ozQVtSr/vs9EUZbdlioPXr+QO6qhyTWblTG/Y3bkElU1Y38=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1n56CQ-00032w-Qf
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Jan 2022 13:19:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 98C05B81AA0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  5 Jan 2022 13:19:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADD8DC36AE0;
 Wed,  5 Jan 2022 13:19:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1641388758;
 bh=+WwWNgnGqh9XKYRNXBRhQR5JlOjez82G+xx4+InuGTk=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=nnd1NXzGhmBCx2stpx6uM8DAuouE5BCINIPeMH9oYt8XOtqzqJyi2X9Zhhbp8ztlh
 L7Fr0inLESAUrye5qEw3i60fI2R4Cx0YEkN1aixSzFlfOGdRo2ZoFj31c735d8clTB
 Rqw5ReShkO92DUbHLjs4FrOEv87SR2YdSRyNu030IoIIAUhdl40Qt8DVMUdNdPdgI2
 nKl1tR8ELGcqzCgPixdRQ2UWolsIkL7UrnX5ETsI6ObIyaoisep7vCeYXsEdxDaW4i
 qR0cgopk6DMeX6Xt118mzP+SBAJx5LpdCmXu9+WNXX5j9vndmhCOtWnhGcZM6s0bIE
 Fj+dSffn4z0Gg==
Message-ID: <a2036978-81f9-fad4-90ce-15dadf048693@kernel.org>
Date: Wed, 5 Jan 2022 21:19:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220104212419.1879225-1-jaegeuk@kernel.org>
 <20220104212419.1879225-3-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220104212419.1879225-3-jaegeuk@kernel.org>
X-Headers-End: 1n56CQ-00032w-Qf
Subject: Re: [f2fs-dev] [PATCH 3/6] f2fs: do not expose unwritten blocks to
 user by DIO
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

On 2022/1/5 5:24, Jaegeuk Kim wrote:
> DIO preallocates physical blocks before writing data, but if an error occurrs
> or power-cut happens, we can see block contents from the disk. This patch tries
> to fix it by 1) turning to buffered writes for DIO into holes, 2) truncating
> unwritten blocks from error or power-cut.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

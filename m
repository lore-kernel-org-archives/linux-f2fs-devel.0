Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A23BCC6FA82
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Sep 2022 03:16:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXwP4-0004OP-Q7;
	Tue, 13 Sep 2022 03:16:15 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oXwP3-0004OI-RD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 03:16:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=laBb88fssokdQlXMWLKOsnilq+hoBIJpUAtqkIcLvck=; b=QRg6L+rNh6jNcq9Ojspaed0DmP
 Bzw0o6pjrEv1AYQriyUbDM7i+qDQbf+p7GdFRoUe3+wrNY6YHaINNgpjkjPuw9JQL/PRyiIpftwdf
 TXav6EJvGQkMMAkp73HaDKaSJogdDi1SekYbXW87SutlQM7k71lxFYEB2r3+R6bbQwBw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=laBb88fssokdQlXMWLKOsnilq+hoBIJpUAtqkIcLvck=; b=c/Nnbz4ZWvzAi1+1LHHy0/V4Mq
 k8iASO8dSIewgrLds4sSBaS+8Tkv9KTjQpD7xeUi6DVG992s2QZEP1MGqZO3qL4PWSj7cQoZF+GtG
 frzkk0dzf5+tACjZwdBbRpgrBG4W+N5UamrBJ/9PeapHTjt/hsfHzoUeTni5fpRYQkFc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oXwPC-006UhB-6y for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 03:16:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0C52B612F3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Sep 2022 03:16:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814A6C433C1;
 Tue, 13 Sep 2022 03:15:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663038959;
 bh=aTrY3NGN8P43xzKdOh0uIpOhrM/d4B6KbePZQKV8auE=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=SX2HaEI7Dduecanpggo3q8MAg0xshdOiuKeoJdqvSmcRKIv6Z4zYQmC6m/cPj3MQR
 Va/vttXGbbDJlBL39Oysk1ydOSjwtdtvI8UNrlwQ5tPfnWQor02GNhWQrsCEXc+d5f
 KEn943Ke6boqLix5pzyP6CmMncWw1Lg2cPh0v9QYeTsEd/tCQuj92yeYrrOyGD0YAt
 plUZTcyDuKiuQsJQHyMAggF25RfGqdLI+0p6+PfVG5fS4avI3sMEL9m5nQLp8BBfjD
 DAs/WmUHkXWJNSbbuTNW2H4cC3GnsMG2D6IC+brHzgBIV2QqaHZqjgv84+uHLnYLh8
 vpEd0ECMoQ+LA==
Message-ID: <7e0bd17e-f1e5-47fd-16c2-94921d772567@kernel.org>
Date: Tue, 13 Sep 2022 11:15:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220823172124.2285995-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220823172124.2285995-1-jaegeuk@kernel.org>
X-Headers-End: 1oXwPC-006UhB-6y
Subject: Re: [f2fs-dev] [PATCH] f2fs: increase the limit for reserve_root
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

On 2022/8/24 1:21, Jaegeuk Kim wrote:
> This patch increases the threshold that limits the reserved root space from 0.2%
> to 12.5% by using simple shift operation.
> 
> Typically Android sets 128MB, but if the storage capacity is 32GB, 0.2% which is
> around 64MB becomes too small. Let's relax it.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

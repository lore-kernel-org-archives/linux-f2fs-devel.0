Return-Path: <SRS0=HVTi=NL=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3303DC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Aug 2021 10:36:04 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1938601FF;
	Fri, 20 Aug 2021 10:36:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E1938601FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mH1sY-0001IS-Tw; Fri, 20 Aug 2021 10:36:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mH1sY-0001IG-Ac
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 10:36:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IIFw/PYwhALdywT3S7COEM2zS52FZ0A2DLUsOOH0vZA=; b=de940+oNkGcvQ3DbhSiB0iPMB6
 lRAfPX9VhJxcX6TVFUuXqUyamEtVIl0wJKd3nFmlyLhCMjh9XHb6LFjGsUKbTyWvZJ3mR0SXlENFK
 VtrOYq6fgzZBVgnxHkuENcpV2ZkfaIFmI5xv1SzcR6qMDxnF7YmHx3VnyfuJFc6OdBVA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IIFw/PYwhALdywT3S7COEM2zS52FZ0A2DLUsOOH0vZA=; b=dyqtOuXxz0itB0n2woLv0l0s29
 /tvdZpUIY3sPkelflC23P/MNSFtgrHDrKdbWHv6M9mfr2XgqIcfivdmiKRJ3HPPTwxgflz2wKJS9A
 oAWYOe4tb1VyoZQWPGP0cFH4qVW8ZPzb576UdQXLJ5NvAg9fl+cjxbpRUeNJNdg0USsk=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mH1sU-00CbQy-3R
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 20 Aug 2021 10:36:02 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9EC896112E;
 Fri, 20 Aug 2021 10:35:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629455744;
 bh=SydDpYYDbjGzNxExamcwlWD3d7fH3OLPI08AP14CvKs=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=lJyu6sICFwf4b5c9/JLk6MN2NdKm1QPFUz5x/ZUXnzgmGpipdUqQA90TvVbwSoQJm
 hLEe0ttWJYSQ82f/mZtnBUrz3hoQAS8+9U4AMtU+o73y7/nLPlFOQVJL+vmN4bmL+U
 ze1438LiElPMQpbauuiXR7kg8ogXZS+wrFnDle8i4B3M1gkHycLV0wEDTAsJN+wW91
 Hmgm//HZYppZt9e01Bp7WO9iQ3HE3iIr8/2Wk/7bhhbOa+No16fj9BFEZU7HvFRyGp
 P7DwmR2s0pSAWzWGRGjwDCSLbYYR8JkE7FFXpIxEqTueYRL8FKUXkWtfm8lwYSWzyB
 O9AvM7fhU4BaA==
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210820035229.216975-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <0d38cd03-ad4d-38ee-35e6-a4582a3423ee@kernel.org>
Date: Fri, 20 Aug 2021 18:35:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210820035229.216975-1-daeho43@gmail.com>
Content-Language: en-US
X-Headers-End: 1mH1sU-00CbQy-3R
Subject: Re: [f2fs-dev] [PATCH v4 1/2] f2fs: separate out iostat feature
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/20 11:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added F2FS_IOSTAT config option to support getting IO statistics through
> sysfs and printing out periodic IO statistics tracepoint events and
> moved I/O statistics related codes into separate files for better
> maintenance.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

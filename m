Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A16C982EA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 23 Sep 2026 07:19:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zErVbcVIKsdtf3aFmafQzoZOzF6y20mv/Lup40y7KdU=; b=jo1Wn1hQKCIxLH6sbKAJOGr6YQ
	iLc3DL5dOhTCxzZt7dLyrNs+l1sn5FzkoPP2RmcdNBzfexYA/dfWzA+j0O8a2dOpR8h5924LK+7GI
	YRbKyGN8p6XdE4NgkZMu0X65F8UAfByQFE+v9Cf6Dcoa5ZX63wSN3kTG254cuzK1JRT4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9HG8-0000Qn-BQ;
	Wed, 23 Sep 2026 07:19:13 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x9HG6-0000Qf-UE
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 07:19:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rYNhXNY9sXeWg8bHkzc4ViWau0owmg51LGJInuniVd4=; b=UVvvk6MKoAs15o+lmNOR/qjkzQ
 8r5qyf/pHf4YSfGpv8wN+MRpNtAGzawpg+pnbrrstr3LnoTCNWhiE2ufutY4yrorR6FwsMZs96mYu
 pXcQNWuCw6Ziu8/aVg3K/RxZTlN9MiQcn0pDKJgNXy2smjUf1htp49Z2ixRe/ZRJYhBs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=rYNhXNY9sXeWg8bHkzc4ViWau0owmg51LGJInuniVd4=; b=lnEKGDPGYsI11rPTLsWwqvjItZ
 ZxMw5c9a/87jbVatk+l2jQTA9R0kR1nQxSgICQd+c2Y8h8oz/ypSGnLFxf0YlGWuq+UxtU+rupp4G
 LPMTN1COkZIKLug2TOiPQxYNe7zFFDYU4Vs3E8WkguZf2sB8HbzmzEP1QqY+ZCc6JODQ=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x9HG1-00066w-PY for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 23 Sep 2026 07:19:12 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B8ECF600AA;
 Wed, 23 Sep 2026 07:19:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6361C1F000FF;
 Wed, 23 Sep 2026 07:19:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790147943;
 bh=rYNhXNY9sXeWg8bHkzc4ViWau0owmg51LGJInuniVd4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Wh5TQzDaFlFh/3eIDQvw/pQ1nRyfPQCy0gprJJ/LhQLv2tOd1ORryRLy7I6lDi93S
 x2HCtYHRJtdaAp7puiMmJpcwHnri89IAAQ5jteMKc57B8DbQIHRrFhIaNwAkGtEplQ
 J9/NAg++jNlH6hSMLxriJOmpH+lNWvWoYBA7MftWa4iSjTP8NjywQMQK3XfwCQL9RZ
 5HM222YR783+GXIw1bAuoWpay6QpXS7GYcXxTdK8VKKjfuIeuCnG6qB5uy+OCE7u6K
 qo+EX8P2/hjSidkAmvzToX7V5Q8Z0EZiKGN1AV8xRlDYouD/JhTE3vDX8Hvf0cBIRD
 oCMBh/BsW9nBA==
Message-ID: <d7a99050-74d1-4b31-b8f9-7502ac7a3785@kernel.org>
Date: Wed, 23 Sep 2026 15:18:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
References: <c4e0c6d3-ad28-4e5e-a938-08b7658e9931@kernel.org>
 <20260923025035.2202070-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260923025035.2202070-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x9HG1-00066w-PY
Subject: Re: [f2fs-dev] [PATCH v2 10/14] f2fs: handle partial truncate of
 large folio dirty subpages
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <nzzhao@126.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/23/26 10:50, Nanzhe Zhao wrote:
> Thanks for the review. I think I may should change like this?
Seems fine, thanks for the update.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

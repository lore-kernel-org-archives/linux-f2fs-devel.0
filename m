Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2386D108E1E7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 19 Mar 2026 11:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v4+SmdodjBN32MR5iYWMXtSMB0D8YkyQjQrMZQQTY0s=; b=dLzsJBf/ugDbGNXJ9xixjE96ez
	B40VGXAu36tdqqSiJpo/NKPY8WXQkVeOYH/ZGasoLgEqPbUfP1PHJgFHIyn1WzS1zeNsq4XfetqLp
	zZAqU4Wdg7994OyPZGTQ9CiEdDZIctLQ3vVyAI/j+59tppb6fpRKz0WVzszRCQ8HMmuc=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w3B79-0008Q7-6d;
	Thu, 19 Mar 2026 11:00:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1w3B77-0008Py-Cm
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 11:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5SUQlFyXt4QJeMtX6msvaz626moEUsV/rWM3TXTJ3K0=; b=XXsKkCZGQTowQb2A9FPaaDdcSp
 o6CRCFEulni7AxAy11S90f5CGsFLxrZCQmJ90OuJnqm9gzWiceDiXoR34P4VXNmMCIExjt5VsB6Vu
 ZO6s0UsS+G+ydiaXTWEhOqqUZXDn1saby+SkUWC9h3Y8+buCQhWeMIYPNntWFT/d1qe0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5SUQlFyXt4QJeMtX6msvaz626moEUsV/rWM3TXTJ3K0=; b=BNMYFTN4QXBRoX+P/qluC7yMBy
 HfYIhlCclM39Uvrs3OzUYgU1Rps71h4tN0R6VdktXFFsyjpQ6XBYrqiqQoUOddOQDbNldZPRlQW7S
 TZ3oPXTyR3pW5wl7UbmAGuTUcpPFUT3f9pnl8N0Kgq7E1M3Zb+h2AFpE8Gm1wzQ+76VY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w3B76-0008Dp-5B for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 19 Mar 2026 11:00:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B70E6012A;
 Thu, 19 Mar 2026 11:00:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35122C2BCAF;
 Thu, 19 Mar 2026 11:00:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1773918017;
 bh=MBof8FJxF37YeVM6q8qyel1Ver5Rcon2mZ9n85w9do8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=l7wF+H5Bo3Vh+VwVYT5cpUORpkk7ozwmt5FWizkVmeGsZnPh+gsB9UVJLKeBm0d76
 mhM16zE7UKqSbJbVq070t6PcHbDQh40Z0gwRl+QOcCyrJq9mkxgajSLFim6PtpdJX1
 c8RwjIRT/VNIq/MAt7k4VQFI4FggsnxWUNnxwz9jb6HSr0hengKbUIIKei41KhJHqZ
 ZQFFgO5xXvMJ1GH6b9WeUgqnQJhPhCQ0ju1SYeh+wx/ukbwRokArXDFogd+0SX501s
 COWFFeizdmlJ0J4o82xwEfOg4mx5WtHaXxSmdzQbfe9etUJV6xMrpG50e/3ECf7z6a
 wfu3tPLHPeUgg==
Message-ID: <48f29e10-e9e9-4d07-8491-a4403ace5859@kernel.org>
Date: Thu, 19 Mar 2026 19:00:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cen Zhang <zzzccc427@gmail.com>, jaegeuk@kernel.org
References: <20260318073253.3108313-1-zzzccc427@gmail.com>
Content-Language: en-US
In-Reply-To: <20260318073253.3108313-1-zzzccc427@gmail.com>
X-Headers-End: 1w3B76-0008Dp-5B
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: add READ_ONCE() for i_blocks in
 f2fs_update_inode()
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
Cc: baijiaju1990@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026/3/18 15:32, Cen Zhang wrote:
> f2fs_update_inode() reads inode->i_blocks without holding i_lock to
> serialize it to the on-disk inode, while concurrent truncate or
> allocation paths may modify i_blocks under i_lock.  Since blkcnt_t is
> u64, this risks torn reads on 32-bit architectures.
> 
> Following the approach in ext4_inode_blocks_set(), add READ_ONCE() to prevent
> potential compiler-induced tearing.
> 
> Fixes: 19f99cee206c ("f2fs: add core inode operations")
> Cc: stable@vger.kernel.org
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

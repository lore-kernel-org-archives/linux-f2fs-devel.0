Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520C8CD37AF
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  9 May 2026 13:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OG05m4xPdFr6v5XuVdv5QXhMBk2HC6jRAOKzxlvKcYg=; b=VD9G3yn2AH2pkLX2E4SNX3gMK9
	eEPaNIa2mmyTXAoYNhkNeeaMR1BxO0p0mqSsGP5tmjf9o3AynGNRKVYYbJ00STvAAL4EmaxT58SFR
	41RF9mlbDOCQWjE8A96gAp6XYh9yvT3eVff53nvaadh0OSQ21CGQ5moUSz3Wq9BUw7Aw=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLhYh-0000w1-LZ;
	Sat, 09 May 2026 13:17:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wLhYf-0000vv-Sz
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 13:17:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mQpN33HDeGpYdD7x0SAJ0UeC10h6VsVzDXidtlg05wo=; b=GGnw6y+NNVr5RbsHhWlyIW+/FQ
 g7DtnLVBsuNgAemvz6GHKhqgstMsVvZus7rDk056zg6H7HXUJkxxAplVdUAmHRHFH7G8PIyBSpz2n
 ofQdiMjQ5cFRlIBkQ2Kq3+XRZ6OtU4gQ7TY48dL9UacZPbKwpy9wcpzz8ReGFty62hOk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mQpN33HDeGpYdD7x0SAJ0UeC10h6VsVzDXidtlg05wo=; b=NmlNZGEjwjkAwh4AGEBYzlSyNE
 Qzrythf3qs92XFKkLDJi9O3t6qUZYbBfrQEeV1NEDoiLE7KzcxDzLEzWrKrI0DccCaLewGuOtbybP
 wQOkJYL+NUhc4v8JfWyZ7wuDK79uSf9eElxdLdYDZareYhxVn4cvIhGQneWVPVzkTF3E=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wLhYf-0007sH-GO for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 09 May 2026 13:17:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1C9EA41A34;
 Sat,  9 May 2026 13:17:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E09BCC2BCB2;
 Sat,  9 May 2026 13:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778332638;
 bh=GovmqvW+H8iHnBrgX5Bhn8ssZFtFngl8cW/75itPgxc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=JM2jyvsjgrW/sEbfot3VXAFO/w/ZmXzf/UlQRSCyR5t8tFkZr9u9UOWx1DhYy6tC+
 oP/YbApXTMkPBScJ3BieIvjZuh1Xi8VR5mym1D9UO2Tcx2EHpOoreMsx9kZC0uFcIG
 7GPnkdru5mtNvYVHl7gqtPsaGr4wXUiAe1pLRD+ONFh68NqAnQFamOLvnfdswq9CQW
 Bjoon6RGUQZK7q22Tj9lPhgw7Gq35Xie+16K5S0dkx8V58Ft/tZrcS5FGbkiFAzPCw
 pbu3H/dg4jDjeeC/Uepf6bxYWCpvp255F5q4n2cJ+mIyoMYi0J+cyBYBOWARBrtY18
 27/AB+9nyc42g==
Message-ID: <04ab5f17-2f63-49e4-8d4b-af781f5ff704@kernel.org>
Date: Sat, 9 May 2026 21:17:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Cen Zhang <zzzccc427@gmail.com>, jaegeuk@kernel.org
References: <20260505125510.1369132-1-zzzccc427@gmail.com>
Content-Language: en-US
In-Reply-To: <20260505125510.1369132-1-zzzccc427@gmail.com>
X-Headers-End: 1wLhYf-0007sH-GO
Subject: Re: [f2fs-dev] [PATCH] f2fs: annotate lockless NAT counter reads
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
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/5/26 20:55, Cen Zhang wrote:
> nat_cnt[] is updated while callers hold nat_tree_lock, but F2FS samples
> the counters locklessly in f2fs_available_free_memory(),
> excess_dirty_nats(), and excess_cached_nats(). Those helpers only steer
> cache reclaim and background sync heuristics; they do not control NAT
> entry lifetime or checkpoint correctness.
> 
> Document the intent with data_race(READ_ONCE()) and a short comment
> instead of adding locking to the balance path.
> 
> Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

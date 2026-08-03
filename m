Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0602FC55175
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 08:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DxVNNDYWu4jQyEeAlldd3VLejPuKB5iqaf17duHQkTw=; b=iYEcdvwnEWkupaNyCxiJohZWoL
	54hdi1N7sn2C9eUdUbGiHr/7p8XBVRnfpyBMdXVlO9gjVjEQS20NPrEna60eoWQ/FX/3cD7ClfRQB
	Iqjsim4Zj/Nyu4VXjfeiOBOHJ4vuy/v2g0+Pm+lWhJ7B+xsQPQIhylo+sc3VrapiNdww=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqo9I-0001HG-SP;
	Mon, 03 Aug 2026 08:35:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqo9H-0001H8-7z
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:35:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=msb+HXJfxnhAfoW4KbBd6lps3PsbR5Bw0tJ4Un9C/ak=; b=j0LjjTUIn16Q00b3psRgYtHoPs
 g4ZJopGt96dmahn2ggfTgYrrfjcj5cdQ3cJQ+0dCOiRqwa1onMjwOb5OcohC+ECMaS7NKfJ2KH7RP
 UrcWfYJA9BG2LqLRwhDkJYze31AKUOSoa5kzXfTkWPtYmuG7QvFVn5/fn8MrCrP1TzcM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=msb+HXJfxnhAfoW4KbBd6lps3PsbR5Bw0tJ4Un9C/ak=; b=U50rHlXe0pljIx54LJWY1G4qWZ
 BK4UrATWJ0uZqgvkup9eFRMvZFdQwSLePIisMate7cUQBm4PlFj4xfRbZGdy/Ll1ozZE3/8smX6iH
 MUXGECPI3E8VW0SYPEvH7gYpICpP8P7b2FVzQhDusBLJEbRowr6b/bTvxoG76j4gvehk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqo9D-0000yW-IC for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 08:35:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id EF60760A59;
 Mon,  3 Aug 2026 08:35:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DB0F1F00A3A;
 Mon,  3 Aug 2026 08:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785746141;
 bh=msb+HXJfxnhAfoW4KbBd6lps3PsbR5Bw0tJ4Un9C/ak=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=AHKNA6ghfsS+ywvuXTU+Pc381TNlqncT1WmTrdWW+kjeINB88zOpTfFJ5IAICG5ux
 mQKVraYelQeW4PZUMawajiJ76fz4rlCJ7f9owlqMqZnQ6bxMJG9HAtEGjCkY7gTKMl
 W6oj7JiC8sSrz5NvKgWRiLz9sJyQxqZjUCavPBxvB0BP+E21H4AhEZDz9Js7t/o1s6
 5BnfkLPutWbRqGRqEA1/COPSFHP++fb+FwysElAsZu8z6r4R4/VQXK2hxBt+guMflU
 vGkNBasXDbqwjvnpnHjvb+jmJqQi7UrPic3TPJUqAl8AQo5LbEh42VCr2OJgU0sIlu
 2pPzbw4PCOeqQ==
Message-ID: <5fba64e0-dbaa-455f-b11f-f63ccd675887@kernel.org>
Date: Mon, 3 Aug 2026 16:35:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260727074910.1965988-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260727074910.1965988-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqo9D-0000yW-IC
Subject: Re: [f2fs-dev] [PATCH] f2fs: return writeback error from collapse
 range
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
Cc: linux-kernel@vger.kernel.org, qiwenjie@xiaomi.com, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/27/26 15:49, Wenjie Qi wrote:
> f2fs_collapse_range() writes back pages moved by f2fs_do_collapse(),
> but ignores the return value. If writeback fails, the ioctl can still
> truncate page cache, shrink blocks, and report success.
> 
> Return the error before truncating page cache or updating the file size.
> 
> Fixes: b4ace3370324 ("f2fs: support FALLOC_FL_COLLAPSE_RANGE")
> Cc: stable@kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

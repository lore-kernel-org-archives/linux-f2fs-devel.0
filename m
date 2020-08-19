Return-Path: <SRS0=hFix=B5=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F59BC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 19 Aug 2020 01:36:22 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21EEB22BEF;
	Wed, 19 Aug 2020 01:36:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="eBSKM/SR";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Btnw0Foe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21EEB22BEF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1k8D1Z-0002zz-M6; Wed, 19 Aug 2020 01:36:21 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1k8D1Y-0002zs-GP
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 01:36:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:CC:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kXYyV9Kk7LJG8V/NUSeKCNSH7u96kxaXdfUZnw0VLv4=; b=eBSKM/SRR61KwzChEjbfLiXqlw
 S8akU17qW5XfpzSW2HeL624daTqUW2i1oe7t5bP9QSxV4azsr3oPjZYdgLGXU4kfhqiwHX3ImfIfs
 8xI7oQX2zB5KwighElhO65snYLR5j2gpRwaxx3EfsVo6FxdClQMwNEz3z/CWiFCoa7Fg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:CC:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=kXYyV9Kk7LJG8V/NUSeKCNSH7u96kxaXdfUZnw0VLv4=; b=Btnw0FoeN8SrdBBu4tZh6ES2Fr
 tjXPHQmBHNRE+jtl07h6g3gwnVKV1uOh81hOz3EleazXy1B+QYK5wJjATjBqcQj1+B9enQQKO/DAe
 hajit7/oppOe8dgPyCczDO14h65yzK5FxpH3t7NLWWA/g6SgifcLwOuvNQPxZ2yBKXns=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1k8D1U-00Bwjn-PC
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 19 Aug 2020 01:36:20 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id D0006D65640004EEF6EB;
 Wed, 19 Aug 2020 09:35:54 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.487.0; Wed, 19 Aug
 2020 09:35:53 +0800
To: Sahitya Tummala <stummala@codeaurora.org>, Jaegeuk Kim
 <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <1597745414-13135-1-git-send-email-stummala@codeaurora.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <f0504d96-6972-a6db-ec52-aa59bd354d98@huawei.com>
Date: Wed, 19 Aug 2020 09:35:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1597745414-13135-1-git-send-email-stummala@codeaurora.org>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1k8D1U-00Bwjn-PC
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: fix indefinite loop scanning for
 free nid
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
Cc: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/8/18 18:10, Sahitya Tummala wrote:
> If the sbi->ckpt->next_free_nid is not NAT block aligned and if there
> are free nids in that NAT block between the start of the block and
> next_free_nid, then those free nids will not be scanned in scan_nat_page().
> This results into mismatch between nm_i->available_nids and the sum of
> nm_i->free_nid_count of all NAT blocks scanned. And nm_i->available_nids
> will always be greater than the sum of free nids in all the blocks.
> Under this condition, if we use all the currently scanned free nids,
> then it will loop forever in f2fs_alloc_nid() as nm_i->available_nids
> is still not zero but nm_i->free_nid_count of that partially scanned
> NAT block is zero.
> 
> Fix this to align the nm_i->next_scan_nid to the first nid of the
> corresponding NAT block.
> 
> Signed-off-by: Sahitya Tummala <stummala@codeaurora.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

 > During CP we update only ckpt->next_free_nid but not
 > the nm_i->next_free_nid, which is done only once during boot up.

Oops, thanks for correcting that...

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

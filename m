Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B04CDFC6179
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  3 Jan 2026 10:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lw2OavTJgiQ0zDqRRpjVBctjVoz+y2UD5eRI1PfJKA4=; b=eGyNNirK7UpLuOCzntPVCDLgsN
	kWUS/LyRwo5DF20gc8qqM+1YSdvIt+l/K+NojhusJVJQwFJSP4Kl8bDNzc66BR8B/SrUWANGqEIYG
	mzaM9K/63JcJFKTFLr3x95VDmb9y3D7NzY+s8pOT1RuXuOaNK6vrSa+HqqShWfeHLxqU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vbzHH-0002Oj-SE;
	Sat, 03 Jan 2026 10:54:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vbzHG-0002OX-Be
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Jan 2026 10:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sg+jRXyJ0wmFr1CC7TcFiIL2y1rS53QQ3B2aKcFkXp4=; b=cEJrGEYeZe5qVFoHM77l7lhsvT
 0J1Xaf5EnC1IS1lk4aRwk9+fYBVuYb2BGFemspQkfnGEeeLZmjLvT+M/PFgfy7Y/YaoJkMMamO1uR
 ZU/UZnPK9nsRkGPxfPz9DstN1jpRubHVGT1Y/pcbEoXDV4tVlD1vr4vMOpPCwz+vaVy8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sg+jRXyJ0wmFr1CC7TcFiIL2y1rS53QQ3B2aKcFkXp4=; b=duACscUlTm64z29e/H6NW41H4C
 eu+VZh48ybyyjmw8puv8aasho6nCXky8d62LcVCFDUfkMN0HYQBXjZ+FjjWhDyHK0Tg0gl4IVyw2X
 7DuipqVkb5HhSySOSorFPLRRChq5mWs3gAbcxjWn7Ji0JixFNjRbIdjkQMdbtS4U+frU=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vbzHG-0002PR-6R for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 03 Jan 2026 10:54:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=Sg+jRXyJ0wmFr1CC7TcFiIL2y1rS53QQ3B2aKcFkXp4=; b=S
 0WLQfHfLZEuLSbpdb+B5s32P3T11oemqeGAo4/QK7LRuUru/ziVXitnR9I0QkEvc
 gWVEGd+jv0gew1hLl00GHpzMH+ZbqSrAQmb3tD3kR7l23dMXBMudmZ2hCs4MUcpT
 +mCSmCZvaypu1RAzZQ88h+T1Tt+Eopfql0rLtr52UE=
Received: from nzzhao$126.com ( [212.135.214.2] ) by
 ajax-webmail-wmsvr-41-117 (Coremail) ; Sat, 3 Jan 2026 18:54:15 +0800 (CST)
X-Originating-IP: [212.135.214.2]
Date: Sat, 3 Jan 2026 18:54:15 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <aVdkSZeuwzsNq7pE@google.com>
References: <20251120235446.1947532-1-jaegeuk@kernel.org>
 <0153ff69-789d-4fe1-a89c-0c607a9a7d6c@kernel.org>
 <aS3s98fgy80_xDuK@google.com> <aS4W7NBYFPwP6KEQ@google.com>
 <aS5RG6IQ8AlXrLwT@google.com>
 <0bf2eedd-eebb-440b-96f5-72ac3a68b608@kernel.org>
 <aThslGwzpYmEXzU5@google.com>
 <a7f7efde-53e3-48c3-9caf-9410b018b1e1@126.com>
 <aVdkSZeuwzsNq7pE@google.com>
X-NTES-SC: AL_Qu2dBfiYuE4u4ySZY+kfmUgRgOw3XMSyu/oi2o9UO5FwjA7jwgojX3FNEkPY8fq/ETuTtCSYSDpX9fhQTYNeVaw5kKlre1qeb/eeCrxNenKM8Q==
MIME-Version: 1.0
Message-ID: <16d92acc.17ac.19b837e5d80.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: dSkvCgD37zdY9Vhpq609AA--.2413W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBoxgE02lY9VjgBQAA3V
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1vbzHG-0002PR-6R
Subject: Re: [f2fs-dev] [PATCH 1/2 v4] f2fs: support large folio for
 immutable non-compressed case
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Dear Kim:
Thanks for your quick reply!

I applied the two bug fixes on my local branch and found that
I still couldn't pass my test of generating and reading a heavily
fragmented file.

The root cause is that current code will treat hole blocks as mapped
blocks as well and mistakenly increment read_pages_pending, resulting
task hung in readahead.

Inside f2fs_map_blocks():

/* DIO READ and hole case, should not map the blocks. */
if (!(flag == F2FS_GET_BLOCK_DIO && is_hole && !map->m_may_create))
	map->m_flags |= F2FS_MAP_MAPPED;

it will have map->m_flags marked with F2FS_MAP_MAPPED in non-DIO and
no blocks creation context for NULL_ADDR and NEW_ADDR, except for
holes mapped to an unallocated dnode.

Personally, I think a better fix is to add a helper function
f2fs_block_needs_zeroing(). The condition could be: return true if the
current blkaddr is NULL_ADDR or NEW_ADDR.

Then we can reverse the order of the checks under the got_it: label:
first `if (f2fs_block_needs_zeroing()) ...`, and then `else if
(map->m_flags & F2FS_MAP_MAPPED)`, while keeping all the logic inside
those statements unchanged.

For the parameters of f2fs_block_needs_zeroing(), I think we can pass
`struct f2fs_map_blocks` directly, because it already contains all the
information we need. Also, if we later want to support batching
contiguous physical block mappings and bio additions inside the loop,
this signature should be more extensible.

If you think this approach makes sense, I can send a patch to fix all
three bugs. Thank you.

Best regards,
Nanzhe Zhao
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

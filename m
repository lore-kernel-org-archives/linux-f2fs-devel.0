Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 862E8CEBF61
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 17 Nov 2025 12:31:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Lv2AWnyClE+fkW/gg3uAZ870L4kfAipexpfjWYc2o/g=; b=nK1Qm5Yl0OKMvb2PP1e1G0dUah
	EIb8NV8Ja9x4OTQBvkk55ziZRD69Olv3wpJDBHhRS1CsITur/M3fEpiuKYcT25XMRO/VdqLPwWEmv
	VqaM3D7WrRawNpQJf/JjLu5+3sMn0Ywo0b5Lix29jR3tCgmxdjZbkmDB5eNqyi91+sUs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vKyOR-0006cN-Tx;
	Mon, 17 Nov 2025 12:31:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vKyOQ-0006cH-2D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Nov 2025 12:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3QVnzh4U9ULbQS6QMbWwDd/Fz2XuK/EoC3kDKiO8hX4=; b=dmaNVQvZWnM0PYN4KzoVrBVtiW
 jNf0LfyQE5sNlGVnqsMi6nOzF8Q/81JCsaBQ0+amr/iCRcjMXPUOTuzdveFSZI3tWYrjJB/6cdahR
 YmmL+JbiLi/FyYpe9jNxfdyU6Ky534aOEz2tIXwGCRMRwALXGAOKhrsk4n2mf2d0Ty3M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3QVnzh4U9ULbQS6QMbWwDd/Fz2XuK/EoC3kDKiO8hX4=; b=BD7pCFw+1U3DlSNu3xHKNfcY/9
 RXHUc7fbM3FN76rNN3NmTbL7EeclfoR0sYMVCAAnJag6RxDK/snsCQQlpi+p5fL6w8bo6JUukQNW3
 tCwx2JSfEQ7oidYMGrzilMN4E/EHjABbU6Miio+MxoxfSp2s1Dy6lK/etEMu1Tsy4WHE=;
Received: from m16.mail.126.com ([117.135.210.6])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vKyOP-0004LQ-PT for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 17 Nov 2025 12:31:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=3QVnzh4U9ULbQS6QMbWwDd/Fz2XuK/EoC3kDKiO8hX4=; b=F
 yQfClnTCmnHbot7ys2bE3GJZKe7p5Xr5exi2TSJaU186O1Obsufnn+uB6AybokeJ
 5FN8hONLDPz3ZmYd9k9bzGFCscRM+0cTldeGZrnP6mblKtVkUTrxCppRo9cx/sxQ
 vBkS8F5337f7NodKICIl4Z7zhtS1HC7WkAHrg68OA0=
Received: from nzzhao$126.com ( [112.2.251.83] ) by
 ajax-webmail-wmsvr-41-110 (Coremail) ; Mon, 17 Nov 2025 20:31:04 +0800
 (CST)
X-Originating-IP: [112.2.251.83]
Date: Mon, 17 Nov 2025 20:31:04 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Jaegeuk Kim" <jaegeuk@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20250723(a044bf12) Copyright (c) 2002-2025 www.mailtech.cn 126com
In-Reply-To: <aQ4u7PdJlnIi_tEC@google.com>
References: <20250813092131.44762-1-nzzhao@126.com>
 <20250813092131.44762-10-nzzhao@126.com> <aQUqCEfjAXubdRQk@google.com>
 <3f1f6b6.4c4a.19a4d905911.Coremail.nzzhao@126.com>
 <aQ4u7PdJlnIi_tEC@google.com>
X-NTES-SC: AL_Qu2dAf+TvU4t4imcYekfmUgRgOw3XMSyu/oi2o9UO5FwjDHj8RgAW1NvPH7W18e0AAmhqzmObTFCwcRxY5RhXK4n3vw3R1FOrjrB0DB1fZ0KMA==
MIME-Version: 1.0
Message-ID: <54569ce7.8ff5.19a91cc1ef4.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: bikvCgD3LwKJFRtp_W0gAA--.5577W
X-CM-SenderInfo: xq22xtbr6rjloofrz/1tbiExQIz2kZiAfZoQAOsJ
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1vKyOP-0004LQ-PT
Subject: Re: [f2fs-dev] [RFC PATCH 9/9] f2fs: Enable buffered read/write
 path large folios support for normal and atomic file with iomap
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
Cc: yi.zhang@huawei.com, 21cnbao@gmail.com, willy@infradead.org,
 "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


At 2025-11-08 01:39:56, "Jaegeuk Kim" <jaegeuk@kernel.org> wrote:
> I think this is the patch series coming from linux-f2fs-devel@lists.sourceforge.net?

No. The target address of this first patch was mispelled to linux-f2fs@lists.sourceforge.net,
so the root of this thread display as not found in linux-f2fs-devel@lists.sourceforge.net.
But I recently found the fact that I could see our discussion under my resent patch:
"[f2fs-dev] [RESEND RFC PATCH 0/9] f2fs: Enable buffered read/write large folios support with extended iomap"
so I guess it's ok to continue our discussion here?

I've studied encrypted file a bit, we need a to wait a range of continous blocks to being written to disk
from META MAPPING via gc during read. I saw f2fs already have `f2fs_wait_on_block_writeback_range`.
So I thougt it's not hard to support large folios for normal and encrypt in read path even if without iomap.
If we need  to support encrypt large folios via iomap, then we need to add post read processing stuff for iomap.
I've studied Mr Andrey Albershteyn's patch of add fsverity support for xfs (and iomap).I personally think the best
approach it's to make iomap support fscrypt as well along with Andrey's patch.Please check https://lore.kernel.org/
all/20250728-fsverity-v1-0-9e5443af0e34@kernel.org/

The main issue we need to address is how we implement per-block state tracking. An Ideal approach is to make iomap_folio_state 
exportable, which clearly  involves discussion with the upstream .Or  we could define a completely new, f2fs-specific folio state.

Currently my test data do not limit the maximum order of page cache's folio,considering that Android often allocates low-order folios, 
do you think we should cap the max page cache order at 2 and proceed with testing? Also, what are your thoughts on buffered writes 
and page writeback for large folios, or should we focus our discussion on the read path for now?
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

Return-Path: <SRS0=kuGz=YI=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E69AC10F14
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 15 Oct 2019 07:04:45 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5EAB5217F9;
	Tue, 15 Oct 2019 07:04:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Z8iH7+fG";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="Gv34sFHW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5EAB5217F9
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iKGsu-0007wV-Ov; Tue, 15 Oct 2019 07:04:44 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iKGss-0007wC-Un
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Oct 2019 07:04:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=P0WlEO6mTSgS7Loag0KrQWz2a0zs5WPL34uC3KwgjoU=; b=Z8iH7+fGREoBD5TW3OFTHvKwze
 sgikUXjVPy/1wwfRBAnjj5vxhRyRnkwZW/Y2enufpMn7uQctRgQApNPOQTldDYP9hQAC3Ryiff+TD
 4vVJr60ssVGaWTlE71oqtm8nZclVzdYFl1NtKdRZ4ObzWNP0ycWgEw812dg9nW6F5Uhc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=P0WlEO6mTSgS7Loag0KrQWz2a0zs5WPL34uC3KwgjoU=; b=Gv34sFHWIsYEB7MATgHs3h29xH
 GExEhFAgLditjBkS/v3iqbTww35NBhpni2S8m652epSd8ZqJiO5wvtklF58tzzIZ+dNFnRuZaV0qm
 zsP7wbTxLj8RQjJuqH25VC36KB8RTK9zNPoLj0ce9QNminbk/ejJk9gcYGO7mLjKUzhM=;
Received: from szxga04-in.huawei.com ([45.249.212.190] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iKGsr-009gaT-2a
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 15 Oct 2019 07:04:42 +0000
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 4881B785A939BC831B65;
 Tue, 15 Oct 2019 15:04:33 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.210) with Microsoft SMTP Server (TLS) id 14.3.439.0; Tue, 15 Oct
 2019 15:04:28 +0800
To: Jaegeuk Kim <jaegeuk@kernel.org>, <linux-f2fs-devel@lists.sourceforge.net>
References: <20191007163315.84634-1-jaegeuk@kernel.org>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <3ef52363-7fa5-dab1-8ff6-0169274f8398@huawei.com>
Date: Tue, 15 Oct 2019 15:04:28 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20191007163315.84634-1-jaegeuk@kernel.org>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iKGsr-009gaT-2a
Subject: Re: [f2fs-dev] [PATCH] tools/fibmap: fix build error
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2019/10/8 0:33, Jaegeuk Kim wrote:
> fibmap.c:28:10: fatal error: 'sys/sysmacros.h' file not found
>          ^~~~~~~~~~~~~~~~~
> 1 error generated.
> make[3]: *** [fibmap.o] Error 1
> make[3]: *** Waiting for unfinished jobs....
> 
> Fixes: ce64ea0815bf ("f2fs-tools: Add support for Casefolding")
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

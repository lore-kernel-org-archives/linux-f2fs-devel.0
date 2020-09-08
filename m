Return-Path: <SRS0=MrPr=CR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F421C43461
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Sep 2020 14:56:26 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 178B922525;
	Tue,  8 Sep 2020 14:56:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GRHpnPx5";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="nC3yX2ex";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="KJ9alqSC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 178B922525
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kFf2l-0002yX-Uo; Tue, 08 Sep 2020 14:56:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1kFf2l-0002yR-1T
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Sep 2020 14:56:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=9IraBddHKBi8D39cZOi4SSf6qZh84ONmGT1YEQT8fAE=; b=GRHpnPx5WyvgSmBQv7lPLIOg4x
 W0CM4xW16O0fjC5RYZsmY6QuFbpNc6+Y/vQTAfLH5pI3e3KXBicyEKrgjJsl/E8ewnAaee1ZP0w/s
 4HbKAeeYshU7DWywfxw+JGFpkZ2r54cBV39wOIZoCaP67O75cwgDiL9X6GiBVDoy8Qrg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=9IraBddHKBi8D39cZOi4SSf6qZh84ONmGT1YEQT8fAE=; b=nC3yX2ex7epfWhlHCT/SHTyDZg
 JGZkTHi1m6X/wkQJSvftchgXvimZ+AU7KMTGoFy9g25mwgKbl//sVKxPxqT7sXlW+uzxtImmrYMsw
 UkZjUMA31+sduHwNf6GcjCucobENGMv8A5ymZZHsESqAgeeKt6gq//RBkcKXvDkNwn0w=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kFf2h-00Guye-Qv
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 08 Sep 2020 14:56:23 +0000
Received: from [192.168.0.108] (unknown [117.89.211.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id DD480224D2;
 Tue,  8 Sep 2020 14:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1599576967;
 bh=9IraBddHKBi8D39cZOi4SSf6qZh84ONmGT1YEQT8fAE=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=KJ9alqSCRqr7fLiIFOLAqEQDlWFKjk6op0NHZuDAs5HzemGEsJwR7b3PMbTC7f21S
 ISKLnoQpyICXf6iOUJuSrTHhxyw0XLE1cpkoMXqxB3Zr1b8RGOCKs73XYICEspIDcM
 1R/zpGMLK0cHu5PCukycx2jhOmpoqbvUN1eYGcIA=
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20200908024411.2692388-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <7b3d9b1f-2394-6163-ada5-63e9a053475d@kernel.org>
Date: Tue, 8 Sep 2020 22:55:59 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200908024411.2692388-1-daeho43@gmail.com>
X-Headers-End: 1kFf2h-00Guye-Qv
Subject: Re: [f2fs-dev] [PATCH v3 1/2] f2fs: change i_compr_blocks of inode
 to atomic value
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

On 2020-9-8 10:44, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
>
> writepages() can be concurrently invoked for the same file by different
> threads such as a thread fsyncing the file and a kworker kernel thread.
> So, changing i_compr_blocks without protection is racy and we need to
> protect it by changing it with atomic type value. Plus, we don't need
> a 64bit value for i_compr_blocks, so just we will use a atomic value,
> not atomic64.
>
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

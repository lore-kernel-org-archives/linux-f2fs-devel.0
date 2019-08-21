Return-Path: <SRS0=qRZ7=WR=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E62CFC3A59E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Aug 2019 08:36:46 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62CC722DA7;
	Wed, 21 Aug 2019 08:36:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="lTbMitjj";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ZOyUm2PP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62CC722DA7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1i0M6o-0002Lu-1J; Wed, 21 Aug 2019 08:36:46 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1i0M6m-0002Lm-Vw
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 08:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:References:CC:To:From:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4KUdlONcgaYOMTzo7uRcndbWo+7Stlf6MrJxrLedTsE=; b=lTbMitjjxbwh52MikdBjCJlNGR
 U/aY8kD5fl0J1CqUrz1p7NPnn3VHL62S3FI8qa5YjWUOWc5brok3kYF/wrfFy8xTlm9KrJA+R1nJE
 K0+jpHBagCt/9cRQevTNiF1PGL/oyDAJqNiGM8fI/DwDCBou2JcS7krV9hqpABOzaxRE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:References:CC:To:From:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=4KUdlONcgaYOMTzo7uRcndbWo+7Stlf6MrJxrLedTsE=; b=ZOyUm2PPz6dsHatGHbnvQGbPsG
 UuKmrNku9kATTCqvWsAPqGU11pzuZ76H5+dyLt9G4eerqfx1JSkpI3h8o6eY2NoQPVFssYdg7vLum
 9gG2mJWkh5/io1OwkMWTYmGXCj8F568whC6WzauSUUt6j+6+5E54KjQCmhVsWwWFaGP4=;
Received: from szxga07-in.huawei.com ([45.249.212.35] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1i0M6h-00EJRU-3b
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 21 Aug 2019 08:36:43 +0000
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id C34EC50E668BF83BD82;
 Wed, 21 Aug 2019 16:36:31 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.206) with Microsoft SMTP Server (TLS) id 14.3.439.0; Wed, 21 Aug
 2019 16:36:26 +0800
From: Chao Yu <yuchao0@huawei.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <3bc8584e-651c-9578-c25a-40c60b5cfbdb@huawei.com>
Message-ID: <dfd847fe-0c6d-f2a1-db50-d637a685d13b@huawei.com>
Date: Wed, 21 Aug 2019 16:36:25 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <3bc8584e-651c-9578-c25a-40c60b5cfbdb@huawei.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1i0M6h-00EJRU-3b
Subject: Re: [f2fs-dev] f2fs_symlink bug
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Ping,

On 2019/8/12 20:01, Chao Yu wrote:
> Hi Jaegeuk,
> 
> In por_fsstress testcase, fsck reports below inconsistent status, I found one
> path can cause this case.
> 
> [FIX] (fsck_chk_inode_blk:1002)  --> Symlink: recover 0x1425 with i_size=4096
> [ASSERT] (fsck_chk_inode_blk:1030)  --> ino: 0x1425 chksum:0x6983d47, but
> calculated one is: 0xdb284b35
> [FIX] (fsck_chk_inode_blk:1036)  --> ino: 0x1425 recover, i_inode_checksum=
> 0x6983d47 -> 0xdb284b35
> 
> - f2fs_symlink
>  - page_symlink failed -> f2fs_write_failed() will truncate size to zero
>   - f2fs_unlink failed -> symlink inode w/o data will remain in fs
> 
> Not sure, but one choice of fix is to treat symlink as fs meta like we did for
> directory, so that checkpoint can take care of all data/node of symlink, any
> thoughts?
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
> .
> 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

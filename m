Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7686DC47BEE
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jan 2026 11:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:Message-ID:MIME-Version:References:In-Reply-To:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pQHDtwX2cW5ZZ2yiInPjVbMtJM41GIJLM3gzxjneW3Y=; b=GwTYknmQ+6qVMP3OSEmelVgSkG
	DeoHdoTWF0Vw0lWWBe2NJ2JdI6UzB9VHJ0n3aWi38QUeUckYLKee0b99V2kii9m0/a87OmvBD5piL
	+jlsjxNg5+sr7ByrZjrDNtMbyOQND/0Jbmnyl4i6/fQpp2dDXiSCYLT/Wo+ktC8DIW90=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vd5Bt-0007z7-Gj;
	Tue, 06 Jan 2026 11:25:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vd5Br-0007z0-Oz
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 11:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:References:In-Reply-To:Subject:Cc:To:From:Date:
 Sender:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QsMb+GT0oytlobEfn04k18UN9NxziTo+/+LN11MlVsk=; b=I1hx2Vy/flUbA/w/EVycte3FfX
 WcdTCJdzJT6OtH7vCz6IQXMNjdcwra3Qv10YHxyXxSr3UFbOInEDOkfiv1B9B1A0EqcuNlW4o8W9y
 yPhOcJGynkF72r0dswvMr4ZpY86fofhC0C4m3gCMQx8biT51Iu+ZmkwSGP537TpOSpig=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:References
 :In-Reply-To:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=QsMb+GT0oytlobEfn04k18UN9NxziTo+/+LN11MlVsk=; b=SQUq2KesbiPEaoYbyBbcFQQW/Y
 f8H0pyR1W6amfcOmR4kKQ3e5MAZTE1EbLcnQ539VTnkbosyOwuEyb3PVWjdTxfElbqWDcliV/ggZl
 OvFkpebQgdSvBmxTMlZgX2GirxGFK1mufrwayktb3uHtA+ET+aBZGw3Wd0E3eewMOjSQ=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vd5Bq-0001g8-MC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jan 2026 11:25:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=Date:From:To:Subject:Content-Type:MIME-Version:
 Message-ID; bh=QsMb+GT0oytlobEfn04k18UN9NxziTo+/+LN11MlVsk=; b=j
 MTgSIjnZ4mNYdqG6O7/Kn+PNBO/HK9j/OnBiiXuY2G5x3HKOCJWJRiNHTJy2ixfw
 xJLCY55xP9NcyPPvGUTCldFiaIdtk/+6CSptBLZKCsSZIkKYOLXuj9M6TUT994lS
 kmUwA5YwQlT0GfcgzPeo5LsHnWa1iKCaqMcN897VgE=
Received: from nzzhao$126.com ( [212.135.214.2] ) by
 ajax-webmail-wmsvr-41-106 (Coremail) ; Tue, 6 Jan 2026 19:25:07 +0800 (CST)
X-Originating-IP: [212.135.214.2]
Date: Tue, 6 Jan 2026 19:25:07 +0800 (CST)
From: "Nanzhe Zhao" <nzzhao@126.com>
To: "Chao Yu" <chao@kernel.org>
X-Priority: 3
X-Mailer: Coremail Webmail Server Version 2023.4-cmXT build
 20251222(83accb85) Copyright (c) 2002-2026 www.mailtech.cn 126com
In-Reply-To: <9b4f9818-f8fd-4af2-8f5e-bab768bac8c9@kernel.org>
References: <20260105153101.152892-1-nzzhao@126.com>
 <20260105153101.152892-4-nzzhao@126.com>
 <9b4f9818-f8fd-4af2-8f5e-bab768bac8c9@kernel.org>
X-NTES-SC: AL_Qu2dBfqSt08r4SmdYOkfmUgRgOw3XMSyu/oi2o9UO5FwjDvjwCM+V21RAXjJ+v2QDTK3tha2fiFe9t15RItDRYQ1SU5uwFgiq+8vR7o4OWvFrA==
MIME-Version: 1.0
Message-ID: <3e4421db.80e9.19b930db5fb.Coremail.nzzhao@126.com>
X-Coremail-Locale: zh_CN
X-CM-TRANSID: aikvCgDXnywU8VxpCfs_AA--.31092W
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsBTywmlc8RR+jQAA33
X-Coremail-Antispam: 1U5529EdanIXcx71UUUUU7vcSsGvfC2KfnxnUU==
X-Headers-End: 1vd5Bq-0001g8-MC
Subject: Re: [f2fs-dev] [PATCH v1 3/5] f2fs: add f2fs_block_needs_zeroing()
 to handle hole blocks
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
Cc: Kim Jaegeuk <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net


At 2026-01-06 17:19:14, "Chao Yu" <chao@kernel.org> wrote:
>On 1/5/2026 11:30 PM, Nanzhe Zhao wrote:

>>IIUC, f2fs_map_blocks(inode, &map, F2FS_GET_BLOCK_DEFAULT) won't map hole
>>space, or am I missing something?
>>
>>Thanks,

My fault, I missed the goto sync_out statement in default case. Thanks for pointing out.
_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

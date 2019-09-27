Return-Path: <SRS0=4iVE=XW=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B46CC4360C
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Sep 2019 03:34:51 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 458D320872;
	Fri, 27 Sep 2019 03:34:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="Wzy/IobE";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="R/2OtwWW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 458D320872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1iDh1u-0002NV-P0; Fri, 27 Sep 2019 03:34:50 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1iDh1t-0002NO-Se
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 03:34:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AfFVWTzyc9T32sU7+WnP0ncjW/RZqR1kC5Th/dxiSI8=; b=Wzy/IobEMLEh5idv/plsYi0vVh
 qnGZxocO+i21k8jIrgEFhf8ZNUtdtVrTREmvXDCtjiIH0VG6V8ndRq08+1EfwElALf2hSln+2CnqP
 iCP6DcWyV7scIBtTfgRPa9WBXCSYKFtPBengkKH5n1mnhfkbE8UJtSh+qnzFAga8IG30=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=AfFVWTzyc9T32sU7+WnP0ncjW/RZqR1kC5Th/dxiSI8=; b=R/2OtwWWk494VOwexV/HO27Bwe
 lSRx8z7YdX32lWj7HzhXknVPbWxPeYzm1rL9IJ7/hn2PjwTdWl7Q/HCp7DwPCeH8WWaGedQLX6Npw
 amhDRSwOnnfzmjbSN47DJCy6bkRZDqr7o1PrFhWN2zLW9hr/7ShXZAvpJQN6mI7qZklM=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1iDh1r-00Afsm-FN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 27 Sep 2019 03:34:49 +0000
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id 49CE71E660016AA45D6C
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 27 Sep 2019 11:34:40 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.214) with Microsoft SMTP Server (TLS) id 14.3.439.0; Fri, 27 Sep
 2019 11:34:39 +0800
To: Fabrice Fontaine <fontaine.fabrice@gmail.com>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <20190922184137.28947-1-fontaine.fabrice@gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <1a75be06-1747-fae3-06ce-b1dc29fb1442@huawei.com>
Date: Fri, 27 Sep 2019 11:34:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20190922184137.28947-1-fontaine.fabrice@gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1iDh1r-00Afsm-FN
Subject: Re: [f2fs-dev] [PATCH] mkfs/Makefile.am: fix build without blkid
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

On 2019/9/23 2:41, Fabrice Fontaine wrote:
> Commit d56232bc1640e2a3ffc412faff42cd8e77dbb8dd hardcoded -lblkid in
> libf2fs_format_la_LDFLAGS which breaks the build with --without-blkid
> option so use ${libblkid_LIBS} instead
> 
> Signed-off-by: Fabrice Fontaine <fontaine.fabrice@gmail.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

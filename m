Return-Path: <SRS0=+EsW=AS=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97AE6C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  7 Jul 2020 01:42:00 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 56BA420708;
	Tue,  7 Jul 2020 01:42:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="OM1Hm5qC";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="UwV9swOU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 56BA420708
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jsccS-0005pv-0M; Tue, 07 Jul 2020 01:42:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1jsccQ-0005pn-4V
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 01:41:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=no8XrCFr+rzBIEgR5Nm+i+BIr0eAjJ/qPLUddimeqn8=; b=OM1Hm5qCUZwG5L+vWYCM97RVCx
 cnJj2Fz7j3uKn+4hEBqQdYo76s1n6SYvjI/6fQ89ZsBvIOTAOjBhI4WTT+ot1VPOspEkYpCRFsV9T
 1vEa0YVrhig5TFPqdDXTXWi8kaIwSg8giXHppLk87LIZfbzBTFAyx+FY8glwtZOq9C6I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=no8XrCFr+rzBIEgR5Nm+i+BIr0eAjJ/qPLUddimeqn8=; b=UwV9swOUnpn3YqWO+jvjLSooTK
 vGTj3R6YXEOr2i4C/MEg8AqGlsrdjU56m79ZvD61Dr0TdXm3bxzMy37M7ZMKCAUYk86xuIySzR8nX
 kSnfHuGAjntYuqtB9cnEaGKBYqNrFZ8FdcIGHNtfjrfcCnu91BdV1AQqqo116fJedKs4=;
Received: from szxga05-in.huawei.com ([45.249.212.191] helo=huawei.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jsccO-00CmDt-95
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 07 Jul 2020 01:41:58 +0000
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.59])
 by Forcepoint Email with ESMTP id CEFE8416D08DDED7C637;
 Tue,  7 Jul 2020 09:41:47 +0800 (CST)
Received: from [10.134.22.195] (10.134.22.195) by smtp.huawei.com
 (10.3.19.211) with Microsoft SMTP Server (TLS) id 14.3.487.0; Tue, 7 Jul 2020
 09:41:45 +0800
To: lampahome <pahome.chen@mirlab.org>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <CAB3eZfvr=SXA1abObaCpcz7ONXyoCHXDSEvSCTSJ6SGnazm8dw@mail.gmail.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <faca33bd-6cd0-dd13-ad45-72eb0cd7d72c@huawei.com>
Date: Tue, 7 Jul 2020 09:41:45 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAB3eZfvr=SXA1abObaCpcz7ONXyoCHXDSEvSCTSJ6SGnazm8dw@mail.gmail.com>
Content-Language: en-US
X-Originating-IP: [10.134.22.195]
X-CFilter-Loop: Reflected
X-Headers-End: 1jsccO-00CmDt-95
Subject: Re: [f2fs-dev] If submit 2MB directIO, full or append?
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

On 2020/7/6 19:01, lampahome wrote:
> If I submit one 2MB directIO to f2fs, will f2fs find a segment which
> can fit the 2MB data, or will append it to the existing non-full
> segment?

Could you use trace system and combining codes to check f2fs behavior?

echo 1 > /sys/kernel/debug/tracing/events/f2fs/f2fs_<xxx>/enable
cat /sys/kernel/debug/tracing/trace_pipe |grep f2fs

To trace allocation, we can enable f2fs_submit_page_write tracepoint.

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

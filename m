Return-Path: <SRS0=0BeM=DQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70E3EC433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2020 01:02:32 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57168206BE;
	Fri,  9 Oct 2020 01:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="FscyKwzt";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="O72mWDGL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57168206BE
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kQgnl-0000Ik-I9; Fri, 09 Oct 2020 01:02:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <yuchao0@huawei.com>) id 1kQgnk-0000Id-BN
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 01:02:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KN+lUWwEX1xUnOSxGu4mNgVwKqkGrchYxe/eeULoNss=; b=FscyKwztClwM45/i9LgoNGgGXb
 YHg1Mu8rIfZQFW2ZUsXOYV1zmZc7cptWkzs7EYxlCsAqNTvj561iwA//Uux1zxm1qV3ifMuWy0lj2
 jXZHgC+fl5G0sLjtRRZZ43Ugqgsoq8BcUN0ArBXCJ6n3tdy3w4nj90vrQGYlHz4zJmE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:To:Subject:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KN+lUWwEX1xUnOSxGu4mNgVwKqkGrchYxe/eeULoNss=; b=O72mWDGLQjUiveH1xgXlp/TbZH
 EAX8L5ie677OHJQ95v2fpAvX/KTHRZ3FkZYMqjC4aS2jYo6dmwAUq4jVTnXwzqwTL1P7in1BVsfNF
 THplfZP3XV2qOueVmFyM1/aj6oJbPV6cu/D29tQrC+yHiSK/yiP0Tf61jv2sPMby9Vqo=;
Received: from szxga06-in.huawei.com ([45.249.212.32] helo=huawei.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1kQgnd-007nNI-EQ
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 01:02:28 +0000
Received: from DGGEMS405-HUB.china.huawei.com (unknown [172.30.72.60])
 by Forcepoint Email with ESMTP id 02596FD440B1C8BC00FA;
 Fri,  9 Oct 2020 09:02:12 +0800 (CST)
Received: from [10.136.114.67] (10.136.114.67) by smtp.huawei.com
 (10.3.19.205) with Microsoft SMTP Server (TLS) id 14.3.487.0; Fri, 9 Oct 2020
 09:02:09 +0800
To: "John A. Leuenhagen" <john@zlima12.com>,
 <linux-f2fs-devel@lists.sourceforge.net>
References: <1ba13c57-712b-6472-1adb-4f4d7539a978@zlima12.com>
From: Chao Yu <yuchao0@huawei.com>
Message-ID: <f4147e0e-b965-e3b1-fb1e-887d511f7626@huawei.com>
Date: Fri, 9 Oct 2020 09:02:09 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1ba13c57-712b-6472-1adb-4f4d7539a978@zlima12.com>
Content-Language: en-US
X-Originating-IP: [10.136.114.67]
X-CFilter-Loop: Reflected
X-Headers-End: 1kQgnd-007nNI-EQ
Subject: Re: [f2fs-dev] [PATCH] mkfs.f2fs: add -h and --help
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020/10/5 2:08, John A. Leuenhagen wrote:
> These two arguments would simply print the usage message.
> 
> Signed-off-by: John A. Leuenhagen <john@zlima12.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

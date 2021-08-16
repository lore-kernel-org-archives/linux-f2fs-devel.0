Return-Path: <SRS0=ksoz=NH=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81DD8C4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Aug 2021 01:46:24 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D8AC61288;
	Mon, 16 Aug 2021 01:46:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3D8AC61288
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mFRhm-00022b-GZ; Mon, 16 Aug 2021 01:46:22 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1mFRhc-00022K-MX
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 01:46:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=usT9ua+lox7QoPmRLEsNMlde1n1hiauXhkegU4QG9Rg=; b=NSGrq1EX4OAX8A77qKpBRo8OId
 VMvMd6eyDADraUwKfcaodNZl9Hjkx+AKlSz9FmIKOgnIsQLl3HmAfiBIGIw1G1oBl7544KN9vD29l
 UtlVcuvV8GioW5Xz2UY6rZFkLD9Bvr+tn5XUL9FEvH7Q+lfx7d5VqKDz6PArnAOtiTKk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=usT9ua+lox7QoPmRLEsNMlde1n1hiauXhkegU4QG9Rg=; b=j3o4yjjIA/YFugf2XCfZAnlKIk
 wfZ1DmA4HloyUU6O/34wsBnKMDU+clF0UWIL2X2Ytc/Jen/9fmgKbHrmRdnovY2dnZlX5y5F/bOoS
 VOdW9HCoSJacb8XhVoPocStsYFQmB/6tg9m15gnFZf8gdgOockrmqxUxlLgxHoqLGCEo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mFRhS-0008UW-5J
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 16 Aug 2021 01:46:06 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 852B361423;
 Mon, 16 Aug 2021 01:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1629078353;
 bh=SxypeM9TWK13ioZ51PaTNuaWJ0+FJZrfKlInnOOdxc8=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=TBqIfSmmtZFaKUUhJD03CwDMC/xHp3W1tDnY4nJpFKUbyOSfV/1k0Ep8NeAlTcrS9
 TU6OUaP8wQJno3hobTFj3lhKe1aXSH9DDNguOkXsWmzwgS1z4jOlB+NC5oHqr7mGzM
 kM7JwTm9AV7VeZ4y873WsvADrPuvZqh1CHO27lKj8vW0p9ZCktJTv2uIRGTLEiN7Rd
 X2KZE2q2Ypl8ozQIPFac8+P+U+wPXrb3Dsvw5JR0ifRVDcNSqd3lf9g+wq/z2wakwo
 KiWmnJtwYLYSjd9PbGYaKoO97sX5chOwudF/+xilGJVVS16q/gZM28BpfVY+xGDTmY
 ZKzWEUjKwxNJg==
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20210814103702.52405-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <a1294424-3ce8-37a4-a3b4-3252cc55458f@kernel.org>
Date: Mon, 16 Aug 2021 09:45:51 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210814103702.52405-1-frank.li@vivo.com>
Content-Language: en-US
X-Headers-End: 1mFRhS-0008UW-5J
Subject: Re: [f2fs-dev] [PATCH] f2fs: convert S_IRUGO to 0444
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/8/14 18:37, Yangtao Li wrote:
> To fix:
> WARNING: Symbolic permissions 'S_IRUGO' are not preferred. Consider using octal permissions '0444'.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

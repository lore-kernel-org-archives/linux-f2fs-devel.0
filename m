Return-Path: <SRS0=amL2=QA=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C4C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Nov 2021 06:12:31 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09864604DA;
	Sat, 13 Nov 2021 06:12:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 09864604DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mlmH5-0003Ed-Um; Sat, 13 Nov 2021 06:12:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1mlmH4-0003EX-TU
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 13 Nov 2021 06:12:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EyjUy5g35bo0qzJFkv1LW+g1uo5yo9+oI39ZlT/lFhU=; b=ZXog5Ltniu63g21NGbGzPdmwN2
 7xK8z710902pDe6ZIAGV0jsofQHBGGkHe1zoWZ/rBdsup/1CK8BUdK4S1xWGflxZVRcRDb5s7/4KW
 yBKDcDJtE8m9zhGgGcV8e/KIa2XHZF47HBCXMUZqQ5AB0Oa0jPcYU70qLAq8wvw/7MNI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EyjUy5g35bo0qzJFkv1LW+g1uo5yo9+oI39ZlT/lFhU=; b=LnoeDCmkopv7yxKQMasDxGu0Fc
 b3D/Z/h3y5m6btitydvHdUDwS18BOEjKymTAzKw0loTTFOCMAArYTkhRd3LGq2eEPgeIGaZn6pABX
 SBvGo55v3pKSKK6zVxW446gCESPzbBxkFj3DMPQNsfwGAnW8/DEuVXd/zTtPqyJ6M6ko=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mlmH5-00BSxV-Cu
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 13 Nov 2021 06:12:27 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7595C604D7;
 Sat, 13 Nov 2021 06:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1636783937;
 bh=rPBx4E6wJkekiATEQk8VeCVMk1fhVsWPVqMWOktWLq0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=IJ4aJDWIxqBeViuRE93hIVymizj6UxJkeBr2SJ6zTIjHZxqlbNOuC5GEMQDFjuzl6
 ujEGDkTsVxFZx1QdEUGXVMWOHQ44qdM9Pdutyala1TFUKIjs+zWN0GC9Hg/isdbtSS
 2XfCDisY7umSg1wZ+jT9z0KfgbrspkRFe0h1qjSE7CIHtOra2Pc9KmadjR87BX/fsK
 XBX4FvdkWwv0o7+5/4YnAe8TpwJUDio4ICiS3tVqZ/WNkprDdsrsD5wpS2jNRafnVR
 6xkN4PzTDoKtkdGd6TCA8LAxN8xBsU6gVoNNA45jm/iGILB00GnNgJRiT7aexLrnz3
 am+bleJ0x1zDg==
Message-ID: <5b1e821e-61dd-2f0f-5e3f-3cf764671fde@kernel.org>
Date: Sat, 13 Nov 2021 14:12:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Content-Language: en-US
To: Fengnan Chang <changfengnan@vivo.com>, jaegeuk@kernel.org
References: <20211110023713.5632-1-changfengnan@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20211110023713.5632-1-changfengnan@vivo.com>
X-Headers-End: 1mlmH5-00BSxV-Cu
Subject: Re: [f2fs-dev] [PATCH v3] f2fs: compress: reduce one page array
 alloc and free when write compressed page
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/11/10 10:37, Fengnan Chang wrote:
> Don't alloc new page pointers array to replace old, just use old, introduce
> valid_nr_cpages to indicate valid number of page pointers in array, try to
> reduce one page array alloc and free when write compress page.
> 
> Signed-off-by: Fengnan Chang <changfengnan@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

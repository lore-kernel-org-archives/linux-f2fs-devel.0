Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA20FF885A
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  3 May 2026 08:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MsHr1Rjj2lCO5N3AgsGisOa47HAJVCf2CcL5lDOykEA=; b=hQmHx3Lfctf1GTbAEwtqraCVa2
	TbLkiggimpG1cy2xbzt3nSKB0mRQNOXNO+2hiGp17arFSfcNrcXZu08U7Rwf6vh+zrTbtBZYqLFF4
	/L/DL8bkkIwS3OcNKic6kRdnHT++1FxDajCDE8Buzs7MKoNFwC5zr87yelcGD1w7guZs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wJSXi-0001mJ-PI;
	Sun, 03 May 2026 08:51:12 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wJSXV-0001h9-EG
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 08:50:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=k2HAp7yiljx+iIcr/SWdOtpKFAFJzMAOdzhuM7mBUNk=; b=NYyDlozKl/pKo/HRZL3Kyh41ER
 pDhS+0OtwQujzna93dtd8RdJ+Uca7AOQ/NXUOf6UqWgvk51DnTMZIxGqM/AISWsDVvviT6CZXqZNr
 o8yn+Ei+Cs8VOiGY9Cpa5hVaXzla2Hyx33PTjMeH2CjuvEKqEdBjTpNNzvzy/qkQ7L+M=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=k2HAp7yiljx+iIcr/SWdOtpKFAFJzMAOdzhuM7mBUNk=; b=b9WkoffoEhr54ZT3vDiyo6hxqT
 7CQeRwJOZ2N9P/sePGHkYrxudzjWs8okcUXs5ihyNnAFZSc0VgRlPcVhKowFZfI65uq/bVQw7JV85
 2QTXtV91UDxz1+hBFXhPixNZNmfprOv4N3NDAk/zaIQ4uoQcvhQWrsqjBmb3qVNeQuIA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wJSXS-00082T-9C for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 03 May 2026 08:50:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 9283260052
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  3 May 2026 08:50:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E123C2BCB4;
 Sun,  3 May 2026 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1777798247;
 bh=k2HAp7yiljx+iIcr/SWdOtpKFAFJzMAOdzhuM7mBUNk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=BhzAMXS+gZ6hZ/pU7OFSZ5o3XJJB7eLuZcSGpwPqeDvivutpVMek95+wdtw+oWG4z
 Gb2uldvgjetnV9DIJMvaFXzbIUFFF2+A4WS88Zt5pBE6pODE6XinOrQnvC617x/tbj
 UReJFCwEvHBV4PlHp519MWqYHcLIYcHhEcQk8cP/Tf/QGDAVV63QtxwWF2k0nG37FY
 Q1aUb6fckSuB17CtOhz8pCCDT0zGw/jEyKORQZOtMkHeUx4YXIYFWpnCQzBNIHYvJD
 GAHR4tL947Wv5oH7chVdY7JdCjQZBOfafViArz3/HWBeG4DyoAeJ672YTphn1VwUhr
 bNX6nzPoCgA4g==
Message-ID: <a1a28dc0-e046-4132-91cd-0cc4006396e0@kernel.org>
Date: Sun, 3 May 2026 16:50:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20260409134649.3693469-1-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20260409134649.3693469-1-jaegeuk@kernel.org>
X-Headers-End: 1wJSXS-00082T-9C
Subject: Re: [f2fs-dev] [PATCH] f2fs_io: fix length for setxattr
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 4/9/26 21:46, Jaegeuk Kim via Linux-f2fs-devel wrote:
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

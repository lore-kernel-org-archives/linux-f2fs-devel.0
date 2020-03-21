Return-Path: <SRS0=RYwi=5G=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F9CAC4332D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 21 Mar 2020 12:41:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F0EA20754;
	Sat, 21 Mar 2020 12:41:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="GUBkcj16";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="dqY07jWs";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="mZAqbYYE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F0EA20754
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1jFdRO-0001PH-Gt; Sat, 21 Mar 2020 12:41:26 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1jFdRM-0001P9-Mv
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:41:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SYButYYnPtTNzTsvJv/ztlsV2rT6hQCbbeI2pzlT52k=; b=GUBkcj16fS4QKewyM5++DoksgB
 bBIJvU14HosKjJb8oIhn0Tu4frT+/v/3rcoSRcXpy8tNWTqHWSjZeattIAn3W1sb2kDbJkRip8xf7
 Ec60O8cEYy9He1lBJuXgIh8sKhJ44A2RuzjP+Cnoe6MK+Y1mt75Cm4+3XquaHdqSU9hY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SYButYYnPtTNzTsvJv/ztlsV2rT6hQCbbeI2pzlT52k=; b=dqY07jWsqYp1sRasNJPp+p2mep
 dEFgtvp+XLcR1pWQU4WQX4/jPk4cUgmlg2sWW2DZ1uFxw2DZJn588C84XIIFl0HgvD7CtkeQ3lrZd
 oQcmcAagr2rsGFk0KeNpD9oH6pgbHuF+bZY5vmnAL+6oEcMm8fHEN3pKOx2+HnqZmmTA=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1jFdRL-00GJUS-5c
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 21 Mar 2020 12:41:24 +0000
Received: from [192.168.0.107] (unknown [49.65.245.234])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id B163C20754;
 Sat, 21 Mar 2020 12:41:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1584794477;
 bh=SYButYYnPtTNzTsvJv/ztlsV2rT6hQCbbeI2pzlT52k=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=mZAqbYYEyed/TRFC34Za867sHZy20DSHbKWw+pfpCOnVubLSkgdKhC74IfLXb0oQ5
 irgqnDuLIeHhDqhwmSXSHDKHRIlhYBBteSxo2x9Zg8CrGALnf5+E10sckAtjZq5EYM
 B0EReMmsHEMDlh4R+X7pNuj+kYgFVEbn3aKM9dbQ=
To: Matthew Wilcox <willy@infradead.org>,
 Andrew Morton <akpm@linux-foundation.org>
References: <20200320142231.2402-1-willy@infradead.org>
 <20200320142231.2402-20-willy@infradead.org>
From: Chao Yu <chao@kernel.org>
Message-ID: <135c3eeb-c809-08dc-8b4b-31ced90c622a@kernel.org>
Date: Sat, 21 Mar 2020 20:41:10 +0800
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20200320142231.2402-20-willy@infradead.org>
X-Headers-End: 1jFdRL-00GJUS-5c
Subject: Re: [f2fs-dev] [PATCH v9 19/25] erofs: Convert compressed files
 from readpages to readahead
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
Cc: cluster-devel@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 William Kucharski <william.kucharski@oracle.com>, linux-btrfs@vger.kernel.org,
 Dave Chinner <dchinner@redhat.com>, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-erofs@lists.ozlabs.org,
 ocfs2-devel@oss.oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2020-3-20 22:22, Matthew Wilcox wrote:
> From: "Matthew Wilcox (Oracle)" <willy@infradead.org>
>
> Use the new readahead operation in erofs.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Acked-by: Gao Xiang <gaoxiang25@huawei.com>
> Reviewed-by: Dave Chinner <dchinner@redhat.com>
> Reviewed-by: William Kucharski <william.kucharski@oracle.com>

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

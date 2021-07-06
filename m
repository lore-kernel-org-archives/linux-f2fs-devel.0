Return-Path: <SRS0=TfYr=L6=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE38EC07E96
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jul 2021 13:53:33 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8FF3A61CA6;
	Tue,  6 Jul 2021 13:53:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8FF3A61CA6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m0lW0-0000nh-F1; Tue, 06 Jul 2021 13:53:32 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from
 <BATV+7658d6c686f185282f96+6526+infradead.org+hch@casper.srs.infradead.org>)
 id 1m0lVy-0000na-EK
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Jul 2021 13:53:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YWMgMiz0NSkHLipT1VEThA/f8vA9y3xyiRXKfliC2FQ=; b=j6uoq53/d4iry9D6jDwR37nTgj
 JUO+NIRJGqWkfsSs2fS1HDQQGEUs4/UT9U1QxGTK/APmpViCW8oIQwBOQxC2xka5qjTut/mdt1uvZ
 FTp9M3JGxW4rwRldSdObI7XlVErYiJuX5QGcOYObpXKH/Pa6FnnJEH5/I3n5+5EsLSss=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=YWMgMiz0NSkHLipT1VEThA/f8vA9y3xyiRXKfliC2FQ=; b=a20yRW7fGgFzAhoEXTGL4YcfK5
 5y2F47Sho6veBySnCo3FTQTxoJbm2FORWAmhslKqg8NbEMlTmGco9NX4KCcZjSa6m+7mBxIwVzUhW
 X3/THDi44BFedp72gW84P3kyo2mCPY5CiV2grmA1ALFRgcv6/nFlGSOrmG4ymnJefZ1k=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m0lVn-00CJMn-T4
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 06 Jul 2021 13:53:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=YWMgMiz0NSkHLipT1VEThA/f8vA9y3xyiRXKfliC2FQ=; b=eEJjo64t1w7GzXpO1lD11M1r9W
 WPXSlO2KDH2Ib31wkN3RlL5OYWPdWaCfIEcbv6aUwwRwvyz3FloDabCdqH6JxLfsWDuFdBY2ZJc4T
 hXdxbvTiMvizZLyP71NAio0S8il8w1mNBOlxBsHPoT5TAuwyQjopHfQWCbqve7XkVrIhvnumyY1g5
 BClgKyBxQBK582tIev0TvyGSblgulZfmIf5irTzOU4rsWtOKhEf9aQL/+JiM9FwECdCMXdRV+JaIJ
 HJE5Qykdn8CIfeRDVmEbysxhW8fE/Gurc3ZJ47TEUDi6YORm/yzPsQ8jPTanei8ivUNU4In0eZWDT
 RPiEPZMw==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1m0lVI-00BRAt-Cl; Tue, 06 Jul 2021 13:52:50 +0000
Date: Tue, 6 Jul 2021 14:52:48 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Wang Shilong <wangshilong1991@gmail.com>
Message-ID: <YORgMAtpCBdc59cN@infradead.org>
References: <20210702140243.3615-1-wangshilong1991@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210702140243.3615-1-wangshilong1991@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1m0lVn-00CJMn-T4
Subject: Re: [f2fs-dev] [PATCH v3] fs: forbid invalid project ID
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
Cc: linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

> diff --git a/fs/ioctl.c b/fs/ioctl.c
> index 1e2204fa9963..d7edc92df473 100644
> --- a/fs/ioctl.c
> +++ b/fs/ioctl.c
> @@ -806,6 +806,8 @@ static int fileattr_set_prepare(struct inode *inode,
>  	if (err)
>  		return err;
>  
> +	if (!projid_valid(make_kprojid(&init_user_ns, fa->fsx_projid)))
> +		return -EINVAL;
>  	/*

And empty line before the comment would be nice for readability.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

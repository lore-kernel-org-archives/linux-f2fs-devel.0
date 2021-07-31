Return-Path: <SRS0=A69Z=MX=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6046AC4338F
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 00:44:25 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22E8861019
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 31 Jul 2021 00:44:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 22E8861019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1m9d72-000273-GI; Sat, 31 Jul 2021 00:44:24 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <jaegeuk@kernel.org>) id 1m9d71-00026u-5f
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:44:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gD0aQlYhuNXlQwpyPvJvCBePhLzoEMUrxvUL8Tzeq7s=; b=HCxwZYePMbaDVebDfkLNVqeJvw
 MKGe0+vhOWqnfQT6fVWH8F/25r27klwj87GxRBeFPzvWKwiF5cNC9PYxn4jcYj96V8+aZVk7gbP/y
 Qwn6BUoBgLALy7/1fVQqMsyeAulDO9CnWErcI9ENsCI/mwriVrOvWkBCF6o/o29tVetw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=gD0aQlYhuNXlQwpyPvJvCBePhLzoEMUrxvUL8Tzeq7s=; b=JnCN3x5yx2uuOyb+NW6K+CobuM
 wAMNsZn2WRt+uKaraw6AT50NgHn9Y3zSLpBGQR+Aaqs6KjWRu3CVlHmGglVOFQZ1d0bB3EWDBsxaP
 fNE8Vve3JHs6g2yVvqtved3atx+MGh/f8jBhQ/Nimt/GixSOvnJsGJoJzN6ralW/3OBo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1m9d6x-008DiW-Ju
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 31 Jul 2021 00:44:23 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 215BC60FED;
 Sat, 31 Jul 2021 00:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1627692254;
 bh=paN8p7t9akgL6K/U2ftqUCAJXEoYEwWcAUhQmb/DS6g=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=l52iEZfuhNIKrBeWevCew1f49Z07XM9/JWSVq1bydQ/O3IzOCCu4M3DUcTFku5cJE
 qXzs4QdFV5AzFG4q9u4/BLNHeJFprV4BGoYkjHmZjqyiLkvJGxK4Hhqs7B5c3NDPXy
 5C/e3kH/nPp9tjdsoHdFcWk2O8miai+YSxj0dUagwTkiLHXi78+4BTMQ006qKSLbBJ
 /WiRUTWBES0ie12B6illKaqMiEcq+8nlCJzdx0QF15YURDF+MSEPrET9yHO+OwN2I0
 tW8n55l+WDlFVv5TjnpWxCocqU2doxKeTb4Dai78x/GyFrGPIFEpwtgt7xVS2f9NZR
 Lxao7eBBGletw==
Date: Fri, 30 Jul 2021 17:44:12 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <YQSc3GEv/jQdcku8@google.com>
References: <20210730190907.2072122-1-jaegeuk@kernel.org>
 <f3331e35-9cfb-eb7b-8867-fb39f468c49d@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f3331e35-9cfb-eb7b-8867-fb39f468c49d@kernel.org>
X-Headers-End: 1m9d6x-008DiW-Ju
Subject: Re: [f2fs-dev] [PATCH] f2fs: show sbi status in debugfs/f2f/sstatus
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/31, Chao Yu wrote:
> On 2021/7/31 3:09, Jaegeuk Kim wrote:
> > We need to get sbi->s_flag to understand the current f2fs status as well.
> > One example is SBI_NEED_FSCK.
> 
> Typo in patch title: "f2f/sstatus".
> 
> Please note that there is a sysfs entry /sys/fs/f2fs/<devname/stat/sb_status.

Sure. Thanks.

> 
> > 
> > Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Reviewed-by: Chao Yu <chao@kernel.org>
> 
> Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

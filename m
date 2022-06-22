Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49BB4C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 22 Jun 2022 13:20:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o40Gy-0003or-E7; Wed, 22 Jun 2022 13:19:56 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o40Gx-0003oe-Io
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 13:19:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=l5zQMPjIk88thXpgIYmNIZ2IUQYE5OtIi/sk/FT1Cs4=; b=UI8wYBCo3P6KbkqB0CT0hvrIiM
 0kGw/WNKQyZtvBMgAQ6YkyiEsVP9TA9tX0FyeTTkfxKNdJeWPqZP491bQ7trsberzcLRJIaO+jtvc
 w/GSX23ZUqDWIblRWgrD2j28SJtYyNyP2jEnNCf1UAMvKpWhK4p20ljP9gefi+amBIKA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=l5zQMPjIk88thXpgIYmNIZ2IUQYE5OtIi/sk/FT1Cs4=; b=Y2zMkMSjLTcK14EMa/oT17XGZN
 gBRD/NQSm9StXHfb9pVsOksvKLD8CnkKTkz6Y8QME0vWHzmwBM7AfOEH7yJPzioclOhuaaMx6JxKH
 OylZ4C5D8R5+4IlMdqu0l0B/GWnYuoIde/KWinHXDcxRBacEG6x9XoRJTyiYU+05IH7s=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o40Gw-0002NG-PF
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Jun 2022 13:19:55 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 66181619B9;
 Wed, 22 Jun 2022 13:19:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE751C34114;
 Wed, 22 Jun 2022 13:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1655903988;
 bh=OhOTyLxShRkYuk3tq5f2dyvgfsUrl0xUbORq44uX4u8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fpq3FE4OJyOqFWuWfgkG4pYpYkxE+7NU7m5xPyHyGyrdShQg9OQbGZyzIgmaXhB72
 ThsvJKvsHc1H40J07daPKw8j3VgyQJCL5GZ41XM4QhOlxsLP4w0v3iD4yTfKOnvI9z
 KVzAs7Xr4E3nogpACxZrK4n71PoarW4J1/+66vE4XrZ9JrVYYOKlz78qRDo58/exhr
 9dpPbxTrdfcrQxYEL5SfGJHXgLlKFLSP1QcRcew/MBHKK3dHSLb119cpN8khhm+3TG
 DHK4kdUFCfWyUlkvX/NFHfXL4f8qcoMVvdPWyrfjTwpgztKAPSa67YeIVh1sCHvTyp
 JuGD2rK6bnUPg==
Message-ID: <81ebfa7d-e294-409c-a3a6-5acb6daeb03f@kernel.org>
Date: Wed, 22 Jun 2022 21:19:46 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Content-Language: en-US
To: qixiaoyu1 <qxy65535@gmail.com>
References: <5627a654-d605-6840-a133-e583c804aadd@kernel.org>
 <20220620084810.24885-1-qixiaoyu1@xiaomi.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220620084810.24885-1-qixiaoyu1@xiaomi.com>
X-Headers-End: 1o40Gw-0002NG-PF
Subject: Re: [f2fs-dev] [PATCH v2] resize.f2fs: add option to manually
 specify new overprovision
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
Cc: qixiaoyu1 <qixiaoyu1@xiaomi.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 liuchao12@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/6/20 16:48, qixiaoyu1 wrote:
> From: liuchao12 <liuchao12@xiaomi.com>
> 
> Make.f2fs supports manually specifying overprovision, and we expect
> resize.f2fs to support it as well.
> 
> This change add a new '-o' option to manually specify overprovision,
> and fix to check free space before grow. Otherwise, after grow,
> kernel may report below error message when we mount the image if -o
> parameter is specified during resize:
> 
> F2FS-fs (loop0): invalid crc_offset: 0
> F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
> F2FS-fs (loop0): Failed to get valid F2FS checkpoint
> mount(2) system call failed: Structure needs cleaning.
> 
> Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

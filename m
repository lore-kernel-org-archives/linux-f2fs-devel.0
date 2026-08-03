Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DF30C55174
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 03:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gaceZtFdZgfmF60U0xMn1JDLgeQ6OvbigOyCggXAt4o=; b=LgkidNqF0T/8SyRADvvuAeGime
	R6J3fOEUXJBCJ+Z7jCh4vLJwugeV0MZNaOAA/Cs+PxKKEAvFDpEES8tFJiy9Z25hvbe6ZZQzqAJll
	H1caxBvQGwB+oWIRcjverI4FPMSoJVslWwnpecqNtxNjSNnIQs2LHRZrj4trUTHWqFME=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqiyp-00060i-20;
	Mon, 03 Aug 2026 03:04:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wqiym-00060c-Hx
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 03:04:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=6fJcLy6n1zDvyoFaA5W3X+l8LTPqOlt+uZqCUBrTpg8=; b=VLJIYHKpYqN5KYYODZs6249xvl
 9vOSJI730mZ9hBK6HZyJT8MfZhC+LlAfjR07UT8K313Umsfd5fj66XfaQWvAaojwncq3LErj7Il9s
 v7FkdC9dWf7y2K6EGUQzr1zGO7e1ee+Ig8VC/OlrCWTRF6uvWNlYXYTMUxoQi9BoiFsw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=6fJcLy6n1zDvyoFaA5W3X+l8LTPqOlt+uZqCUBrTpg8=; b=k1zRpxEWHP2iW08vhL/un5AQd9
 aQn/45EHjScaW06UvTuV/lE+4RiK0HtZLWx4A9ZeDscVxOoOIM1GjU1feBra+5PPEAEhGz9qmM+J8
 bhpJgtRZ6jL5XwKDwcNbjSZQvm1qPua4LJX8guNcPneA65/FdrRspIH636olfPnhZUys=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqiyi-0006gl-2Z for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 03:04:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 71FEA41723;
 Mon,  3 Aug 2026 03:04:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8FC31F000E9;
 Mon,  3 Aug 2026 03:04:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785726270;
 bh=6fJcLy6n1zDvyoFaA5W3X+l8LTPqOlt+uZqCUBrTpg8=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=WYOZ3DWweT8JtOL+BV/9B72upY0i5oDdgjLvfvoh6TmW//MjI4txYr1gmQuKaw21/
 nQQuijkosS3SzDjTM9MltHSP6csNttR1ex0+iqh6yqmwM9cDAsgVRTX3miEoz8Ubbm
 DNzWPamAJvMs/G8VxQB7FH0/yRkpsF3UcV5i2m7NMCivhn6dCAjp2Xh+nb6KOwbAjV
 m/teh+Guo6+fugCYSlr60paaNhaRYF5/SIbgR0ktpNIhOpaInMc26oPaob+PrsHVZY
 rIJFx101GfrzA83AnfFC2AgkmgOEwhv1mLO6xXwdr8AOiJ+pJtFLIrh5kag4yyx6ww
 +nDpGFkSnJioA==
Message-ID: <8ec122ba-7c79-48b0-ac44-100c4840b5bd@kernel.org>
Date: Mon, 3 Aug 2026 11:04:26 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260630031700.2573819-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wqiyi-0006gl-2Z
Subject: Re: [f2fs-dev] [PATCH] f2fs: validate MOVE_RANGE destination size
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
Cc: stable@kernel.org, qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/30/26 11:17, Wenjie Qi wrote:
> F2FS_IOC_MOVE_RANGE checks the source range, but not the destination end
> before updating i_size. A source hole can expose this: __clone_blkaddrs()
> skips NULL_ADDR entries and returns success, so the caller can still extend
> the destination inode with unchecked pos_out + len.
> 
> Reject destination overflow and use inode_newsize_ok() before extending
> the destination inode.
> 
> Fixes: 4dd6f977fc77 ("f2fs: support an ioctl to move a range of data blocks")
> Cc: stable@kernel.org
> Assisted-by: Codex:gpt-5.5
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

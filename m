Return-Path: <SRS0=Qzrr=7J=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58CB9C433E0
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2020 21:02:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 242852075A
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 27 May 2020 21:02:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="i9ZgvuV7";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="lIo9TAVc";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="gqEJvXas"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 242852075A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1je3CJ-0007cN-70; Wed, 27 May 2020 21:02:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <jaegeuk@kernel.org>) id 1je3CH-0007c7-Ab
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 21:02:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cuG6d73b3Qtrl61FfEHP8WI8MH+P68LZHv0Rh/UFseI=; b=i9ZgvuV7PgkVlj19ig+xaKFi64
 p7aZJOt3dYL4jiCY+ZUWpnJSRlrliZh5yRWye6DkGP6tuwa1nDtqTguxn8NDHNjKcmDtSv+qZ8NVm
 B4Cizyvx/nXUDKHzX8DFL5JEa8Wxh4DyAJ5pgm8vWHuXEZ1QL5/oPBWMvY/mhI8XJgxY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cuG6d73b3Qtrl61FfEHP8WI8MH+P68LZHv0Rh/UFseI=; b=lIo9TAVcuT9pxH5dvVxB/0pTFJ
 d6OSl0EXWEIsv/fYNXhOjCaURHG3PrJxkP7qrXlXozNR/oUztnITNeIENG8OoX+zsmZv8k+w0/JSy
 xzKLUFT2iObZ+f2PfG50xwbyYcjllmKLkm8X1n2lN9exAwK26RRtQdyaRnTlkst5X4mo=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.2)
 id 1je3CB-000jjr-87
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 27 May 2020 21:02:45 +0000
Received: from localhost (unknown [104.132.1.66])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id C06A02075A;
 Wed, 27 May 2020 21:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1590613353;
 bh=ZpO0iNl8OoGkBHS2pJ/PqkCglFvOTpmwqFbqZfDiGY4=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gqEJvXasPi5lFg1/xywpRwGhcG5v/IH/172gnPF/Ty0re3g/x3sczXploZAL2VVM/
 mr9oqYQ4igDy90BmYERy8TsNN5tHyttqq4aamjX0DkSV5ehxCZVOz0iMjlIuOcWUY9
 qnzC8MZMrrdZgShG+Ao3RflypOXb7B0xhbwIBJ0o=
Date: Wed, 27 May 2020 14:02:33 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <yuchao0@huawei.com>
Message-ID: <20200527210233.GC206249@google.com>
References: <20200527102753.15743-1-yuchao0@huawei.com>
 <20200527102753.15743-3-yuchao0@huawei.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200527102753.15743-3-yuchao0@huawei.com>
X-Headers-End: 1je3CB-000jjr-87
Subject: Re: [f2fs-dev] [PATCH 3/3] f2fs: fix to cover meta flush with
 cp_lock
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

On 05/27, Chao Yu wrote:
> meta inode page should be flushed under cp_lock, fix it.

It doesn't matter for this case, yes?

> 
> Signed-off-by: Chao Yu <yuchao0@huawei.com>
> ---
>  fs/f2fs/file.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
> index f7de2a1da528..0fcae4d90074 100644
> --- a/fs/f2fs/file.c
> +++ b/fs/f2fs/file.c
> @@ -2260,7 +2260,9 @@ static int f2fs_ioc_shutdown(struct file *filp, unsigned long arg)
>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>  		break;
>  	case F2FS_GOING_DOWN_METAFLUSH:
> +		mutex_lock(&sbi->cp_mutex);
>  		f2fs_sync_meta_pages(sbi, META, LONG_MAX, FS_META_IO);
> +		mutex_unlock(&sbi->cp_mutex);
>  		f2fs_stop_checkpoint(sbi, false);
>  		set_sbi_flag(sbi, SBI_IS_SHUTDOWN);
>  		break;
> -- 
> 2.18.0.rc1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel

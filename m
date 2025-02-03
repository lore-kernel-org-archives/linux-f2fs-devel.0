Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DAA8C02192
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Feb 2025 18:32:48 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tf1FX-0007iX-Gu;
	Mon, 03 Feb 2025 18:32:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tf1FW-0007iQ-El
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Feb 2025 18:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:To:From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cIJDg/C/ecgpSPjC8flY6oGu19i35qYgFecIpE0MWh8=; b=YUA0Rdl7T7UjkMxLJkGBJmTc2V
 7rOpiO90J0mObcEBfYlQWNRNLJFEvPUe5SNQdNAk+KBQvUWT1Q8CF7ls9wFBuZ+ZDWjHYj4nAxjqQ
 5zqvFbbdYrf1IyNZFzVMczAy2s5GsdzyPxvMvBWTmtyhG1J+NajEj+3rR/Coo0B3qeQA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:To:
 From:Date:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cIJDg/C/ecgpSPjC8flY6oGu19i35qYgFecIpE0MWh8=; b=m/U3cdM22/gxo/GZD0Phyz5cQ+
 pphgGMKZ5VnAkR/GYG3dhoaofYDFd56NSbVBwCAK+ew7vNb35ltf+IInZSIsjf/QGZZCq1SdNKmpB
 LOzPax11Zz9FVpAcrM5reWoL+UMRcgIZQ8G/UsShaQUI2IZEcS6sUuhfH5vnhb98VN+0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tf1FV-0002ft-92 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Feb 2025 18:32:45 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 0F1A55C676B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon,  3 Feb 2025 18:32:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E5A1C4CED2;
 Mon,  3 Feb 2025 18:32:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1738607559;
 bh=1x9Y2xzjdl5evVpQRvkE8ycT0USK9P4w2fY5lk4AfTM=;
 h=Date:From:To:Subject:References:In-Reply-To:From;
 b=rmjK/UxDqgxhCkLC2sZ2ltCRWD1d1nJlqZrTVsftQhGh6xVzR2HuY032P0SpEaZMK
 wGAX9v4w7Q4qRTgfJfPZ25YCIm7OD28kF5km8CJ+h0BoeAYFHvhLMMSvb3jjt7QwnM
 iAkzTDVPCbCG/dA3kp9Cenamhp7N1XbFq4B4aSbtm3iZmVAeiLBcsPVN2IjBakE5xT
 7K8JAjYeuIZvOVbsu9EeKWh3GLaBNio65FYG+pp1Vu3KCGzQbReiHlPksP3PYwybEl
 T2keFdajw2YdX418++zz0/l+Iy7Ohtcb9KklW/W7hfJS0NRMQ2DDelRwBCWapkBkbL
 4nME1PzeSpztw==
Date: Mon, 3 Feb 2025 18:32:37 +0000
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Message-ID: <Z6ELxSbeYXaKIhNo@google.com>
References: <20250131222457.1634039-1-jaegeuk@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20250131222457.1634039-1-jaegeuk@kernel.org>
X-Headers-End: 1tf1FV-0002ft-92
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: don't kobject_put in the error case
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

I checked this patch is wrong. Sorry for the noise.

On 01/31, Jaegeuk Kim wrote:
> Fix a wrong kobject_put in the error path.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> ---
>  fs/f2fs/sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
> index d15c68b28952..001e97cd0a96 100644
> --- a/fs/f2fs/sysfs.c
> +++ b/fs/f2fs/sysfs.c
> @@ -1605,7 +1605,7 @@ int __init f2fs_init_sysfs(void)
>  	ret = kobject_init_and_add(&f2fs_feat, &f2fs_feat_ktype,
>  				   NULL, "features");
>  	if (ret)
> -		goto put_kobject;
> +		goto unregister_out;
>  
>  	f2fs_proc_root = proc_mkdir("fs/f2fs", NULL);
>  	if (!f2fs_proc_root) {
> @@ -1616,6 +1616,7 @@ int __init f2fs_init_sysfs(void)
>  	return 0;
>  put_kobject:
>  	kobject_put(&f2fs_feat);
> +unregister_out:
>  	kset_unregister(&f2fs_kset);
>  	return ret;
>  }
> -- 
> 2.48.1.362.g079036d154-goog


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
